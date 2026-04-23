return {
	{
		"nvimdev/dashboard-nvim",
		enabled = false,
	},
	{
		"nvim-lualine/lualine.nvim",
		enabled = true,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		opts = {
			options = {
				theme = "sonokai",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				globalstatus = true,
				disabled_filetypes = { statusline = { "dashboard", "NvimTree" } },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					{ "branch" },
					{ "diff", symbols = { added = " ", modified = " ", removed = " " } },
					{ "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " } },
				},
				lualine_c = {
					{ "filename", path = 1, symbols = { modified = " ●", readonly = " ", unnamed = "[No Name]" } },
				},
				lualine_x = {
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
				lualine_y = { { "progress" } },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
		},
	},
	-- messages, cmdline and the popupmenu
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})
			local focused = true
			vim.api.nvim_create_autocmd("FocusGained", {
				callback = function()
					focused = true
				end,
			})
			vim.api.nvim_create_autocmd("FocusLost", {
				callback = function()
					focused = false
				end,
			})
			table.insert(opts.routes, 1, {
				filter = {
					cond = function()
						return not focused
					end,
				},
				view = "notify_send",
				opts = { stop = false },
			})

			opts.commands = {
				all = {
					-- options for the message history that you get with `:Noice`
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {},
				},
			}

			opts.presets.lsp_doc_border = true
		end,
	},

	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 5000,
			background_colour = "#000000",
			render = "wrapped-compact",
		},
	},

	-- buffer line
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"lewis6991/gitsigns.nvim",
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		event = "VeryLazy",
		keys = {
			{ "<Tab>", "<Cmd>BufferNext<CR>", desc = "Next buffer" },
			{ "<S-Tab>", "<Cmd>BufferPrev<CR>", desc = "Prev buffer" },
			{ "<leader>bd", "<Cmd>BufferClose<CR>", desc = "Close buffer" },
			{ "<leader>bp", "<Cmd>BufferPick<CR>", desc = "Pick buffer" },
		},
		opts = {
			animation = true,
			auto_hide = false,
			tabpages = true,
			clickable = true,
			icons = {
				buffer_index = true,
				buffer_number = false,
				button = "",
				diagnostics = {
					[vim.diagnostic.severity.ERROR] = { enabled = true, icon = " " },
					[vim.diagnostic.severity.WARN] = { enabled = false },
				},
				gitsigns = {
					added = { enabled = true, icon = "+" },
					changed = { enabled = true, icon = "~" },
					deleted = { enabled = true, icon = "-" },
				},
				filetype = { custom_colors = false, enabled = true },
				separator = { left = "", right = "" },
				separator_at_end = true,
				modified = { button = "●" },
				pinned = { button = "", filename = true },
				preset = "powerline",
				alternate = { filetype = { enabled = false } },
				current = { buffer_index = true },
				inactive = { button = "" },
				visible = { modified = { buffer_number = false } },
			},
			highlight_alternate = false,
			highlight_inactive_file_icons = false,
			highlight_visible = true,
			insert_at_end = false,
			maximum_padding = 1,
			minimum_padding = 1,
			maximum_length = 30,
			semantic_letters = true,
			sidebar_filetypes = {
				NvimTree = true,
			},
			letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",
			no_name_title = nil,
		},
		config = function(_, opts)
			require("barbar").setup(opts)

			local tab_active = "#434560"
			local fg_active = "#fc9867"
			local fg_inactive = "#6e7090"
			local fg_visible = "#e8e9f0"

			vim.api.nvim_set_hl(0, "BufferCurrent",        { bg = tab_active,   fg = fg_active,   bold = true })
			vim.api.nvim_set_hl(0, "BufferCurrentIndex",   { bg = tab_active,   fg = fg_active,   bold = true })
			vim.api.nvim_set_hl(0, "BufferCurrentMod",     { bg = tab_active,   fg = "#ffd866",   bold = true })
			vim.api.nvim_set_hl(0, "BufferCurrentSign",    { bg = tab_active,   fg = "#78dce8" })
			vim.api.nvim_set_hl(0, "BufferCurrentIcon",    { bg = tab_active })

			vim.api.nvim_set_hl(0, "BufferVisible",        { bg = "NONE",       fg = fg_visible })
			vim.api.nvim_set_hl(0, "BufferVisibleIndex",   { bg = "NONE",       fg = fg_visible })
			vim.api.nvim_set_hl(0, "BufferVisibleMod",     { bg = "NONE",       fg = "#ffd866" })
			vim.api.nvim_set_hl(0, "BufferVisibleSign",    { bg = "NONE",       fg = "#78dce8" })
			vim.api.nvim_set_hl(0, "BufferVisibleIcon",    { bg = "NONE" })

			vim.api.nvim_set_hl(0, "BufferInactive",       { bg = "NONE",       fg = fg_inactive })
			vim.api.nvim_set_hl(0, "BufferInactiveIndex",  { bg = "NONE",       fg = fg_inactive })
			vim.api.nvim_set_hl(0, "BufferInactiveMod",    { bg = "NONE",       fg = "#ffd866" })
			vim.api.nvim_set_hl(0, "BufferInactiveSign",   { bg = "NONE",       fg = fg_inactive })
			vim.api.nvim_set_hl(0, "BufferInactiveIcon",   { bg = "NONE" })

			-- Powerline separators — NONE bg = truly transparent
			vim.api.nvim_set_hl(0, "BufferCurrentLeft",    { bg = "NONE",       fg = tab_active })
			vim.api.nvim_set_hl(0, "BufferCurrentRight",   { bg = "NONE",       fg = tab_active })
			vim.api.nvim_set_hl(0, "BufferVisibleLeft",    { bg = "NONE",       fg = fg_inactive })
			vim.api.nvim_set_hl(0, "BufferVisibleRight",   { bg = "NONE",       fg = fg_inactive })
			vim.api.nvim_set_hl(0, "BufferInactiveLeft",   { bg = "NONE",       fg = fg_inactive })
			vim.api.nvim_set_hl(0, "BufferInactiveRight",  { bg = "NONE",       fg = fg_inactive })

			-- Tabline fill = fully transparent
			vim.api.nvim_set_hl(0, "BufferTabpageFill",    { bg = "NONE",       fg = "NONE" })
			vim.api.nvim_set_hl(0, "BufferTabpages",       { bg = tab_active,   fg = "#ab9df2", bold = true })
		end,
	},

	-- filename
	{
		"b0o/incline.nvim",
		dependencies = {},
		event = "BufReadPre",
		priority = 1200,
		config = function()
			local helpers = require("incline.helpers")
			require("incline").setup({
				window = {
					padding = 0,
					margin = { horizontal = 0 },
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
					local modified = vim.bo[props.buf].modified
					local buffer = {
						ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) }
							or "",
						" ",
						{ filename, gui = modified and "bold,italic" or "bold" },
						" ",
						guibg = "#363944",
					}
					return buffer
				end,
			})
		end,
	},
	-- LazyGit integration with Telescope
	{
		"kdheepak/lazygit.nvim",
		keys = {
			{
				";c",
				":LazyGit<Return>",
				silent = true,
				noremap = true,
			},
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
		end,
		keys = {
			{

				"<leader>d",
				"<cmd>NvimTreeClose<cr><cmd>tabnew<cr><bar><bar><cmd>DBUI<cr>",
			},
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup({
				on_attach = function(bufnr)
					local api = require("nvim-tree.api")

					local function opts(desc)
						return {
							desc = "nvim-tree: " .. desc,
							buffer = bufnr,
							noremap = true,
							silent = true,
							nowait = true,
						}
					end

					-- default mappings
					api.config.mappings.default_on_attach(bufnr)

					-- custom mappings
					vim.keymap.set("n", "t", api.node.open.tab, opts("Tab"))
				end,
				actions = {
					open_file = {
						quit_on_open = true,
					},
				},
				sort = {
					sorter = "case_sensitive",
				},
				view = {
					width = 30,
					relativenumber = true,
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = true,
					custom = {
						"node_modules/.*",
					},
				},
				log = {
					enable = true,
					truncate = true,
					types = {
						diagnostics = true,
						git = true,
						profile = true,
						watcher = true,
					},
				},
			})

			if vim.fn.argc(-1) == 0 then
				vim.cmd("NvimTreeFocus")
			end
		end,
	},
}
