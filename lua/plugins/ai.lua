return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		enabled = false,
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
					accept_line = "<C-m>",
					next = "<C-]>",
					-- prev = "<C-[>",
					dismiss = "<C-\\>",
				},
			},
		},
	},
	{
		"huggingface/llm.nvim",
		enabled = false,
		config = function()
			local llm = require("llm")
			llm.setup({
				api_token = "SILICONFLOW_API_KEY",
				model = "Qwen/Qwen2.5-Coder-7B-Instruct", -- the model ID, behavior depends on backend
				backend = "ollama", -- backend ID, "huggingface" | "ollama" | "openai" | "tgi"
				url = "https://api.siliconflow.cn",
				request_body = {
					parameters = {
						max_new_tokens = 60,
						temperature = 0.2,
						top_p = 0.95,
					},
				},
				context_window = 4096, -- max number of tokens for the context window
				enable_suggestions_on_startup = true,
				enable_suggestions_on_files = "*", -- pattern matching syntax to enable suggestions on specific files, either a string or a list of strings
				disable_url_path_completion = false, -- cf Backend
				lsp = {
					bin_path = nil,
					host = nil,
					port = nil,
					cmd_env = { LLM_LOG_LEVEL = "DEBUG" },
					version = "0.5.3",
				},
			})
		end,
	},
	{
		{
			"milanglacier/minuet-ai.nvim",
			--"BohdaR/minuet-ai.nvim",
			enabled = false,
			config = function()
				require("minuet").setup({
					virtualtext = {
						auto_trigger_ft = { "*" },
						auto_trigger_ignore_ft = { "snacks_picker_input" },
						keymap = {
							-- accept whole completion
							accept = "<c-n>",
							-- accept one line
							accept_line = "<c-b>",
							-- accept n lines (prompts for number)
							-- e.g. "A-z 2 CR" will accept 2 lines
							accept_n_lines = "<c-;>",
							-- Cycle to prev completion item, or manually invoke completion
							prev = nil,
							-- Cycle to next completion item, or manually invoke completion
							next = "<C-]>",
							dismiss = "<C-\\>",
						},
						show_on_completion_menu = true,
					},
					provider = "openai_fim_compatible",
					n_completions = 3, -- recommend for local model for resource saving
					-- I recommend beginning with a small context window size and incrementally
					-- expanding it, depending on your local computing power. A context window
					-- of 512, serves as an good starting point to estimate your computing
					-- power. Once you have a reliable estimate of your local computing power,
					-- you should adjust the context window to a larger value.
					context_window = 1024,
					-- request_timeout = 2.5,
					-- throttle = 1500, -- Increase to reduce costs and avoid rate limits
					-- debounce = 600, -- Increase to reduce costs and avoid rate limits
					provider_options = {
						openai_compatible = {
							api_key = "ZHIPU_API_KEY",
							end_point = "https://open.bigmodel.cn/api/paas/v4/chat/completions",
							model = "glm-4.5-airx",
							name = "ZHIPU",
							optional = {
								max_tokens = 56,
								top_p = 0.9,
								provider = {
									-- Prioritize throughput for faster completion
									sort = "throughput",
								},
							},
							-- For Windows users, TERM may not be present in environment variables.
							-- Consider using APPDATA instead.
						},
						openai_fim_compatible = {
							api_key = "SILICONFLOW_API_KEY",
							name = "Qwen",
							end_point = "https://api.siliconflow.cn/v1/completions",
							--model = "Pro/Qwen/Qwen2.5-Coder-7B-Instruct",
							model = "Qwen/Qwen2.5-Coder-7B-Instruct",
							optional = {
								max_tokens = 56,
								top_p = 0.9,
							},
						},
						-- openai_fim_compatible = {
						-- 	api_key = "ALIYUN_API_KEY",
						-- 	name = "ALIYUN",
						-- 	end_point = "https://dashscope.aliyuncs.com/compatible-mode/v1/completions",
						-- 	--model = "Pro/Qwen/Qwen2.5-Coder-7B-Instruct",
						-- 	model = "qwen3-coder-30b-a3b-instruct",
						-- 	optional = {
						-- 		max_tokens = 256,
						-- 		top_p = 0.9,
						-- 	},
						-- },
					},
				})
			end,
		},
		{ "nvim-lua/plenary.nvim" },
	},
	{
		"ggml-org/llama.vim",
		enabled = false,
		init = function()
			vim.g.llama_config = {
				keymap_accept_full = "<C-n>",
				keymap_accept_line = "<C-b>",
				keymap_accept_word = "<C-v>",
				show_info = 0,
			}
			vim.api.nvim_set_hl(0, "llama_hl_hint", { fg = "#928374", ctermfg = 245 })
		end,
	},
	{
		"Exafunction/windsurf.nvim",
		enabled = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("codeium").setup({
				-- Optionally disable cmp source if using virtual text only
				enable_cmp_source = false,
				enable_chat = false,
				virtual_text = {
					enabled = true,
					manual = false,
					filetypes = { snacks_picker_input = false },
					default_filetype_enabled = true,
					idle_delay = 75,
					-- Priority of the virtual text. This usually ensures that the completions appear on top of
					-- other plugins that also add virtual text, such as LSP inlay hints, but can be modified if
					-- desired.
					virtual_text_priority = 65535,
					-- Set to false to disable all key bindings for managing completions.
					map_keys = true,
					-- The key to press when hitting the accept keybinding but no completion is showing.
					-- Defaults to \t normally or <c-n> when a popup is showing.
					accept_fallback = nil,
					-- Key bindings for managing completions in virtual text mode.
					key_bindings = {
						accept = "<C-n>",
						accept_word = false,
						accept_line = "<C-b>",
						next = "<C-]>",
						prev = false,
						clear = "<C-\\>",
					},
				},
			})
		end,
	},
	{
		"NickvanDyke/opencode.nvim",
		dependencies = { "folke/snacks.nvim" },
		---@type opencode.Config
		opts = {
			terminal = {
				-- No reason to prefer normal mode - can't scroll TUI like a normal buffer
				--auto_insert = true,
				win = {
					position = "right",
					-- I usually want to `toggle` and then immediately `ask` — seems like a sensible default
					width = 0.3,
					enter = false,
					keys = {
						u = function()
							require("opencode").command("messages_half_page_up")
						end,
						d = function()
							require("opencode").command("messages_half_page_down")
						end,
						y = function()
							require("opencode").command("messages_copy")
						end,
					},
				},
				env = {
					-- Other themes have visual bugs in embedded terminals: https://github.com/sst/opencode/issues/445
					OPENCODE_THEME = "system",
				},
			},

			-- Your configuration, if any
		},
        -- stylua: ignore
        keys = {
            { '<leader>ot', function() require('opencode').toggle() end,                 desc = 'Toggle embedded opencode',     mode = 'n' },
            { '<leader>oa', function() require('opencode').ask() end,                    desc = 'Ask opencode',                 mode = 'n', },
            { '<leader>oc', function() require('opencode').ask('@buffer: ') end,         desc = 'Ask opencode about buffer',    mode = 'n', },
            { '<leader>oa', function() require('opencode').ask('@selection: ') end,      desc = 'Ask opencode about selection', mode = 'v', },
            { '<leader>op', function() require('opencode').select_prompt() end,          desc = 'Select prompt',                mode = { 'n', 'v', }, },
            { '<leader>on', function() require('opencode').command('session_new') end,   desc = 'New session', },
            { '<leader>oy', function() require('opencode').command('messages_copy') end, desc = 'Copy last message', },
            -- { '<leader>ou',  function() require('opencode').command('messages_half_page_up') end,   desc = 'Scroll messages up', },
            -- { '<leader>od', function() require('opencode').command('messages_half_page_down') end, desc = 'Scroll messages down', },
        },
	},
}
