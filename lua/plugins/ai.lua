return {
	{
		"rainzm/windsurf.nvim",
		enabled = false,
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
		"luozhiya/fittencode.nvim",
		enabled = true,
		config = function()
			require("fittencode").setup({
				action = {
					document_code = {
						-- Show "Fitten Code - Document Code" in the editor context menu, when you right-click on the code.
						show_in_editor_context_menu = true,
					},
					edit_code = {
						-- Show "Fitten Code - Edit Code" in the editor context menu, when you right-click on the code.
						show_in_editor_context_menu = true,
					},
					explain_code = {
						-- Show "Fitten Code - Explain Code" in the editor context menu, when you right-click on the code.
						show_in_editor_context_menu = true,
					},
					find_bugs = {
						-- Show "Fitten Code - Find Bugs" in the editor context menu, when you right-click on the code.
						show_in_editor_context_menu = true,
					},
					generate_unit_test = {
						-- Show "Fitten Code - Generate UnitTest" in the editor context menu, when you right-click on the code.
						show_in_editor_context_menu = true,
					},
					start_chat = {
						-- Show "Fitten Code - Start Chat" in the editor context menu, when you right-click on the code.
						show_in_editor_context_menu = true,
					},
					identify_programming_language = {
						-- Identify programming language of the current buffer
						-- * Unnamed buffer
						-- * Buffer without file extension
						-- * Buffer no filetype detected
						identify_buffer = true,
					},
				},
				disable_specific_inline_completion = {
					-- Disable auto-completion for some specific file suffixes by entering them below
					-- For example, `suffixes = {'lua', 'cpp'}`
					suffixes = {},
				},
				inline_completion = {
					-- Enable inline code completion.
					---@type boolean
					enable = true,
					-- Disable auto completion when the cursor is within the line.
					---@type boolean
					disable_completion_within_the_line = false,
					-- Disable auto completion when pressing Backspace or Delete.
					---@type boolean
					disable_completion_when_delete = false,
					-- Auto triggering completion
					---@type boolean
					auto_triggering_completion = true,
					-- Accept Mode
					-- Available options:
					-- * `commit` (VSCode style accept, also default)
					--   - `Tab` to Accept all suggestions
					--   - `Ctrl+Right` to Accept word
					--   - `Ctrl+Down` to Accept line
					--   - Interrupt
					--      - Enter a different character than suggested
					--      - Exit insert mode
					--      - Move the cursor
					-- * `stage` (Stage style accept)
					--   - `Tab` to Accept all staged characters
					--   - `Ctrl+Right` to Stage word
					--   - `Ctrl+Left` to Revoke word
					--   - `Ctrl+Down` to Stage line
					--   - `Ctrl+Up` to Revoke line
					--   - Interrupt(Same as `commit`, but with the following changes:)
					--      - Characters that have already been staged will be lost.
					accept_mode = "commit",
				},
				delay_completion = {
					-- Delay time for inline completion (in milliseconds).
					---@type integer
					delaytime = 0,
				},
				prompt = {
					-- Maximum number of characters to prompt for completion/chat.
					max_characters = 1000000,
				},
				chat = {
					-- Highlight the conversation in the chat window at the current cursor position.
					highlight_conversation_at_cursor = false,
					-- Style
					-- Available options:
					-- * `sidebar` (Siderbar style, also default)
					-- * `floating` (Floating style)
					style = "sidebar",
					sidebar = {
						-- Width of the sidebar in characters.
						width = 42,
						-- Position of the sidebar.
						-- Available options:
						-- * `left`
						-- * `right`
						position = "left",
					},
					floating = {
						-- Border style of the floating window.
						-- Same border values as `nvim_open_win`.
						border = "rounded",
						-- Size of the floating window.
						-- <= 1: percentage of the screen size
						-- >  1: number of lines/columns
						size = { width = 0.8, height = 0.8 },
					},
				},
				-- Enable/Disable the default keymaps in inline completion.
				use_default_keymaps = true,
				-- Default keymaps
				keymaps = {
					inline = {
						["<c-n>"] = "accept_all_suggestions",
						["<C-b>"] = "accept_line",
						--["<C-Right>"] = "accept_word",
						--["<C-Up>"] = "revoke_line",
						--["<C-Left>"] = "revoke_word",
						--["<A-\\>"] = "triggering_completion",
					},
					chat = {
						["q"] = "close",
						["[c"] = "goto_previous_conversation",
						["]c"] = "goto_next_conversation",
						["c"] = "copy_conversation",
						["C"] = "copy_all_conversations",
						["d"] = "delete_conversation",
						["D"] = "delete_all_conversations",
					},
				},
				-- Setting for source completion.
				source_completion = {
					-- Enable source completion.
					enable = false,
					-- engine support nvim-cmp and blink.cmp
					engine = "cmp", -- "cmp" | "blink"
					-- trigger characters for source completion.
					-- Available options:
					-- * A  list of characters like {'a', 'b', 'c', ...}
					-- * A function that returns a list of characters like `function() return {'a', 'b', 'c', ...}`
					trigger_chars = {},
				},
				-- Set the mode of the completion.
				-- Available options:
				-- * 'inline' (VSCode style inline completion)
				-- * 'source' (integrates into other completion plugins)
				completion_mode = "inline",
				---@class LogOptions
				log = {
					-- Log level.
					level = vim.log.levels.WARN,
					-- Max log file size in MB, default is 10MB
					max_size = 10,
				},
			})
			vim.api.nvim_set_hl(0, "FittenSuggestion", { link = "Comment" })
		end,
	},
	{
		"NickvanDyke/opencode.nvim",
		dependencies = { "folke/snacks.nvim" },
		---@type opencode.Config
		config = function()
			vim.g.opencode_opts = {
				prompts = {
                    -- stylua: ignore
                    ask_append = { prompt = "", ask = true }, -- Handy to insert context mid-prompt. Simpler than exposing every context as a prompt by default.
					ask_this = { prompt = "@this: ", ask = true, submit = true },
					diagnostics = { prompt = "解释 @diagnostics", submit = true },
					diff = {
						prompt = "检查以下 git diff 是否正确且易于阅读: @diff",
						submit = true,
					},
					document = { prompt = "增加文档注释 @this", submit = true },
					explain = { prompt = "解释 @this 及其上下文", submit = true },
					fix = { prompt = "修复 @diagnostics", submit = true },
					implement = { prompt = "实现 @this", submit = true },
					optimize = { prompt = "优化 @this 的性能和可读性", submit = true },
					review = { prompt = " @this for correctness and readability", submit = true },
					test = { prompt = "Add tests for @this", submit = true },
					translate_selection = {
						description = "翻译并替换",
						prompt = "将下列内容翻译为英文并替换原文：\n @selection",
						submit = true,
					},
				},
				provider = {
					--enabled = "snacks",
					-- terminal = {
					-- 	split = "right",
					-- 	width = math.floor(vim.o.columns * 0.5),
					-- },
					snacks = {
						win = {
							position = "right",
							-- I usually want to `toggle` and then immediately `ask` — seems like a sensible default
							width = 0.5,
							enter = false,
							keys = {
								u = function()
									require("opencode").command("session.half.page.up")
								end,
								d = function()
									require("opencode").command("session.half.page.down")
								end,
								y = function()
									require("opencode").command("messages_copy")
								end,
							},
						},
						-- env = {
						-- 	-- Other themes have visual bugs in embedded terminals: https://github.com/sst/opencode/issues/445
						-- 	OPENCODE_THEME = "system",
						-- },
					},
				},
			}
		end,
        -- stylua: ignore
        keys = {
            { '<leader>oo', function() require('opencode').toggle() end,                          desc = 'Toggle opencode', mode = { 'n', 't' } },
            { '<leader>oa', function() require('opencode').ask("@this: ", { submit = true }) end, desc = 'Ask opencode',    mode = { 'n', 'x' }, },
            -- { '<leader>oc', function() require('opencode').ask('@buffer: ') end,         desc = 'Ask opencode about buffer',    mode = 'n', },
            -- { '<leader>oa', function() require('opencode').ask('@selection: ') end,      desc = 'Ask opencode about selection', mode = 'v', },
            { '<leader>op', function() require('opencode').select() end,                          desc = 'Select prompt',   mode = { 'n', 'v', }, },
            { '<leader>on', function() require('opencode').command('session.new') end,            desc = 'New session', },
            { '<leader>ou', function() require('opencode').command('session.half.page.up') end,   desc = 'Page half up', },
            { '<leader>od', function() require('opencode').command('session.half.page.down') end, desc = 'Page half down', },
        },
	},
}
