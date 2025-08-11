local M = {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		{ "kyazdani42/nvim-web-devicons", opt = true },
		--{ "AndreM222/copilot-lualine" },
	},
	show_current_function = false,
}

function M._codeium()
	local status = require("codeium.virtual_text").status()

	if status.state == "idle" then
		-- Output was cleared, for example when leaving insert mode
		return " "
	end

	if status.state == "waiting" then
		-- Waiting for response
		return "*"
	end

	if status.state == "completions" and status.total > 0 then
		return string.format("%d/%d", status.current, status.total)
	end

	return " "
end

function M._current_function()
	if M.show_current_function then
		return vim.b.lsp_current_function
	end
	return ""
end

function M.config()
	local colors = {
		black = "#282828",
		white = "#ebdbb2",
		--blue = "#83a598",
		blue = "#81a89b",
		orange = "#f28534",
		gray = "#928374",
		lightgray = "#504945",
		inactivegray = "#665c54",
		midfont = "#b4a596",
		--orange       = '#de935f',
	}

	local lualine_gruvbox = {
		normal = {
			a = { bg = colors.blue, fg = colors.black },
			b = { bg = colors.gray, fg = colors.black },
			c = { bg = colors.lightgray, fg = colors.midfont },
			x = { bg = colors.lightgray, fg = colors.midfont },
		},
		insert = {
			a = { bg = colors.blue, fg = colors.black },
			b = { bg = colors.gray, fg = colors.black },
			c = { bg = colors.lightgray, fg = colors.midfont },
		},
		visual = {
			a = { bg = colors.orange, fg = colors.black },
			b = { bg = colors.gray, fg = colors.black },
			c = { bg = colors.lightgray, fg = colors.midfont },
		},
		replace = {
			a = { bg = colors.blue, fg = colors.black },
			b = { bg = colors.gray, fg = colors.black },
			c = { bg = colors.lightgray, fg = colors.midfont },
		},
		command = {
			a = { bg = colors.blue, fg = colors.black },
			b = { bg = colors.gray, fg = colors.black },
			c = { bg = colors.lightgray, fg = colors.midfont },
		},
		inactive = {
			a = { bg = colors.inactivegray, fg = colors.black },
			b = { bg = colors.inactivegray, fg = colors.black },
			c = { bg = colors.inactivegray, fg = colors.black },
		},
	}
	local keys = {
		["<leader>lf"] = {
			f = function()
				if M.show_current_function then
					M.show_current_function = false
				else
					require("lsp-status").update_current_function()
					M.show_current_function = true
				end
				require("lualine").refresh({
					scope = "window",
					place = { "statusline" },
				})
			end,
			desc = "Toggle Current Function",
		},
	}
	require("mappings").nvim_load_mapping(keys)

	local icons = require("plugins.utils.icons")
	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = lualine_gruvbox,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = false,
			refresh = {
				statusline = 200,
				tabline = 500,
				winbar = 300,
			},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {
				{
					"filename",
					file_status = true,
					path = 1,
				},
			},
			lualine_c = {
				{
					"diagnostics",
					sources = { "nvim_lsp" },
					sections = { "error", "warn", "info", "hint" },
					symbols = {
						error = icons.diagnostics.Error,
						warn = icons.diagnostics.Warning,
						info = icons.diagnostics.Information,
						hint = icons.diagnostics.Hint,
					},
					colored = true,
					update_in_insert = true,
				},
				{ M._current_function },
				--{ "copilot" },
				--{ M._codeium },
			},
			lualine_x = {},
			lualine_y = {
				"vim.bo.filetype",
				"progress",
			},
			lualine_z = {},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {
				{
					"filename",
					file_status = true,
					path = 1,
				},
			},
			lualine_c = {},
			lualine_x = {},
			lualine_y = { "progress" },
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {},
	})
	require("codeium.virtual_text").set_statusbar_refresh(function()
		require("lualine").refresh()
	end)
end

return M
