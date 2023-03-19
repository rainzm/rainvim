return {
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			lsp_diag_hdlr = false,
			luasnip = true,
			icons = false, -- { breakpoint = "⛔", currentpos = "👉" },
			verbose = true,
			dap_debug_keymap = false,
			dap_debug_gui = {
				icons = {
					expanded = "",
					collapsed = "",
				},
				mappings = {
					-- Use a table to apply multiple mappings
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
				},
				expand_lines = false,
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.5 },
							{ id = "breakpoints", size = 0.2 },
							{ id = "watches", size = 0.3 },
						},
						size = 50,
						open_on_start = true,
						position = "left", -- Can be "left" or "right"
					},
					{
						--open_on_start = false,
						elements = {
							"repl",
							--"console",
						},
						size = 0.25, -- 25% of total lines
						position = "bottom", -- Can be "bottom" or "top"
					},
				},
				floating = {
					max_height = nil, -- These can be integers or a float between 0 and 1.
					max_width = nil, -- Floats will be treated as percentage of your screen.
					border = "rounded",
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				windows = { indent = 1 },
			},
			dap_debug_vt = false,
		},
		--event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		--build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},
}
