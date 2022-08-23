local M = {}

function M.setup()
  local lualine_gruvbox = require 'config.themes.lualine_gruvbox'
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
