return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			width = 60,
			sections = {
				{ section = "header" },
				--{ section = "keys", gap = 1, padding = 1 },
				{ section = "keys", gap = 1, padding = 2 },
				--{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = { 2, 2 } },
				{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
				{ section = "startup" },
			},
			preset = {
				keys = {
					{
						icon = " ",
						key = "f",
						desc = "Find File",
						action = ":lua Snacks.dashboard.pick('files', { layout = { preset = 'rainselect'}})",
					},
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = ":lua Snacks.dashboard.pick('live_grep', { layout = { preset = 'rain'}})",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						--action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config'), layout = { preset = 'rain'}})",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
					{
						icon = "󰒲 ",
						key = "L",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
		},
		explorer = {
			enabled = true,
			replace_netrw = true,
			win = {
				list = {
					keys = {
						["w"] = "pick_win, jump",
					},
				},
			},
		},
		indent = { enabled = false },
		input = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		image = {
			enabled = true,
			doc = {
				enabled = true,
				inline = false,
				float = false,
			},
		},
		picker = {
			enabled = true,
			sources = {
				explorer = {
					win = {
						list = {
							keys = {
								["n"] = "explorer_add",
								["v"] = { { "pick_win", "edit_vsplit" }, mode = { "i", "n" } },
								["s"] = { { "pick_win", "edit_split" }, mode = { "i", "n" } },
							},
						},
					},
				},
				projects = {
					dev = { "~/code" },
					win = {
						input = {
							keys = {
								["<C-d>"] = { "delete_projects", mode = { "n", "i" } },
							},
						},
					},
				},
			},
			actions = {
				delete_projects = function(picker, _)
					Snacks.picker.actions.close(picker)
					local items = picker:selected({ fallback = true })
					local what = #items == 1 and items[1].file or #items .. " projects"
					vim.notify("Deleting " .. what .. " from ShaDa...", vim.log.levels.INFO)
					vim.cmd("redraw")
					vim.defer_fn(function()
						vim.cmd("edit " .. vim.fn.stdpath("state") .. "/shada/main.shada")
						local deleted = 0
						for _, item in ipairs(items) do
							local regex = "^\\S\\(\\n\\s\\|[^\\n]\\)\\{-}"
								.. vim.fn.escape(item.file, "/\\")
								.. "\\_.\\{-}\\n*\\ze\\(^\\S\\|\\%$\\)"
							-- Search for entries and count how many will be deleted
							vim.cmd("/" .. regex)
							deleted = deleted + vim.fn.searchcount().total
							-- Remove entries by substituting with empty string
							vim.cmd("%s/" .. regex .. "//g")
						end
						vim.cmd("write!")
						vim.cmd("rshada!")
						vim.cmd("bwipeout!")
						vim.notify("Removed " .. deleted .. " entries for " .. what, vim.log.levels.INFO)
						Snacks.picker.projects()
					end, 100)
				end,
			},
			win = {
				-- input window
				input = {
					keys = {
						-- to close the picker on ESC instead of going to normal mode,
						-- add the following keymap to your config
						["<Esc>"] = { "close", mode = { "n", "i" } },
						["<C-P>"] = { "preview_scroll_up", mode = { "i", "n" } },
						["<C-N>"] = { "preview_scroll_down", mode = { "i", "n" } },
						["<c-v>"] = { "toggle_preview", mode = { "i", "n" } },
					},
				},
			},
			formatters = {
				file = {
					truncate = 80, -- truncate the file path to (roughly) this length
				},
			},
			layouts = {
				rain = {
					--reverse = true,
					layout = {
						box = "vertical",
						width = 0.5,
						--min_width = 120,
						backdrop = false,
						border = "none",
						height = 0.9,
						{ win = "preview", title = "{preview}", border = "rounded", height = 0.7 },
						{
							box = "vertical",
							border = "rounded",
							title = "{title} {live} {flags}",
							{ win = "input", height = 1, border = "bottom" },
							{ win = "list", border = "none" },
						},
					},
				},
				rainselect = {
					layout = {
						box = "vertical",
						width = 0.5,
						--min_width = 120,
						backdrop = false,
						border = "none",
						height = 0.4,
						--{ win = "preview", title = "{preview}", border = "rounded", height = 0.7 },
						{
							box = "vertical",
							border = "rounded",
							title = "{title} {live} {flags}",
							{ win = "list", border = "bottom" },
							{ win = "input", height = 1, border = "none" },
						},
					},
					reverse = true,
					preview = false,
				},
			},
			layout = {
				preset = "default",
				layout = {
					backdrop = false,
				},
			},
		},
		quickfile = { enabled = true },
		scope = { enabled = false },
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = false },
		styles = {},
		terminal = {
			win = {
				style = "terminal",
				position = "float",
				height = 0.7,
				width = 0.7,
				border = "rounded",
				backdrop = false,
			},
		},
	},
	keys = {
		{
			"<leader>1",
			function()
				Snacks.explorer()
			end,
			desc = "File Explorer",
		},
		{
			"<leader>v",
			function()
				Snacks.explorer.reveal()
			end,
			desc = "File Explorer Reveal",
		},
		{
			"g1",
			function()
				Snacks.picker.get({ source = "explorer" })[1]:focus()
			end,
			desc = "File Explorer Force",
		},
		-- Top Pickers & Explorer
		{
			"<leader>b",
			function()
				Snacks.picker.buffers({ layout = { preset = "rainselect" } })
			end,
			desc = "Buffers",
		},
		{
			"<leader>p",
			function()
				Snacks.picker.files({ layout = { preset = "rainselect" } })
			end,
			desc = "Files",
		},
		{
			"<leader>:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>3",
			function()
				Snacks.terminal.toggle()
			end,
			desc = "Terminal",
			mode = { "n", "t" },
		},
		{
			"<leader>ln",
			function()
				Snacks.picker.notifications()
			end,
			desc = "Notification History",
		},
		-- find
		{
			"<leader>lC",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Find Config File",
		},
		{
			"<leader>lg",
			function()
				Snacks.picker.git_files()
			end,
			desc = "Find Git Files",
		},
		{
			"<leader>lp",
			function()
				Snacks.picker.projects()
			end,
			desc = "Projects",
		},
		{
			"<leader>lR",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent",
		},
		-- git
		{
			"<leader>gb",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "Git Branches",
		},
		{
			"<leader>gl",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git Log",
		},
		{
			"<leader>gL",
			function()
				Snacks.picker.git_log_line()
			end,
			desc = "Git Log Line",
		},
		{
			"<leader>gs",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Git Status",
		},
		{
			"<leader>gS",
			function()
				Snacks.picker.git_stash()
			end,
			desc = "Git Stash",
		},
		{
			"<leader>gd",
			function()
				Snacks.picker.git_diff()
			end,
			desc = "Git Diff (Hunks)",
		},
		{
			"<leader>gf",
			function()
				Snacks.picker.git_log_file()
			end,
			desc = "Git Log File",
		},
		-- Grep
		{
			"<leader>/",
			function()
				Snacks.picker.lines()
			end,
			desc = "Buffer Lines",
		},
		{
			"gf",
			function()
				Snacks.picker.grep_word({ layout = { preset = "rain" } })
			end,
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},
		-- search
		{
			"<leader>lr",
			function()
				Snacks.picker.registers({ layout = { preset = "rain" } })
			end,
			desc = "Registers",
		},
		{
			"<leader>l/",
			function()
				Snacks.picker.search_history({ layout = { preset = "rainselect" } })
			end,
			desc = "Search History",
		},
		{
			"<leader>la",
			function()
				Snacks.picker.autocmds()
			end,
			desc = "Autocmds",
		},
		{
			"<leader>lc",
			function()
				Snacks.picker.command_history({ layout = { preset = "rainselect" } })
			end,
			desc = "Command History",
		},
		{
			"<leader>lC",
			function()
				Snacks.picker.commands()
			end,
			desc = "Commands",
		},
		{
			"<leader>E",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
		{
			"<leader>e",
			function()
				Snacks.picker.diagnostics_buffer({ layout = { preset = "rain" } })
			end,
			desc = "Buffer Diagnostics",
		},
		{
			"<leader>lh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages",
		},
		{
			"<leader>lH",
			function()
				Snacks.picker.highlights()
			end,
			desc = "Highlights",
		},
		{
			"<leader>li",
			function()
				Snacks.image.hover()
			end,
			desc = "Hover Image",
		},
		{
			"<leader>lI",
			function()
				Snacks.picker.icons({ layout = { preset = "rainselect" } })
			end,
			desc = "Icons",
		},
		{
			"<leader>lj",
			function()
				Snacks.picker.jumps()
			end,
			desc = "Jumps",
		},
		{
			"<leader>lk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>ll",
			function()
				Snacks.picker.loclist()
			end,
			desc = "Location List",
		},
		{
			"<leader>lm",
			function()
				Snacks.picker.marks()
			end,
			desc = "Marks",
		},
		{
			"<leader>lM",
			function()
				Snacks.picker.man()
			end,
			desc = "Man Pages",
		},
		{
			"<leader>lL",
			function()
				Snacks.picker.lazy()
			end,
			desc = "Search for Plugin Spec",
		},
		{
			"<leader>lq",
			function()
				Snacks.picker.qflist()
			end,
			desc = "Quickfix List",
		},
		-- {
		-- 	"<leader>sR",
		-- 	function()
		-- 		Snacks.picker.resume()
		-- 	end,
		-- 	desc = "Resume",
		-- },
		{
			"<leader>lu",
			function()
				Snacks.picker.undo()
			end,
			desc = "Undo History",
		},
		-- LSP
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions({ layout = { preset = "rain" } })
			end,
			desc = "Goto Definition",
		},
		{
			"gD",
			function()
				Snacks.picker.lsp_declarations({ layout = { preset = "rain" } })
			end,
			desc = "Goto Declaration",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references({ layout = { preset = "rain" } })
			end,
			nowait = true,
			desc = "References",
		},
		{
			"gI",
			function()
				Snacks.picker.lsp_implementations({ layout = { preset = "rain" } })
			end,
			desc = "Goto Implementation",
		},
		-- {
		-- 	"gy",
		-- 	function()
		-- 		Snacks.picker.lsp_type_definitions()
		-- 	end,
		-- 	desc = "Goto T[y]pe Definition",
		-- },
		{
			"<leader>2",
			function()
				Snacks.picker.lsp_symbols({ layout = { preset = "rainselect" } })
			end,
			desc = "LSP Symbols",
		},
		{
			"<leader>ls",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Workspace Symbols",
		},
		{
			"<leader>lS",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "LSP Workspace Symbols",
		},
		-- Other
		{
			"<leader>lz",
			function()
				Snacks.zen()
			end,
			desc = "Toggle Zen Mode",
		},
		{
			"<leader>z",
			function()
				Snacks.zen.zoom()
			end,
			desc = "Toggle Zoom",
		},
		-- {
		-- 	"<leader>.",
		-- 	function()
		-- 		Snacks.scratch()
		-- 	end,
		-- 	desc = "Toggle Scratch Buffer",
		-- },
		-- {
		-- 	"<leader>S",
		-- 	function()
		-- 		Snacks.scratch.select()
		-- 	end,
		-- 	desc = "Select Scratch Buffer",
		-- },
		-- {
		-- {
		-- 	"<leader>cR",
		-- 	function()
		-- 		Snacks.rename.rename_file()
		-- 	end,
		-- 	desc = "Rename File",
		-- },
		-- {
		-- 	"<leader>gB",
		-- 	function()
		-- 		Snacks.gitbrowse()
		-- 	end,
		-- 	desc = "Git Browse",
		-- 	mode = { "n", "v" },
		-- },
		-- {
		-- 	"<leader>gg",
		-- 	function()
		-- 		Snacks.lazygit()
		-- 	end,
		-- 	desc = "Lazygit",
		-- },
		-- {
		-- 	"<leader>un",
		-- 	function()
		-- 		Snacks.notifier.hide()
		-- 	end,
		-- 	desc = "Dismiss All Notifications",
		-- },
		{
			"<leader>lw",
			function()
				if Snacks.words.is_enabled() then
					Snacks.words.disable()
				else
					Snacks.words.enable()
				end
			end,
		},
		{
			"]]",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Next Reference",
			mode = { "n", "t" },
		},
		{
			"[[",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Prev Reference",
			mode = { "n", "t" },
		},
	},
	-- togger 就是为了方便创建一些 toggle 的映射。
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command
			end,
		})
	end,
}
