return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		enabled = true,
		event = "InsertEnter",
		init = function()
			-- vim.g.copilot_proxy = "127.0.0.1:7890"
			vim.g.copilot_no_tab_map = true
		end,
		-- enabled = false,
		opts = {
			panel = {
				enabled = true,
				auto_refresh = false,
				keymap = {
					jump_prev = "[[",
					jump_next = "]]",
					accept = "<CR>",
					refresh = "gr",
					open = "<M-CR>",
				},
				layout = {
					position = "bottom", -- | top | left | right
					ratio = 0.4,
				},
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				debounce = 75,
				keymap = {
					accept = "<C-n>",
					accept_word = false,
					accept_line = false,
					next = "<C-]>",
					-- prev = "<C-[>",
					dismiss = "<C-\\>",
				},
			},
		},
	},
	{
		"github/copilot.vim",
		enabled = false,
		init = function()
			vim.g.copilot_proxy = "127.0.0.1:7890"
			vim.g.copilot_no_tab_map = true
			-- imap <silent> <leader>j <Plug>(copilot-next)
			-- imap <silent> <leader>k <Plug>(copilot-previous)
			vim.cmd([[
			    imap <silent><script><expr> <C-n> copilot#Accept("\<CR>")
                imap <silent> <C-\> <Plug>(copilot-dismiss)
            ]])
		end,
		config = function()
			-- imap <silent> <C-]> <Plug>(copilot-next)
			-- imap <silent> <C-[> <Plug>(copilot-previous)
		end,
	},
	{
		"Exafunction/codeium.vim",
		enabled = false,
		init = function()
			vim.g.codeium_disable_bindings = 1
			vim.g.codeium_no_map_tab = true
		end,
		config = function()
			vim.keymap.set("i", "<C-g>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
			vim.keymap.set("i", "<C-n>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<c-]>", function()
				vim.fn["codeium#CycleCompletions"](1)
				require("lualine").refresh({
					scope = "window",
					place = { "statusline" },
				})
			end, { expr = true, silent = true })
			-- vim.keymap.set("i", "<c-\\>", function()
			-- 	return vim.fn["codeium#CycleCompletions"](-1)
			-- end, { expr = true })
			vim.keymap.set("i", "<c-\\>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true, silent = true })
		end,
	},
	{
		"Exafunction/codeium.nvim",
		enabled = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({
				enable_chat = true,
			})
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		enabled = false,
		dependencies = {
			{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			window = {
				layout = "horizontal", -- | vertical
			},
			-- See Configuration section for options
		},
		-- See Commands section for default commands if you want to lazy load on them
	},
}
