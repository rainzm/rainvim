local M = {
	{
		"nvim-neorg/neorg",
		-- event = "VeryLazy",
		enabled = false,
		ft = "norg",
		lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
		version = "*",
		dependencies = { "folke/zen-mode.nvim", "nvim-neorg/neorg-telescope" },
		keys = {
			{
				"<Leader>nn",
				"<cmd>Neorg index<cr>",
				desc = "Neorg index",
			},
			{
				"<Leader>nwn",
				"<cmd>Neorg workspace work<cr><cmd>Neorg index<cr>",
			},
			{
				"<Leader>nwt",
				"<cmd>Neorg workspace work<cr><cmd>Neorg journal today<cr>",
			},
		},
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {}, -- Loads default behaviour
					["core.concealer"] = {
						config = {
							icons = {
								code_block = {
									-- conceal = true,
									--width = "content",
									content_only = false,
								},
							},
						},
					}, -- Adds pretty icons to your documents
					["core.completion"] = {
						config = {
							engine = "nvim-cmp",
							name = "neorg",
						},
					},
					["core.presenter"] = { config = { zen_mode = "zen-mode" } },
					["core.dirman"] = { -- Manages Neorg workspaces
						config = {
							workspaces = {
								note = "~/Documents/neorg/note",
								work = "~/Documents/neorg/work",
							},
							default_workspace = "note",
						},
					},
					["core.highlights"] = {
						config = {
							highlights = {
								headings = {
									[1] = {
										prefix = "+GruvboxOrange",
										title = "+GruvboxOrange",
									},
									[2] = {
										prefix = "+GruvboxPurple",
										title = "+GruvboxPurple",
									},
									[3] = {
										title = "+GruvboxYellow",
										prefix = "+GruvboxYellow",
									},
									[4] = {
										title = "+GruvboxGreen",
										prefix = "+GruvboxGreen",
									},
									[5] = {
										title = "+GruvboxAqua",
										prefix = "+GruvboxAqua",
									},
									[6] = {
										title = "+GruvboxGreen",
										prefix = "+GruvboxGreen",
									},
								},
								todo_items = {
									undone = "+GruvboxRed",
								},
							},
						},
					},
					["core.keybinds"] = {
						config = {
							default_keybinds = true,
						},
					},
					["core.integrations.telescope"] = {},
					["core.esupports.metagen"] = { config = { type = "auto", update_date = true } },
					["core.qol.toc"] = {},
					["core.qol.todo_items"] = {},
					["core.looking-glass"] = {},
					["core.export"] = {},
					["core.export.markdown"] = { config = { extensions = "all" } },
					["core.summary"] = {},
					["core.ui.calendar"] = {},
					["core.journal"] = {
						config = {
							strategy = "flat",
							workspace = "work",
						},
					},
				},
			})
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "norg",
				callback = function()
					vim.opt_local.conceallevel = 3
				end,
			})
		end,
	},
	{
		"3rd/image.nvim",
		ft = { "markdown", "vimwiki" },
		enabled = false,
		config = function()
			require("image").setup({
				backend = "kitty",
				integrations = {
					syslang = {
						enabled = false,
					},
					markdown = {
						enabled = true,
						clear_in_insert_mode = false,
						download_remote_images = true,
						only_render_image_at_cursor = false,
						filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
					},
				},
				max_width = nil,
				max_height = nil,
				max_width_window_percentage = 40,
				max_height_window_percentage = 30,
				window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
				window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
				hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
			})
			require("mappings").nvim_load_mapping({
				["n|<leader>ie"] = { f = require("image").enable, doc = "enable image display" },
				["n|<leader>id"] = { f = require("image").disable, doc = "disable image display" },
			})
		end,
	},
}

function M.clearimage()
	local window = vim.api.nvim_get_current_win()
	local buffer = vim.api.nvim_win_get_buf(window)
	local image = require("image")
	local images = image.get_images({
		window = window,
		buffer = buffer,
	})
	for _, current_image in ipairs(images) do
		current_image:clear()
	end
end

return M
