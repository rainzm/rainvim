local M = {}

function M.config()
  local ms = require 'mappings'
  ms.nnoremap('<Leader>ls', '<cmd>Telescope possession list previewer=false layout_config={width=0.5,height=0.5}<CR>')
  require('possession').setup {
    autosave = {
      current = true, -- or fun(name): boolean
      on_load = true,
      on_quit = true,
    },
    commands = {
      save = 'SSave',
      load = 'SLoad',
      delete = 'SDelete',
      list = 'SList',
    },
    plugins = {
      nvim_tree = true,
      delete_hidden_buffers = {
        force = true, -- or fun(buf): boolean
      },
    },
  }
  require('telescope').load_extension('possession')
end

return M
