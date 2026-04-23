return {
	-- ── Java ─────────────────────────────────────────────────────────────────
	{
		"mfussenegger/nvim-jdtls",
		ft = { "java" },
		config = function()
			local jdtls = require("jdtls")
			local mason_path = vim.fn.stdpath("data") .. "/mason"
			local jdtls_path = mason_path .. "/packages/jdtls"
			local workspace_dir = vim.fn.stdpath("data")
				.. "/jdtls-workspace/"
				.. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

			jdtls.start_or_attach({
				cmd = {
					"java",
					"-Declipse.application=org.eclipse.jdt.ls.core.id1",
					"-Dosgi.bundles.defaultStartLevel=4",
					"-Declipse.product=org.eclipse.jdt.ls.core.product",
					"-Dlog.protocol=true",
					"-Dlog.level=ALL",
					"-Xmx4g",
					"--add-modules=ALL-SYSTEM",
					"--add-opens", "java.base/java.util=ALL-UNNAMED",
					"--add-opens", "java.base/java.lang=ALL-UNNAMED",
					"-javaagent:" .. jdtls_path .. "/lombok.jar",
					"-jar", vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
					"-configuration", jdtls_path .. "/config_mac",
					"-data", workspace_dir,
				},
				root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
				settings = {
					java = {
						inlayHints = { parameterNames = { enabled = "all" } },
						signatureHelp = { enabled = true },
						eclipse = { downloadSources = true },
						maven = { downloadSources = true },
					},
				},
			})
		end,
	},

	-- Mason: Java tools
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, {
				"jdtls",
				"google-java-format",
				"java-debug-adapter",
			})
		end,
	},

	-- ── Swift ────────────────────────────────────────────────────────────────
	-- sourcekit-lsp ships with Xcode, just wire it up
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				sourcekit = {
					filetypes = { "swift", "objc", "objcpp" },
					root_dir = function(fname)
						return require("lspconfig.util").root_pattern(
							"Package.swift", "*.xcodeproj", "*.xcworkspace", ".git"
						)(fname)
					end,
				},
			},
		},
	},

	-- Mason: Swift formatter
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "swiftformat" })
		end,
	},

	-- Format Swift + Java on save
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				swift = { "swiftformat" },
				java  = { "google-java-format" },
			},
		},
	},
}
