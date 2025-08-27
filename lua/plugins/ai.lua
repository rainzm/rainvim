return {
	{
		"rainzm/windsurf.nvim",
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
					filetypes = { snacks_picker_input = false, vim = false },
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
			prompts = {
				---@class opencode.Prompt
				---@field description? string Description of the prompt, show in selection menu.
				---@field prompt? string The prompt to send to opencode, with placeholders for context like `@cursor`, `@buffer`, etc.
				explain = {
					description = "解释光标附近的代码",
					prompt = "解释 @cursor 及其上下文",
				},
				explain_selection = {
					description = "解释选择的代码",
					prompt = "解释 @selection",
				},
				translate_selection = {
					description = "翻译并替换",
					prompt = "将下列内容翻译为英文并替换原文：\n @selection",
				},
				fix = {
					description = "修复诊断",
					prompt = "修复这些 @diagnostics",
				},
				optimize = {
					description = "优化选择",
					prompt = "优化 @selection 的性能和可读性",
				},
				document = {
					description = "文档化选择",
					prompt = "为 @selection 添加文档注释",
				},
				test = {
					description = "为选择添加测试",
					prompt = "为 @selection 添加测试",
				},
				review_buffer = {
					description = "审查缓冲区",
					prompt = "审查 @buffer 的正确性和可读性",
				},
				review_diff = {
					description = "审查 git 差异",
					prompt = "审查以下 git 差异的正确性和可读性：\n@diff",
				},
			},
		},
        -- stylua: ignore
        keys = {
            { '<leader>oo', function() require('opencode').toggle() end, desc = 'Toggle opencode', mode = { 'n', 't' } },
            { '<leader>oa', function() require('opencode').ask() end, desc = 'Ask opencode', mode = 'n', },
            { '<leader>oc', function() require('opencode').ask('@buffer: ') end, desc = 'Ask opencode about buffer', mode = 'n', },
            { '<leader>oa', function() require('opencode').ask('@selection: ') end, desc = 'Ask opencode about selection', mode = 'v', },
            { '<leader>op', function() require('opencode').select_prompt() end, desc = 'Select prompt', mode = { 'n', 'v', }, },
            { '<leader>on', function() require('opencode').command('session_new') end, desc = 'New session', },
            { '<leader>oy', function() require('opencode').command('messages_copy') end, desc = 'Copy last message', },
            -- { '<leader>ou',  function() require('opencode').command('messages_half_page_up') end,   desc = 'Scroll messages up', },
            -- { '<leader>od', function() require('opencode').command('messages_half_page_down') end, desc = 'Scroll messages down', },
        },
	},
}
