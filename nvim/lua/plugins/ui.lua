return {
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

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function(event)
					vim.schedule(function()
						require("noice.text.markdown").keys(event.buf)
					end)
				end,
			})

			opts.presets.lsp_doc_border = true
		end,
	},

	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 5000,
		},
	},

	{
		"snacks.nvim",
		opts = {
			scroll = { enabled = false },
			styles = {
				lazygit = {
					wo = { winblend = 10 },
				},
			},
		},
		keys = {},
	},

	-- buffer line
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
			{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
		},
		opts = {
			options = {
				mode = "tabs",
				separator_style = "slant",
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
			highlights = {
				-- A slant glyph is one filled diagonal: fg paints the half facing the
				-- tab, bg the half facing the bar. Both halves must be named --
				-- fg = "NONE" inherits base01 and gives a two-tone wedge.
				-- Bar colour is base03; the selected wedge carries the amber across
				-- so the pill runs solid into its points.
				fill = { fg = "#002C38", bg = "#002C38" },
				separator_selected = { fg = "#002C38", bg = "#B8912A" },
				separator_visible = { fg = "#002C38", bg = "#002C38" },
				separator = { fg = "#002C38", bg = "#002C38" },
				tab = { fg = "#576D74", bg = "#002C38" },
				background = { fg = "#576D74", bg = "#002C38" },
				tab_selected = { fg = "#000000", bg = "#B8912A", bold = true },
				-- the modified dot has its own group; without these it keeps the
				-- theme bg and shows a teal patch on the amber tab
				modified_selected = { fg = "#000000", bg = "#B8912A" },
				modified = { fg = "#576D74", bg = "#002C38" },
				modified_visible = { fg = "#576D74", bg = "#002C38" },
				buffer_selected = { fg = "#000000", bg = "#B8912A", bold = true },
				indicator_selected = { fg = "#B8912A", bg = "#B8912A" },
				warning_selected = { fg = "#000000", bg = "#B8912A" },
				warning_diagnostic_selected = { fg = "#000000", bg = "#B8912A" },
				error_selected = { fg = "#000000", bg = "#B8912A" },
				error_diagnostic_selected = { fg = "#000000", bg = "#B8912A" },
				info_selected = { fg = "#000000", bg = "#B8912A" },
				info_diagnostic_selected = { fg = "#000000", bg = "#B8912A" },
				hint_selected = { fg = "#000000", bg = "#B8912A" },
				hint_diagnostic_selected = { fg = "#000000", bg = "#B8912A" },
			},
		},
	},

	-- filename
	{
		"b0o/incline.nvim",
		dependencies = { "craftzdog/solarized-osaka.nvim" },
		event = "BufReadPre",
		priority = 1200,
		config = function()
			local colors = require("solarized-osaka.colors").setup()
			require("incline").setup({
				highlight = {
					groups = {
						InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
						InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
					},
				},
				window = { margin = { vertical = 0, horizontal = 1 } },
				hide = {
					cursorline = true,
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if filename == "" then
						filename = "[No Name]"
					end
					local modified = vim.bo[props.buf].modified

					local icon, color = require("nvim-web-devicons").get_icon_color(filename)
					local res = {
						{ icon, guifg = color },
						{ " " },
						{ filename, gui = modified and "bold,italic" or "bold" },
					}
					-- red dot instead of a [+] prefix, matching the reference screenshot
					if modified then
						res[#res + 1] = { " ● ", guifg = "#FF6E6E" }
					end
					return res
				end,
			})
		end,
	},

	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			local LazyVim = require("lazyvim.util")
			opts.sections.lualine_c[4] = {
				LazyVim.lualine.pretty_path({
					length = 0,
					relative = "cwd",
					modified_hl = "MatchParen",
					directory_hl = "",
					filename_hl = "Bold",
					modified_sign = "",
					readonly_icon = " 󰌾 ",
				}),
			}
		end,
	},

	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			plugins = {
				gitsigns = true,
				tmux = true,
				kitty = { enabled = false, font = "+2" },
			},
		},
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		enabled = false,
	},

	{
		"folke/snacks.nvim",
		opts = {
			dashboard = { enabled = false },
		},
	},
}
