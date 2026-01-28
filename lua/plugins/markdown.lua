return {
	{
		"jakewvincent/mkdnflow.nvim",
		--rocks = "luautf8",
		enabled = false,
		ft = { "markdown", "vimwiki" },
		opts = {
			modules = {
				bib = true,
				buffers = true,
				conceal = true,
				cursor = true,
				folds = true,
				links = true,
				lists = true,
				maps = true,
				paths = true,
				tables = true,
				yaml = false,
			},
			filetypes = { md = true, rmd = true, markdown = true },
			create_dirs = true,
			perspective = {
				priority = "root",
				fallback = "current",
				root_tell = "index.md",
				nvim_wd_heel = false,
				update = false,
			},
			wrap = false,
			bib = {
				default_path = nil,
				find_in_root = true,
			},
			silent = false,
			links = {
				style = "markdown",
				name_is_source = false,
				conceal = false,
				context = 0,
				implicit_extension = nil,
				transform_implicit = false,
				transform_explicit = function(text)
					text = text:gsub(" ", "-")
					text = text:lower()
					text = os.date("%Y-%m-%d_") .. text
					return text
				end,
			},
			to_do = {
				symbols = { " ", "-", "X" },
				update_parents = true,
				not_started = " ",
				in_progress = "-",
				complete = "X",
			},
			tables = {
				trim_whitespace = true,
				format_on_move = true,
				auto_extend_rows = false,
				auto_extend_cols = false,
			},
			yaml = {
				bib = { override = false },
			},
			mappings = {
				MkdnEnter = { { "n", "v" }, "<CR>" },
				MkdnTab = false,
				MkdnSTab = false,
				MkdnNextLink = { "n", "<Tab>" },
				MkdnPrevLink = { "n", "<S-Tab>" },
				MkdnNextHeading = { "n", "]]" },
				MkdnPrevHeading = { "n", "[[" },
				MkdnGoBack = { "n", "<BS>" },
				MkdnGoForward = { "n", "<Del>" },
				MkdnCreateLink = false, -- see MkdnEnter
				--MkdnCreateLinkFromClipboard = { { "n", "v" }, "<leader>p" }, -- see MkdnEnter
				MkdnCreateLinkFromClipboard = false, -- see MkdnEnter
				MkdnFollowLink = false, -- see MkdnEnter
				MkdnDestroyLink = { "n", "<M-CR>" },
				MkdnTagSpan = { "v", "<M-CR>" },
				MkdnMoveSource = { "n", "<F2>" },
				MkdnYankAnchorLink = { "n", "ya" },
				MkdnYankFileAnchorLink = { "n", "yfa" },
				MkdnIncreaseHeading = { "n", "+" },
				MkdnDecreaseHeading = { "n", "-" },
				MkdnToggleToDo = { { "n", "v" }, "<S-Space>" },
				MkdnNewListItem = false,
				MkdnNewListItemBelowInsert = { "n", "o" },
				MkdnNewListItemAboveInsert = { "n", "O" },
				MkdnExtendList = false,
				MkdnUpdateNumbering = { "n", "<leader>nn" },
				MkdnTableNextCell = { "i", "<S-Tab>" },
				--MkdnTablePrevCell = { "i", "<S-Tab>" },
				MkdnTablePrevCell = false,
				MkdnTableNextRow = false,
				--MkdnTablePrevRow = { "i", "<M-CR>" },
				MkdnTablePrevRow = false,
				MkdnTableNewRowBelow = { "n", "<leader>ir" },
				MkdnTableNewRowAbove = { "n", "<leader>iR" },
				MkdnTableNewColAfter = { "n", "<leader>ic" },
				MkdnTableNewColBefore = { "n", "<leader>iC" },
				-- MkdnFoldSection = { "n", "<leader>f" },
				-- MkdnUnfoldSection = { "n", "<leader>F" },
				MkdnFoldSection = false,
				MkdnUnfoldSection = false,
			},
			new_file_template = {
				use_template = true,
				template = [[
---
title: {{ title }}
date: {{ date }}
---
]],
				placeholders = {
					before = {
						date = function()
							return os.date("%A, %B %d, %Y") -- Wednesday, March 1, 2023
						end,
					},
				},
			},
		},
	},
	{
		-- Make sure to set this up properly if you have lazy=true
		"MeanderingProgrammer/render-markdown.nvim",
		config = function()
			require("render-markdown").setup({
				callout = {
					abstract = {
						raw = "[!ABSTRACT]",
						rendered = "󰯂 Abstract",
						highlight = "RenderMarkdownInfo",
						category = "obsidian",
					},
					summary = {
						raw = "[!SUMMARY]",
						rendered = "󰯂 Summary",
						highlight = "RenderMarkdownInfo",
						category = "obsidian",
					},
					tldr = {
						raw = "[!TLDR]",
						rendered = "󰦩 Tldr",
						highlight = "RenderMarkdownInfo",
						category = "obsidian",
					},
					failure = {
						raw = "[!FAILURE]",
						rendered = " Failure",
						highlight = "RenderMarkdownError",
						category = "obsidian",
					},
					fail = {
						raw = "[!FAIL]",
						rendered = " Fail",
						highlight = "RenderMarkdownError",
						category = "obsidian",
					},
					missing = {
						raw = "[!MISSING]",
						rendered = " Missing",
						highlight = "RenderMarkdownError",
						category = "obsidian",
					},
					attention = {
						raw = "[!ATTENTION]",
						rendered = " Attention",
						highlight = "RenderMarkdownWarn",
						category = "obsidian",
					},
					warning = {
						raw = "[!WARNING]",
						rendered = " Warning",
						highlight = "RenderMarkdownWarn",
						category = "github",
					},
					danger = {
						raw = "[!DANGER]",
						rendered = " Danger",
						highlight = "RenderMarkdownError",
						category = "obsidian",
					},
					error = {
						raw = "[!ERROR]",
						rendered = " Error",
						highlight = "RenderMarkdownError",
						category = "obsidian",
					},
					bug = {
						raw = "[!BUG]",
						rendered = " Bug",
						highlight = "RenderMarkdownError",
						category = "obsidian",
					},
					quote = {
						raw = "[!QUOTE]",
						rendered = " Quote",
						highlight = "RenderMarkdownQuote",
						category = "obsidian",
					},
					cite = {
						raw = "[!CITE]",
						rendered = " Cite",
						highlight = "RenderMarkdownQuote",
						category = "obsidian",
					},
					todo = {
						raw = "[!TODO]",
						rendered = " Todo",
						highlight = "RenderMarkdownInfo",
						category = "obsidian",
					},
					wip = {
						raw = "[!WIP]",
						rendered = "󰦖 WIP",
						highlight = "RenderMarkdownHint",
						category = "obsidian",
					},
					done = {
						raw = "[!DONE]",
						rendered = " Done",
						highlight = "RenderMarkdownSuccess",
						category = "obsidian",
					},
				},
				sign = { enabled = false },
				code = {
					-- general
					width = "block",
					min_width = 80,
					-- borders
					border = "thin",
					left_pad = 1,
					right_pad = 1,
					-- language info
					position = "right",
					language_icon = true,
					language_name = true,
					-- avoid making headings ugly
					highlight_inline = "RenderMarkdownCodeInfo",
				},
				heading = {
					icons = { " 󰼏 ", " 󰎨 ", " 󰼑 ", " 󰎲 ", " 󰼓 ", " 󰎴 " },
					border = true,
					render_modes = true, -- keep rendering while inserting
				},
				checkbox = {
					unchecked = {
						icon = "󰄱",
						highlight = "RenderMarkdownCodeFallback",
						scope_highlight = "RenderMarkdownCodeFallback",
					},
					checked = {
						icon = "󰄵",
						highlight = "RenderMarkdownUnchecked",
						scope_highlight = "RenderMarkdownUnchecked",
					},
					custom = {
						question = {
							raw = "[?]",
							rendered = "",
							highlight = "RenderMarkdownError",
							scope_highlight = "RenderMarkdownError",
						},
						todo = {
							raw = "[>]",
							rendered = "󰦖",
							highlight = "RenderMarkdownInfo",
							scope_highlight = "RenderMarkdownInfo",
						},
						canceled = {
							raw = "[-]",
							rendered = "",
							highlight = "RenderMarkdownCodeFallback",
							scope_highlight = "@text.strike",
						},
						important = {
							raw = "[!]",
							rendered = "",
							highlight = "RenderMarkdownWarn",
							scope_highlight = "RenderMarkdownWarn",
						},
						favorite = {
							raw = "[~]",
							rendered = "",
							highlight = "RenderMarkdownMath",
							scope_highlight = "RenderMarkdownMath",
						},
					},
				},
				pipe_table = {
					alignment_indicator = "─",
					border = { "╭", "┬", "╮", "├", "┼", "┤", "╰", "┴", "╯", "│", "─" },
				},
				link = {
					wiki = {
						icon = " ",
						highlight = "RenderMarkdownWikiLink",
						scope_highlight = "RenderMarkdownWikiLink",
					},
					image = " ",
					custom = {
						github = { pattern = "github", icon = " " },
						gitlab = { pattern = "gitlab", icon = "󰮠 " },
						youtube = { pattern = "youtube", icon = " " },
						cern = { pattern = "cern.ch", icon = " " },
					},
					hyperlink = " ",
				},
				anti_conceal = {
					disabled_modes = { "n" },
					ignore = {
						bullet = true, -- render bullet in insert mode
						head_border = true,
						head_background = true,
					},
				},
				-- https://github.com/MeanderingProgrammer/render-markdown.nvim/issues/509
				win_options = { concealcursor = { rendered = "nvc" } },
				completions = {
					blink = { enabled = true },
					lsp = { enabled = true },
				},
			})
		end,
		-- opts = {
		-- 	enabled = false,
		-- 	file_types = { "markdown" },
		-- 	completion = { lsp = { enabled = true } },
		-- },
		ft = { "markdown" },
		keys = {
			{
				"<Leader>mr",
				"<cmd>RenderMarkdown buf_toggle<CR>",
				desc = "Toggle Render Markdown in buffer",
			},
		},
	},
	{
		"wallpants/github-preview.nvim",
		cmd = { "GithubPreviewToggle" },
		--keys = { "<leader>mpt" },
		opts = {
			single_file = false,

			theme = {
				-- "system" | "light" | "dark"
				name = "light",
				high_contrast = false,
			},
		},
		config = function(_, opts)
			local gpreview = require("github-preview")
			gpreview.setup(opts)

			-- local fns = gpreview.fns
			-- vim.keymap.set("n", "<leader>mpt", fns.toggle)
			-- vim.keymap.set("n", "<leader>mps", fns.single_file_toggle)
			-- vim.keymap.set("n", "<leader>mpd", fns.details_tags_toggle)
		end,
	},
	{
		-- support for image pasting
		"HakonHarnes/img-clip.nvim",
		event = "VeryLazy",
		opts = {
			-- recommended settings
			default = {
				drag_and_drop = {
					enabled = false,
				},
			},
		},
		keys = { { "<leader>mp", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" } },
	},
	{
		"zk-org/zk-nvim",
		config = function()
			require("zk").setup({
				-- Can be "telescope", "fzf", "fzf_lua", "minipick", "snacks_picker",
				-- or select" (`vim.ui.select`).
				picker = "snacks_picker",

				lsp = {
					-- `config` is passed to `vim.lsp.start(config)`
					config = {
						name = "zk",
						cmd = { "zk", "lsp" },
						filetypes = { "markdown" },
						-- on_attach = ...
						-- etc, see `:h vim.lsp.start()`
					},

					-- automatically attach buffers in a zk notebook that match the given filetypes
					auto_attach = {
						enabled = true,
					},
				},
			})
		end,
	},
}
