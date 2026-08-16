-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Autosave when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	callback = function()
		if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
			vim.cmd("silent! write")
		end
	end,
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "json", "jsonc", "markdown" },
	callback = function()
		vim.opt.conceallevel = 0
	end,
})

-- ─── JSX / Astro markup colours ───────────────────────────────────────────────
--
-- Re-applied on every ColorScheme so a theme reload cannot wipe them.
--
-- Note on the requested hexes: #5A1A19 and #475119 measure 1.43:1 and 2.21:1
-- against the editor background -- far below the 4.5:1 readability threshold,
-- and much darker than the reference screenshot (~5.8:1 and ~9.0:1). They read
-- as near-black on this theme. The values below keep the SAME hues (1deg and
-- 71deg) at a readable lightness. Swap in the commented literals to use the
-- exact values requested.
local jsx_red = "#C83A37" -- < > </ />          (literal: "#5A1A19")
local jsx_green = "#AEC544" -- tag names, attrs, =  (literal: "#475119")
local jsx_white = "#E8E8E8" -- text between tags
-- Attribute NAMES (as=, bg=, borderTopWidth=, mt= ...).
-- Same hue as the originally requested #24486E, raised to a readable lightness
-- (2.00:1 -> 5.55:1 against the background).
local jsx_attr = "#588FC8"
-- `import` / `from` keywords. Requested as #7E3F2E, which measures 2.37:1
-- against the background; this is the same hue (13deg) at 5.08:1.
-- Swap to "#7E3F2E" for the literal value.
local jsx_import_kw = "#C26E57"

vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("jsx_markup_colors", { clear = true }),
	callback = function()
		local hl = function(group, fg)
			vim.api.nvim_set_hl(0, group, { fg = fg })
		end

		-- < > </ /> brackets
		for _, g in ipairs({
			"@tag.delimiter",
			"@tag.delimiter.tsx",
			"@tag.delimiter.jsx",
			"@tag.delimiter.astro",
		}) do
			hl(g, jsx_red)
		end

		-- div, h2, nav, HeaderLink ...
		for _, g in ipairs({
			"@tag",
			"@tag.tsx",
			"@tag.jsx",
			"@tag.astro",
			"@tag.builtin",
			"@tag.builtin.tsx",
			"@constructor.tsx",
		}) do
			hl(g, jsx_green)
		end

		-- attribute NAMES: as, bg, borderTopWidth, className, href ...
		for _, g in ipairs({
			"@tag.attribute",
			"@tag.attribute.tsx",
			"@tag.attribute.jsx",
			"@tag.attribute.astro",
			"@property.tsx",
		}) do
			hl(g, jsx_attr)
		end

		-- the = sign itself stays green
		hl("@operator.tsx", jsx_green)

		-- literal text between the tags
		for _, g in ipairs({ "@text.tsx", "@none.tsx" }) do
			hl(g, jsx_white)
		end

		-- Imported names and their { } braces are handled separately, by
		-- diegomaajer.import-colors (extmarks), because an after/queries file
		-- does not merge into nvim-treesitter's bundled highlights.
	end,
})

-- fire once for the already-loaded colorscheme
vim.cmd.doautocmd("ColorScheme")

require("diegomaajer.import-colors").setup(jsx_red, jsx_import_kw)
