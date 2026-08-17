local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Do things without affecting the registers
keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Comment line
keymap.set("n", ";q", "gcc", { desc = "Comment line", remap = true })
keymap.set("v", ";q", "gc", { desc = "Comment selection", remap = true })

-- ─── LSP actions on the ; prefix ──────────────────────────────────────────────
-- VSCode's Cmd+. is a code action; these put it (and its neighbours) on the home
-- row. ;f ;e ;r ;s ;c ;t ;; are already taken by telescope and ;q by comments,
-- so these use the free keys in the qwerty/asdf zone.
--
--   ;w  add all missing imports -- applies immediately, no menu
--   ;e  code action menu        -- the plain Cmd+. list at the cursor
--   ;a  rename symbol
--   ;g  go to definition
--   ;v  hover docs
--
-- The kind really is "source.addMissingImports.ts" -- vtsls suffixes its source
-- actions with .ts, so asking for the unsuffixed "source.addMissingImports"
-- matches nothing and silently does nothing. Both spellings are listed so this
-- keeps working if the server is swapped for ts_ls.

keymap.set("n", ";w", function()
	vim.lsp.buf.code_action({
		context = {
			only = { "source.addMissingImports.ts", "source.addMissingImports" },
			diagnostics = {},
		},
		apply = true,
	})
end, { desc = "Add all missing imports" })

keymap.set("n", ";W", function()
	vim.lsp.buf.code_action()
end, { desc = "Code Action (quick fix menu)" })

keymap.set("v", ";W", function()
	vim.lsp.buf.code_action()
end, { desc = "Code Action (selection)" })

keymap.set("n", ";a", function()
	vim.lsp.buf.rename()
end, { desc = "Rename symbol" })

keymap.set("n", ";g", function()
	vim.lsp.buf.definition()
end, { desc = "Go to definition" })

keymap.set("n", ";v", function()
	vim.lsp.buf.hover()
end, { desc = "Hover docs" })

-- File explorer (neo-tree)
keymap.set("n", "<leader>t", function()
	vim.cmd("Neotree toggle")
end, { desc = "Toggle File Explorer" })

-- Lazygit
keymap.set("n", "lg", function()
	require("snacks").lazygit({
		win = {
			width = 0.9,
			height = 0.9,
			border = "rounded",
			wo = { winblend = 0 },
		},
	})
end, { desc = "Open Lazygit" })

-- Diagnostics
keymap.set("n", "<C-j>", function()
	vim.diagnostic.goto_next()
end, opts)

keymap.set("n", "<leader>r", function()
	require("diegomaajer.hsl").replaceHexWithHSL()
end)

keymap.set("n", "<leader>i", function()
	require("diegomaajer.lsp").toggleInlayHints()
end)

vim.api.nvim_create_user_command("ToggleAutoformat", function()
	require("diegomaajer.lsp").toggleAutoformat()
end, {})
