vim.g.mapleader = "'"
local M = {}

function M.noremap(mode, shorcut, command)
    vim.api.nvim_set_keymap(mode, shorcut, command, { noremap = true, silent = true })
end

function M.nnoremap(shortcut, command)
    M.noremap("n", shortcut, command)
end

function M.vnoremap(shortcut, command)
    M.noremap("v", shortcut, command)
end

function M.tnoremap(shorcut, command)
    M.noremap('t', shorcut, command)
end

function M.inoremap(shorcut, command)
    M.noremap('i', shorcut, command)
end

function M.cnoremap(shorcut, command)
    M.noremap('c', shorcut, command)
end

M.nnoremap('<C-A>', '^')
M.nnoremap('<C-S>', '$')
M.vnoremap('<Leader>y', '"+y')
M.nnoremap('<Leader>s', ':w<CR>')
M.nnoremap('<Leader>S', ':wa<CR>')
M.nnoremap('<Leader>Q', ":wa<CR>:qa<CR>")

M.nnoremap('<C-[>', '<C-I>')
M.nnoremap('<C-O>', '<C-T>')
M.nnoremap('<C-P>', '<C-O>')

-- highlight
M.nnoremap('n', ':set hlsearch<cr>n')
M.nnoremap('N', ':set hlsearch<cr>N')
M.nnoremap('/', ':set hlsearch<cr>/')
M.nnoremap('?', ':set hlsearch<cr>?')
M.nnoremap('*', '*:set hlsearch<cr>')
M.nnoremap('gm', ':set nohlsearch<cr>')

local function bd(_)
    require("mini.bufremove").delete(0, false)
end

local function bdforce()
    require("mini.bufremove").delete(0, true)
end

local function rg(opts)
    -- 这里引用了telescope，就算telescope没有被load，也会自动load，lazy.nvim的功劳
    require('telescope.builtin').grep_string({ search = opts.args, disable_coordinates = true })
end

vim.api.nvim_create_user_command('Bd', bd, {})
vim.api.nvim_create_user_command('BD', bdforce, {})
vim.api.nvim_create_user_command('Rg', rg, { nargs = 1, force = true })

M.nnoremap('<Leader>3', '<cmd>ToggleTerm<CR>')
M.tnoremap('<Leader>3', '<cmd>ToggleTerm<CR>')

vim.api.nvim_set_keymap('n', 'gwg', '<cmd>ChooseWin<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', 'gwc', '<cmd>ChooseWinCopy<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', 'gws', '<cmd>ChooseWinSwap<cr>', { noremap = true })
return M
