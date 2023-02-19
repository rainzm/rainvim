return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/neodev.nvim",
			"williamboman/mason.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugins.lsp.config").setup()
		end,
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local icons = require("plugins.utils.icons")

			require("mason").setup({
				ui = {
					border = "rounded",
					icons = {
						package_installed = icons.lsp.server_installed,
						package_pending = icons.lsp.server_pending,
						package_uninstalled = icons.lsp.server_uninstalled,
					},
				},
				ensure_installed = {
					"stylua",
					"shellcheck",
					"shfmt",
					"flake8",
				},
			})
			require("mason-lspconfig").setup({
				automatic_installation = true,
			})
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
		--dependencies = { "mason.nvim" },
		opts = function()
			local nls = require("null-ls")
			return {
				sources = {
					-- nls.builtins.formatting.prettierd,
					nls.builtins.formatting.stylua,
					nls.builtins.diagnostics.flake8,
				},
				debug = true,
			}
		end,
	},
}
