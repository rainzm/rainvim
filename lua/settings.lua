local set = vim.opt

set.sessionoptions:append("globals")
set.autoread = true
set.backspace = "2"
set.pumheight = 15
set.pumblend = 10

set.laststatus = 2
set.showmode = false
set.maxmempattern = 10000

set.expandtab = true
set.shiftwidth = 4
set.tabstop = 4
set.softtabstop = 4
set.smartindent = true
vim.cmd("autocmd Filetype yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab")

set.incsearch = true
set.wildmenu = true
set.shell = "/opt/homebrew/bin/fish"

set.splitright = true
set.splitbelow = true

--set.fillchars:append("vert: ")

-- colorscheme
set.termguicolors = true
set.background = "dark"
vim.cmd([[
    syntax on
    syntax enable
    colorscheme gruvboxrain
    filetype on
    filetype plugin on
    filetype plugin indent on
    set number
    set relativenumber
    language messages en_US.UTF-8
]])

-- 不自动windows equal
-- set.ea = false
-- set.numberwidth = 3
set.cursorline = true
set.hidden = true
set.backup = false
set.writebackup = false
set.cmdheight = 1
set.updatetime = 200
set.shortmess:append("c")
set.signcolumn = "yes"
