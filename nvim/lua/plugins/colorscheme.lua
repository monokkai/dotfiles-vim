return {
	-- The active theme: solarized-osaka backgrounds + sonokai accents.
	{
		"monokkai/solarized-sonokai",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = true,
			italic_comments = true,
			terminal_colors = true,
		},
		config = function(_, opts)
			require("solarized-sonokai").setup(opts)
		end,
	},

	-- Kept installed: incline (plugins/ui.lua) and diegomaajer/hsl.lua require
	-- its colour and hsluv modules directly, so it must stay loadable even
	-- though it is no longer the active colorscheme.
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = true,
		priority = 1000,
		opts = function()
			return {
				transparent = true,
			}
		end,
	},
}
