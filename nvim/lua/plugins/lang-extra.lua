-- Languages with no LazyVim extra: swift, graphql, protobuf.
-- (astro / svelte / vue / kotlin / go / rust / java are imported as extras in
-- config/lazy.lua instead.)

return {
	-- Parsers
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, {
				"swift",
				"graphql",
				"proto",
				"kotlin",
				"vue",
				"go",
				"gomod",
				"gosum",
				"gowork",
				"rust",
				"ron",
			})
			return opts
		end,
	},

	-- Language servers
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				-- Swift: sourcekit-lsp ships with Xcode, so it is not a mason
				-- package -- it is found on PATH via xcrun.
				sourcekit = {
					cmd = { "xcrun", "sourcekit-lsp" },
					filetypes = { "swift", "objc", "objcpp" },
					root_dir = function(fname)
						return require("lspconfig.util").root_pattern(
							"Package.swift",
							"*.xcodeproj",
							"*.xcworkspace",
							".git"
						)(fname)
					end,
				},
				graphql = {
					filetypes = { "graphql", "typescriptreact", "javascriptreact", "typescript" },
				},
				-- protobuf. The mason package is "protols"; there is no
				-- "buf-language-server" in the registry.
				protols = {},
			},
		},
	},

	-- Tooling. sourcekit-lsp is deliberately absent: it comes from Xcode.
	{
		"mason-org/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, {
				"graphql-language-service-cli",
				"buf",
				"protols",
				"protolint",
			})
			return opts
		end,
	},
}
