return {
	{
		"folke/zen-mode.nvim",
		lazy = true,
		config = function()
			require("zen-mode").setup({})
		end,
	},
	{
		"nvim-neorg/neorg",
		-- build = ":Neorg sync-parsers",
		opts = {
			load = {
				["core.defaults"] = {}, -- Loads default behaviour
				["core.norg.concealer"] = {
					config = {
						folds = false,
					},
				}, -- Adds pretty icons to your documents
				["core.norg.dirman"] = { -- Manages Neorg workspaces
					config = {
						workspaces = {
							note = "~/Documents/notes/note",
							wcloud = "~/Documents/notes/wcloud",
						},
						default_workspace = "note",
					},
				},
				["core.norg.completion"] = {
					config = {
						engine = "nvim-cmp",
					},
				},
				["core.presenter"] = {
					config = {
						zen_mode = "zen-mode",
					},
				},
				["core.export"] = {},
				["core.export.markdown"] = {},
			},
		},
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
			{ "folke/zen-mode.nvim" },
		},
		cmd = { "Neorg" },
	},
}
