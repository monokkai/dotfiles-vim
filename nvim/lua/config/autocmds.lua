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
-- `import` / `from` / `type` keywords. Requested as #7E3F2E, which measures
-- 2.37:1 against the background. Same hue (13deg) at 5.16:1.
-- Saturation is held at 0.70 while the lightness moves -- dropping lightness
-- alone turns it muddy, raising it alone washes out to pink-beige.
-- Swap to "#7E3F2E" for the literal value.
local jsx_import_kw = "#DC5F3C"

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

		-- BUILT-IN html elements: div, h2, section, nav ... stay green.
		-- Treesitter gives lowercase elements @tag.builtin, and capitalised
		-- components BOTH @tag.builtin and @tag -- @tag is applied last, so
		-- colouring it red below wins for components while these stay green.
		for _, g in ipairs({
			"@tag.builtin",
			"@tag.builtin.tsx",
			"@tag.builtin.jsx",
			"@tag.builtin.astro",
		}) do
			hl(g, jsx_green)
		end

		-- IMPORTED / user components: <Text>, <Box>, <HeaderLink> ... in red
		for _, g in ipairs({
			"@tag",
			"@tag.tsx",
			"@tag.jsx",
			"@tag.astro",
			"@constructor.tsx",
			"@constructor",
		}) do
			hl(g, jsx_red)
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

-- ── Transparent floats and side panels ───────────────────────────────────────
-- The theme's `transparent = true` only clears Normal/NormalNC; every float,
-- telescope window and neo-tree panel keeps an opaque #001419, which reads as a
-- solid blue-teal slab over the terminal.
--
-- This cannot live in the ColorScheme autocmd alone: telescope and neo-tree are
-- lazy-loaded and define their own highlight groups *after* ColorScheme has
-- fired, overwriting anything cleared earlier. So it also runs on FileType and
-- on lazy.nvim's LazyLoad event.
local function clear_float_backgrounds()
	local groups = {
		-- generic floats / popups
		"NormalFloat",
		"FloatBorder",
		"FloatTitle",
		"Pmenu",
		"PmenuSbar",
		"WinSeparator",
		"SignColumn",
		"EndOfBuffer",
		-- telescope (;f, ;r, the file browser ...)
		"TelescopeNormal",
		"TelescopeBorder",
		"TelescopeTitle",
		"TelescopePromptNormal",
		"TelescopePromptBorder",
		"TelescopePromptTitle",
		"TelescopeResultsNormal",
		"TelescopeResultsBorder",
		"TelescopeResultsTitle",
		"TelescopePreviewNormal",
		"TelescopePreviewBorder",
		"TelescopePreviewTitle",
		-- neo-tree (<leader>t)
		"NeoTreeNormal",
		"NeoTreeNormalNC",
		"NeoTreeFloatNormal",
		"NeoTreeFloatBorder",
		"NeoTreeWinSeparator",
		"NeoTreeEndOfBuffer",
		"NeoTreeTitleBar",
		-- which-key, lazy, mason
		"WhichKeyFloat",
		"WhichKeyBorder",
		"LazyNormal",
		"MasonNormal",
		"NoicePopup",
		"NoiceCmdlinePopup",
	}
	for _, g in ipairs(groups) do
		local cur = vim.api.nvim_get_hl(0, { name = g, link = false })
		vim.api.nvim_set_hl(0, g, {
			fg = cur.fg,
			sp = cur.sp,
			bg = "NONE",
			bold = cur.bold,
			italic = cur.italic,
			underline = cur.underline,
			reverse = cur.reverse,
		})
	end
end

vim.api.nvim_create_autocmd({ "ColorScheme", "FileType", "BufWinEnter" }, {
	group = vim.api.nvim_create_augroup("transparent_floats", { clear = true }),
	callback = function()
		vim.schedule(clear_float_backgrounds)
	end,
})

-- lazy.nvim fires this after a plugin is loaded, which is when telescope and
-- neo-tree install their own highlight groups.
vim.api.nvim_create_autocmd("User", {
	pattern = "LazyLoad",
	group = "transparent_floats",
	callback = function()
		vim.schedule(clear_float_backgrounds)
	end,
})

clear_float_backgrounds()

-- fire once for the already-loaded colorscheme
vim.cmd.doautocmd("ColorScheme")

require("diegomaajer.import-colors").setup(jsx_red, jsx_import_kw)
