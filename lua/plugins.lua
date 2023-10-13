local icons = require("plugins.utils.icons")

return {
	-- Library used by other plugins
	{ "nvim-lua/plenary.nvim", module = "plenary", lazy = true },
	-- Git
	{
		"tpope/vim-fugitive",
		cmd = { "G", "Git", "Gstatus", "Gblame", "Gpush", "Gpull" },
	},
	-- Better reg
	{
		"tversteeg/registers.nvim",
		opts = {
			window = {
				border = "rounded",
				transparency = 5,
			},
		},
		keys = { { '"' } },
	},
	-- Better windows
	{
		"rainzm/vim-choosewin",
		init = function()
			vim.g.choosewin_blink_on_land = 0
		end,
		cmd = { "ChooseWin", "ChooseWinCopy", "ChooseWinSwap" },
	},
	-- Better icons
	{
		"kyazdani42/nvim-web-devicons",
		module = "nvim-web-devicons",
	},
	{
		"ethanholz/nvim-lastplace",
		opts = {
			lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
			lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
			lastplace_open_folds = true,
		},
		event = { "BufReadPre" },
	},
	{
		"echasnovski/mini.bufremove",
		lazy = true,
	},
	{
		"m4xshen/smartcolumn.nvim",
		opts = {
			colorcolumn = "0",
			disabled_filetypes = { "help", "text", "go", "lua", "objc" },
			custom_colorcolumn = { norg = "100", markdown = "80" },
			scope = "line",
		},
	},
	{
		"nvim-lua/lsp-status.nvim",
		config = function()
			require("lsp-status").config({
				kind_labels = {},
				current_function = true,
				show_filename = false,
				diagnostics = false,
				indicator_separator = "",
				component_separator = " ",
				indicator_errors = icons.diagnostics.Error,
				indicator_warnings = icons.diagnostics.Warning,
				indicator_info = icons.diagnostics.Information,
				indicator_hint = icons.diagnostics.Hint,
				indicator_ok = "",
				-- spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
				status_symbol = "",
				select_symbol = nil,
				update_interval = 100,
			})
		end,
	},
}
