local M = {
	-- telescope
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "nvim-telescope/telescope-project.nvim" },
	},
	keys = {
		{
			"<Leader>p",
			function()
				require("telescope.builtin").find_files({
					no_ignore_parent = true,
				})
			end,
			desc = "Find files",
		},
		{
			"<Leader>lg",
			"<cmd>Telescope live_grep<CR>",
			desc = "Find files",
		},
		{
			"<Leader>ll",
			"<cmd>Telescope grep_string<CR>",
			desc = "Find files",
		},
		{
			"<Leader>b",
			function()
				require("telescope.builtin").buffers({
					sort_mru = true,
					ignore_current_buffer = true,
				})
			end,
			desc = "Find buffers",
		},
		{
			"gf",
			":Rg <C-R><C-W><CR>",
			desc = "Find current word",
		},
		{
			"gd",
			function()
				require("telescope.builtin").lsp_definitions({
					show_line = false,
				})
			end,
			desc = "Show lsp_definitions",
		},
		{
			"gi",
			function()
				require("telescope.builtin").lsp_implementations({
					show_line = false,
				})
			end,
			desc = "Show lsp_implementations",
		},
		{
			"gr",
			function()
				require("telescope.builtin").lsp_references({
					show_line = false,
				})
			end,
			desc = "Show lsp_references",
		},
		{
			"<Leader>2",
			function()
				require("telescope.builtin").lsp_document_symbols({ show_line = false })
			end,
			desc = "Show lsp_document_symbols",
		},
		-- {
		-- 	"<Leader>rr",
		-- 	'<cmd>lua require("telescope").extensions.refactoring.refactors()<CR>',
		-- 	desc = "refactor code",
		-- },
	},
	cmd = { "Telescope" },
}

local function flash(prompt_bufnr)
	require("flash").jump({
		pattern = "^",
		label = { after = { 0, 0 } },
		search = {
			mode = "search",
			exclude = {
				function(win)
					return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
				end,
			},
		},
		action = function(match)
			local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
			picker:set_selection(match.pos[1] - 1)
		end,
	})
end

-- ms.nnoremap('gf', ':Rg <C-R><C-W><CR>')
function M.config()
	local icons = require("plugins.utils.icons")
	vim.api.nvim_create_autocmd("User", {
		pattern = "TelescopePreviewerLoaded",
		callback = function(args)
			if args == nil or args.data == nil then
				return
			end
			if args.data.filetype ~= "help" then
				vim.wo.number = true
			elseif args.data.bufname:match("*.csv") then
				vim.wo.wrap = false
			end
		end,
	})
	vim.api.nvim_create_autocmd("User", {
		pattern = "TelescopeFindPre",
		callback = function()
			if vim.bo.filetype == "markdown" then
				vim.g.cmp_enabled = true
			else
				vim.g.cmp_enabled = false
			end
		end,
	})
	local actions = require("telescope.actions")
	local trouble = require("trouble.providers.telescope")

	require("telescope").setup({
		defaults = {
			prompt_prefix = icons.ui.Telescope .. " ",
			--selection_caret = " ",
			mappings = {
				i = {
					["<esc>"] = require("telescope.actions").close,
					["<C-v>"] = require("telescope.actions").file_vsplit,
					["<C-s>"] = require("telescope.actions").file_split,
					["<C-p>"] = require("telescope.actions").preview_scrolling_up,
					["<C-n>"] = require("telescope.actions").preview_scrolling_down,
					["<C-y>"] = "which_key",
					["<C-Q>"] = require("telescope.actions").smart_send_to_qflist,
					["<c-t>"] = require("trouble.sources.telescope").open,
					["<c-s>"] = flash,
				},
				n = {
					["<c-t>"] = require("trouble.sources.telescope").open,
					["s"] = flash,
				},
			},
			file_ignore_patterns = { "^vendor/" },
			--layout_strategy = 'horizontal',
			layout_strategy = "vertical",
			layout_config = { width = 0.5 },
		},
		pickers = {
			find_files = {
				previewer = false,
				layout_config = { width = 0.5, height = 0.5 },
			},
			buffers = {
				previewer = false,
				layout_config = { width = 0.5, height = 0.5 },
				mappings = {
					i = {
						["<c-d>"] = actions.delete_buffer,
					},
				},
			},
			live_grep = {
				layout_config = { width = 0.5, preview_height = 0.6 },
			},
			grep_string = {
				layout_config = { width = 0.5, preview_height = 0.6 },
			},
			lsp_document_symbols = {
				previewer = false,
				layout_config = { width = 0.5, height = 0.5 },
				symbol_width = 50,
			},
			lsp_workspace_symbols = {
				fname_width = 50,
				symbol_width = 50,
			},
			lsp_references = {
				layout_config = { width = 0.5, preview_height = 0.7 },
			},
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			},
		},
	})
	-- To get fzf loaded and working with telescope, you need to call
	-- load_extension, somewhere after setup function:
	require("telescope").load_extension("fzf")
	require("telescope").load_extension("project")
	-- require("telescope").load_extension("refactoring")

	vim.api.nvim_set_keymap(
		"n",
		"<leader>lp",
		'<cmd>lua require"telescope".extensions.project.project{ layout_config = { width = 0.5, height = 0.5 } }<CR>',
		{ noremap = true, silent = true }
	)
end

return M
