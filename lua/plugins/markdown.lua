return {
	{
		"jakewvincent/mkdnflow.nvim",
		--enabled = false,
		--rocks = "luautf8",
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
				MkdnToggleToDo = { { "n", "v" }, "<C-Space>" },
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
		opts = {
			file_types = { "Avante", "markdown" },
			completion = { lsp = { enabled = true } },
		},
		ft = { "Avante", "markdown" },
		keys = {
			{
				"<Leader>rm",
				"<cmd>RenderMarkdown buf_toggle<CR>",
				desc = "Toggle Render Markdown in buffer",
			},
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = "markdown",
		cmd = { "MarkdownPreview" },
		init = function()
			vim.g.mkdp_theme = "light"
		end,
		config = function()
			vim.g.mkdp_filetypes = { "markdown", "vimwiki" }
		end,
	},
	-- {
	-- 	-- support for image pasting
	-- 	"HakonHarnes/img-clip.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		-- recommended settings
	-- 		default = {
	-- 			embed_image_as_base64 = false,
	-- 			prompt_for_file_name = false,
	-- 			-- drag_and_drop = {
	-- 			-- 	insert_mode = true,
	-- 			-- },
	-- 			-- required for Windows users
	-- 			use_absolute_path = true,
	-- 		},
	-- 	},
	-- },
}
