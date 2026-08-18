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

-- Imported names, their { } braces and <Foo.Bar /> components. This is an
-- extmark pass rather than theme highlights: those need to be scoped to import
-- statements specifically, which a colorscheme cannot express. Colours are read
-- from the active theme so there is nothing to keep in sync here.
local ok, sonokai = pcall(require, "solarized-sonokai.palette")
if ok then
	local c = sonokai.palette
	require("diegomaajer.import-colors").setup(c.jsx_bracket, c.jsx_keyword)
end

-- ── Transparent tab bar ──────────────────────────────────────────────────────
-- bufferline resolves its own highlight groups from the colorscheme after the
-- ColorScheme event, and it treats a bg of "NONE" in its opts table as a colour
-- name to look up rather than "no background" -- so BufferLineFill and
-- BufferLineBackground come back opaque no matter what the spec says. Clearing
-- them directly afterwards is what actually sticks.
local function clear_tabline_bg()
	for _, g in ipairs({
		"BufferLineFill",
		"BufferLineBackground",
		"BufferLineTab",
		"BufferLineTabClose",
		-- NB: the *Selected groups are deliberately absent -- those carry the
		-- amber fill of the active tab and must stay opaque.
		-- The Separator groups are handled below, not here: a slant separator
		-- is a filled glyph whose fg paints the wedge, so clearing fg to NONE
		-- makes it fall back to black instead of disappearing.
		"BufferLineDuplicate",
		"BufferLineDuplicateVisible",
		"BufferLineModified",
		"BufferLineModifiedVisible",
		"TabLine",
		"TabLineFill",
	}) do
		local cur = vim.api.nvim_get_hl(0, { name = g, link = false })
		vim.api.nvim_set_hl(0, g, {
			fg = cur.fg,
			bg = "NONE",
			bold = cur.bold,
			italic = cur.italic,
		})
	end

	-- Slant separators: fg paints the wedge body, bg the half facing the next
	-- tab. On a transparent bar both must be NONE *together* -- setting only bg
	-- leaves fg falling back to black, which shows as a dark triangle between
	-- tabs. The selected one keeps the amber so the active pill stays solid.
	-- Slant separators are filled glyphs: fg paints the half facing the tab,
	-- bg the half facing the bar. Neither half may be NONE -- NONE means
	-- "inherit", and with a transparent bar it resolves to white, which is the
	-- pale triangle flanking each tab. Both halves are named explicitly, using
	-- the terminal's own background (#000000) for the outer half so the wedge
	-- disappears into the bar and only the slant edge is visible.
	local term_bg = "#000000"
	-- fill's fg is used for the bar's own slant edges, so it needs the same
	-- treatment -- left at NONE it renders the same white wedge.
	vim.api.nvim_set_hl(0, "BufferLineFill", { fg = term_bg, bg = term_bg })
	vim.api.nvim_set_hl(0, "BufferLineSeparator", { fg = term_bg, bg = term_bg })
	vim.api.nvim_set_hl(0, "BufferLineSeparatorVisible", { fg = term_bg, bg = term_bg })
	vim.api.nvim_set_hl(0, "BufferLineSeparatorSelected", { fg = term_bg, bg = "#B8912A" })
	vim.api.nvim_set_hl(0, "BufferLineOffsetSeparator", { fg = term_bg, bg = term_bg })
end

vim.api.nvim_create_autocmd({ "ColorScheme", "BufWinEnter", "VimEnter" }, {
	group = vim.api.nvim_create_augroup("transparent_tabline", { clear = true }),
	callback = function()
		vim.schedule(clear_tabline_bg)
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "LazyLoad",
	group = "transparent_tabline",
	callback = function()
		vim.schedule(clear_tabline_bg)
	end,
})
