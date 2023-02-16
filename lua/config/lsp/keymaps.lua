local M = {}

local mapping = require "mappings"
local buf_keymap = vim.api.nvim_buf_set_keymap

local function keymappings(client, bufnr)
  local opts = { noremap = true, silent = true }

  -- Key mappings
  buf_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  --buf_keymap(bufnr, 'i', '<C-t>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.format({async=true})<CR>', opts)

  mapping.nnoremap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  mapping.nnoremap('gi', '<cmd>lua require("telescope.builtin").lsp_implementations({ show_line = false })<CR>')
  mapping.nnoremap('gr', '<cmd>lua require("telescope.builtin").lsp_references({ show_line = false })<CR>')
  --nnoremap('gs', '<cmd>lua require("telescope.builtin").lsp_workspace_symbols()<CR>')
  mapping.nnoremap('<leader>2', '<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>')
end

function M.setup(client, bufnr)
  keymappings(client, bufnr)
end

return M
