-- Paint imported names and their { } braces in the JSX bracket red.
--
-- Why not a highlight query: nvim-treesitter (master) loads its own bundled
-- highlights.scm and an after/queries/ file does not get merged into it, so the
-- custom captures never reach the highlighter. Running our own query and laying
-- down extmarks in a dedicated namespace sidesteps that entirely and also lets
-- us scope strictly to import statements -- recolouring @variable or
-- @punctuation.bracket globally would repaint every identifier in the file.

local M = {}

local ns = vim.api.nvim_create_namespace("jsx_import_colors")

local QUERY = [[
  (import_statement
    (import_clause
      (named_imports
        "{" @brace
        "}" @brace)))

  (import_statement
    (import_clause
      (named_imports
        (import_specifier name: (identifier) @name))))

  (import_statement
    (import_clause
      (named_imports
        (import_specifier alias: (identifier) @name))))

  (import_statement
    (import_clause (identifier) @name))

  (import_statement
    (import_clause
      (namespace_import (identifier) @name)))

  ; the `import` and `from` keywords themselves. Scoped here rather than via
  ; @keyword.import so that `export` keeps its own colour.
  (import_statement
    "import" @keyword)

  (import_statement
    "from" @keyword)

  ; `import type { Foo }` / `import { type Foo }`
  (import_statement
    "type" @keyword)

  ; `default` in `export default ...` is plain @keyword -- the same capture as
  ; if/return/const -- so it cannot be recoloured through the theme without
  ; repainting every keyword. Scope it to export statements here instead.
  (export_statement
    "default" @keyword)

  (export_statement
    "export" @keyword)

  ; <Foo.Bar /> -- member-expression components only ever get @tag.builtin from
  ; the bundled queries, so they would stay green with the rest of the built-in
  ; html elements. Catch the object/property identifiers here instead.
  (jsx_opening_element
    name: (member_expression) @component)

  (jsx_closing_element
    name: (member_expression) @component)

  (jsx_self_closing_element
    name: (member_expression) @component)
]]

local LANGS = {
	typescriptreact = "tsx",
	javascriptreact = "tsx",
	typescript = "typescript",
	javascript = "javascript",
}

function M.highlight(buf)
	buf = buf or vim.api.nvim_get_current_buf()
	if not vim.api.nvim_buf_is_valid(buf) then
		return
	end

	local lang = LANGS[vim.bo[buf].filetype]
	if not lang then
		return
	end

	vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

	local ok, parser = pcall(vim.treesitter.get_parser, buf, lang)
	if not ok or not parser then
		return
	end

	local tree = parser:parse()[1]
	if not tree then
		return
	end

	local ok_q, query = pcall(vim.treesitter.query.parse, lang, QUERY)
	if not ok_q then
		return
	end

	for id, node in query:iter_captures(tree:root(), buf, 0, -1) do
		local capture = query.captures[id]
		local group
		if capture == "brace" then
			group = "JsxImportBrace"
		elseif capture == "keyword" then
			group = "JsxImportKeyword"
		elseif capture == "name" then
			group = "JsxImportName"
		elseif capture == "component" then
			group = "JsxComponentTag"
		end
		if not group then
			goto continue
		end
		local srow, scol, erow, ecol = node:range()
		pcall(vim.api.nvim_buf_set_extmark, buf, ns, srow, scol, {
			end_row = erow,
			end_col = ecol,
			hl_group = group,
			priority = 200, -- above treesitter's own highlights (100)
		})
		::continue::
	end
end

function M.setup(color, keyword_color)
	local function groups()
		vim.api.nvim_set_hl(0, "JsxImportName", { fg = color })
		vim.api.nvim_set_hl(0, "JsxImportBrace", { fg = color })
		vim.api.nvim_set_hl(0, "JsxImportKeyword", { fg = keyword_color })
		-- <Foo.Bar /> components share the imported-name colour
		vim.api.nvim_set_hl(0, "JsxComponentTag", { fg = color })
	end
	groups()

	local group = vim.api.nvim_create_augroup("jsx_import_colors", { clear = true })

	vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "InsertLeave" }, {
		group = group,
		callback = function(args)
			M.highlight(args.buf)
		end,
	})

	-- re-assert the groups (and repaint) when the colorscheme reloads
	vim.api.nvim_create_autocmd("ColorScheme", {
		group = group,
		callback = function()
			groups()
			M.highlight(vim.api.nvim_get_current_buf())
		end,
	})
end

return M
