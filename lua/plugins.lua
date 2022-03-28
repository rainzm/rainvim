local ui = require("modules.ui")
local telescope = require("modules.telescope")
local treesitter = require("modules.treesitter")

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
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} },
        config = telescope.telescope,
    }
    use {
        'kyazdani42/nvim-web-devicons',
    }
    use {
        'sheerun/vim-polyglot',
    }
    use {
        'neovim/nvim-lspconfig'
    }
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use {
        'phaazon/hop.nvim',
        branch = 'v1', -- optional but strongly recommended
        config = function()
            require('hop').setup()
        end
    }
end)
