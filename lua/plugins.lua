return {
	-- Library used by other plugins
	{ "nvim-lua/plenary.nvim", module = "plenary", lazy = true },
	-- Git
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" },
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
	-- Better IM
	-- {
	-- 	"rlue/vim-barbaric",
	-- 	init = function()
	-- 		vim.opt.ttimeoutlen = 10
	-- 		vim.g.barbaric_ime = "macos"
	-- 		vim.g.barbaric_default = "com.apple.keylayout.ABC"
	-- 		vim.g.barbaric_timeout = -1
	-- 	end,
	-- 	-- "lyokha/vim-xkbswitch",
	-- 	-- init = function()
	-- 	-- 	vim.g.XkbSwitchEnabled = 1
	-- 	-- end,
	-- 	ft = "markdown",
	-- },
	-- Better replace
	{
		"nvim-pack/nvim-spectre",
		opts = {},
		keys = {
			{
				"<Leader>rc",
				"<cmd>lua require('spectre').open_file_search()<CR>",
				desc = "Replace iterm in current file",
			},
		},
		cmd = { "Spectre" },
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
	-- commentary
	{
		"echasnovski/mini.comment",
		-- config = function()
		-- 	require("mini.comment").setup()
		-- end,
		keys = { { mode = { "v", "n" }, "gc" } },
		opts = {
			options = {
				custom_commentstring = function()
					if vim.bo.filetype == "objc" then
						return "// %s"
					else
						return vim.bo.commentstring
					end
				end,
			},
		},
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
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
}
