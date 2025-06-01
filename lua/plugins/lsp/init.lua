return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugins.lsp.config").setup()
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
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
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			local nls = require("null-ls")
			return {
				sources = {
					-- nls.builtins.formatting.prettierd,
					nls.builtins.formatting.stylua,
					-- nls.builtins.diagnostics.flake8,
				},
				debug = true,
			}
		end,
	},
}
