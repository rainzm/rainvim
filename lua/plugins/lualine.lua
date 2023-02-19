local M = {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons', opt = true },
}

function M.config()
    local colors = {
        black        = '#282828',
        white        = '#ebdbb2',
        blue         = '#83a598',
        orange       = '#de935f',
        gray         = '#928374',
        lightgray    = '#504945',
        inactivegray = '#665c54',
        midfont      = '#b4a596',
    }

    local lualine_gruvbox = {
        normal = {
            a = { bg = colors.blue, fg = colors.black },
            b = { bg = colors.gray, fg = colors.black },
            c = { bg = colors.lightgray, fg = colors.midfont },
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
    require('lualine').setup {
        options = {
            icons_enabled = true,
            theme = lualine_gruvbox,
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            }
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = {
                {
                    'filename',
                    file_status = true,
                    path = 1,
                }
            },
            lualine_c = { 'diagnostics' },
            lualine_x = {},
            lualine_y = { 'vim.bo.filetype', 'progress' },
            lualine_z = {}
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {
                {
                    'filename',
                    file_status = true,
                    path = 1,
                }
            },
            lualine_c = {},
            lualine_x = {},
            lualine_y = { 'progress' },
            lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
    }
end

return M
