local M = {}

function M.setup()
  local ms = require "mappings"
  ms.nnoremap('<Leader>1', ":NvimTreeToggle<CR>")
  ms.nnoremap('<Leader>v', ":NvimTreeFindFile<CR>")
  ms.nnoremap('g1', ":NvimTreeFocus<CR>")
end

function M.config()
  local list = {
    { key = "za", action = "close_node" },
    { key = "m", action = "move" },
    { key = "c", action = "copy" },
    { key = "p", action = "paste" },
    { key = "v", action = "vsplit" },
    { key = "s", action = "split" },
    { key = "d", action = "remove" },
    { key = "r", action = "rename" },
    { key = "R", action = "refresh" },
    { key = "n", action = "create" },
  }
  require("nvim-tree").setup({
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {},
    open_on_tab = false,
    filters = { dotfiles = true, custom = { "_output" } },
    git = { enable = false },
    view = {
      width = 30,
      hide_root_folder = true,
      side = "left",
      mappings = { custom_only = false, list = list },
      number = false,
      relativenumber = false,
      signcolumn = "no",
    },
    renderer = {
      icons = {
        show = {
          git = false,
          folder = true,
          file = true,
          folder_arrow = false,
        },
        glyphs = {
          default = "",
          symlink = "",
        },
      },
      special_files = {
      },
    },
    trash = { cmd = "trash", require_confirm = true },
    actions = {
      open_file = {
        window_picker = {
          enable = true,
        },
      },
    },
  })
end

return M
