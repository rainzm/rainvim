local M = {
    -- telescope
    "nvim-telescope/telescope.nvim",
    branch = '0.1.x',
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        { "nvim-telescope/telescope-project.nvim" },
    },
    keys = {
        { '<Leader>p', '<cmd>Telescope find_files<CR>',                                                        desc = "Find files" },
        { '<Leader>b', '<cmd>Telescope buffers<CR>',                                                           desc = "Find buffers" },
        { 'gf',        ':Rg <C-R><C-W><CR>',                                                                   desc = "Find current word" },
        { 'gi',        '<cmd>lua require("telescope.builtin").lsp_implementations({ show_line = false })<CR>', desc = "Show lsp_implementations" },
        { 'gr',        '<cmd>lua require("telescope.builtin").lsp_references({ show_line = false })<CR>',      desc = "Show lsp_references" },
        { '<Leader>2', '<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>',                     desc = "Show lsp_document_symbols" },
    },
    cmd = { 'Telescope' },
}

-- ms.nnoremap('gf', ':Rg <C-R><C-W><CR>')
function M.config()
    local icons = require("plugins.utils.icons")
    vim.cmd "autocmd User TelescopePreviewerLoaded setlocal number"
    require('telescope').setup {
        defaults = {
            prompt_prefix = icons.ui.Telescope .. " ",
            --selection_caret = " ",
            mappings = {
                i = {
                    ["<esc>"] = require('telescope.actions').close,
                    ["<C-v>"] = require('telescope.actions').file_vsplit,
                    ["<C-s>"] = require('telescope.actions').file_split,
                    ["<C-p>"] = require('telescope.actions').preview_scrolling_up,
                    ["<C-n>"] = require('telescope.actions').preview_scrolling_down,
                }
            },
            file_ignore_patterns = { "^vendor/" },
            --layout_strategy = 'horizontal',
            layout_strategy = 'vertical',
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
            }
        }
    }
    -- To get fzf loaded and working with telescope, you need to call
    -- load_extension, somewhere after setup function:
    require('telescope').load_extension('fzf')
    require 'telescope'.load_extension('project')
    vim.api.nvim_set_keymap('n', '<leader>lp',
        '<cmd>lua require"telescope".extensions.project.project{ layout_config = { width = 0.5, height = 0.5 } }<CR>',
        { noremap = true, silent = true })
end

return M
