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
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false,
		enabled = true,
		opts = {
			provider = "deepseek",
			auto_suggestions_provider = "deepseek",
			openai = {
				endpoint = "https://api.zhizengzeng.com",
				model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
				timeout = 30000, -- timeout in milliseconds
				temperature = 0, -- adjust if needed
				max_tokens = 4096,
			},
			vendors = {
				deepseek = {
					__inherited_from = "openai",
					endpoint = "https://api.siliconflow.cn",
					model = "Pro/deepseek-ai/DeepSeek-V3",
					api_key_name = "SF_API_KEY",
					timeout = 30000, -- timeout in milliseconds
					temperature = 0, -- adjust if needed
					max_tokens = 4096,
				},
			},
			behaviour = {
				auto_suggestions = false,
			},
			mappings = {
				--- @class AvanteConflictMappings
				suggestion = {
					accept = "<C-n>",
					next = "<C-]>",
					prev = "<M-[>",
					dismiss = "<C-\\>",
				},
			},
		},
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"echasnovski/mini.pick", -- for file_selector provider mini.pick
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua",
			"HakonHarnes/img-clip.nvim",
			"MeanderingProgrammer/render-markdown.nvim",
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
		--branch = "canary",
		--version = "2.0.0-1",
		version = "v2.*",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
			{ "nvim-telescope/telescope.nvim" },
		},
		event = "VeryLazy",
		config = function()
			-- local select = require("CopilotChat.select")
			require("CopilotChat").setup({
				-- debug = true, -- Enable debugging
				window = {
					--layout = "float", -- 'vertical', 'horizontal', 'float'
					layout = "horizontal", -- 'vertical', 'horizontal', 'float'
				},
				show_help = false,
				prompts = {
					Explain = {
						prompt = "/COPILOT_EXPLAIN 为上述代码写一段文字说明。",
					},
					Tests = {
						prompt = "/COPILOT_TESTS 为上述代码编写一套详细的单元测试函数。",
					},
					Fix = {
						prompt = "/COPILOT_FIX 这段代码存在一个问题。请重写代码，展示修复后的结果。",
					},
					Optimize = {
						prompt = "/COPILOT_REFACTOR 优化选定的代码以提高性能和可读性。",
					},
					Docs = {
						prompt = "/COPILOT_REFACTOR Write documentation for the selected code. The reply should be a codeblock containing the original code with the documentation added as comments. Use the most appropriate documentation style for the programming language used (e.g. JSDoc for JavaScript, docstrings for Python etc.",
					},
					BeterNamings = {
						prompt = "Please provide better names for the following variables and functions.",
					},
				},
				mappings = {
					close = {
						normal = "q",
						insert = "<C-c>",
					},
					submit_prompt = {
						normal = "<CR>",
						insert = "<leader>m",
					},
				},
				-- See Configuration section for rest
			})
			-- See Commands section for default commands if you want to lazy load on them
		end,
		keys = {
			{
				"<leader>as",
				function()
					local chat = require("CopilotChat")
					chat.open({
						window = {
							layout = "horizontal",
						},
					})
				end,
			},
			{
				"<leader>av",
				function()
					local chat = require("CopilotChat")
					chat.open({
						window = {
							layout = "vertical",
						},
					})
				end,
			},
			{
				"<leader>ae",
				"<cmd>CopilotChatExplain<cr>",
				mode = { "n", "v" },
				desc = "CopilotChat - Explain the selected code",
			},
			{
				"<leader>am",
				"<cmd>CopilotChatCommit<cr>",
				desc = "CopilotChat - Generate commit message for all changes",
			},
			{
				"<leader>aM",
				"<cmd>CopilotChatCommitStaged<cr>",
				desc = "CopilotChat - Generate commit message for staged changes",
			},
			{
				"<leader>ah",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.help_actions())
				end,
				mode = { "n", "v" },
				desc = "CopilotChat - Help actions",
			},
			-- Show prompts actions with telescope
			{
				"<leader>ap",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
				end,
				mode = { "n", "v" },
				desc = "CopilotChat - Prompt actions",
			},
		},
	},
}
