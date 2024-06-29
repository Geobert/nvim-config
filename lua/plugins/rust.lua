return {
	{
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		tag = "stable",
		config = function()
			require("crates").setup()
		end,
	},
}
