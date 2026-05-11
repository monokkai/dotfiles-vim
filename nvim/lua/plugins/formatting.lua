return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				-- Rust: rustfmt comes with rustup, not Mason
				rust = { "rustfmt" },
				-- Go: goimports + gofumpt installed via Mason
				go = { "goimports", "gofumpt" },
				-- Java: google-java-format
				java = { "google-java-format" },
			},
		},
	},
}
