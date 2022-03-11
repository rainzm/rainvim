local ui = require("modules.ui")

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function ()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icon
        },
        config = ui.nvim_tree,
    }
    use {
        'itchyny/lightline.vim',
        config = ui.lightline,
    }
end)
