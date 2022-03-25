local telescope = {}

function telescope.telescope()
    require('telescope').setup {
        defaults = {
            mappings = {
                i = {
                    ["<C-v>"] = require('telescope.actions').file_vsplit,
                    ["<C-s>"] = require('telescope.actions').file_split,
                }
            },
            file_ignore_patterns = { "^vendor/" },
            layout_strategy = 'horizontal',
            layout_config = {
                horizontal = {
                    width = 0.9,
                    height = 0.6,
                    preview_cutoff = 50,
                    prompt_position = "bottom",
                }
            }
        },
        extensions = {
            fzf = {
                fuzzy = true,                    -- false will only do exact matching
                override_generic_sorter = true,  -- override the generic sorter
                override_file_sorter = true,     -- override the file sorter
                case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            }
        }
    }
    -- To get fzf loaded and working with telescope, you need to call
    -- load_extension, somewhere after setup function:
    require('telescope').load_extension('fzf')
end

return telescope
