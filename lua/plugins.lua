local M = {}

function M.setup()
  -- packer.nvim configuration
  local conf = {
    profile = {
      enable = true,
      threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },

    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    use {
      'sheerun/vim-polyglot',
    }
    -- Load only when require
    use { "nvim-lua/plenary.nvim", module = "plenary" }

    -- Notify
    use {
      "rcarriga/nvim-notify",
      config = function()
        vim.notify = require("notify")
      end
    }

    -- Git
    use {
      'tpope/vim-fugitive',
      cmd = { 'Git', 'Gstatus', 'Gblame', 'Gpush', 'Gpull' }
    }
    use {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup {
          preview_config = {
            -- Options passed to nvim_open_win
            border = 'rounded',
            style = 'minimal',
            relative = 'cursor',
            row = 0,
            col = 1
          },
        }
      end
    }

    -- Better reg
    use {
      "tversteeg/registers.nvim",
      setup = function()
        vim.g.registers_window_border = "rounded"
      end,
      keys = { { 'n', '"' } }
    }

    -- Better windows
    use {
      "rainzm/vim-choosewin",
      setup = function()
        vim.g.choosewin_blink_on_land = 0
      end,
      cmd = { 'ChooseWin', 'ChooseWinCopy', 'ChooseWinSwap' }
    }

    -- Better icons
    use {
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
    }

    -- Better move
    use {
      "ggandor/leap.nvim",
      config = function()
        local leap = require "leap"
        leap.setup {}
        leap.set_default_keymaps {}
      end,
      keys = { { 'n', 's' }, { 'n', 'S' }, { 'n', 'gs' } }
    }

    -- Float terminal
    use {
      "akinsho/toggleterm.nvim",
      tag = 'v2.*',
      config = function()
        require("config.toggleterm").config()
      end,
      cmd = 'ToggleTerm'
    }

    -- vimwiki
    use {
      'vimwiki/vimwiki',
      setup = function()
        require 'config.vimwiki'.setup()
      end,
      keys = { { 'n', '<Leader>ww' } }
    }
    -- Markdown
    use {
      "iamcco/markdown-preview.nvim",
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
      ft = "markdown",
      cmd = { "MarkdownPreview" },
      config = function()
        vim.g.mkdp_filetypes = { 'markdown', 'vimwiki' }
      end
    }

    -- commentary
    use {
      'tpope/vim-commentary',
      config = function()
        vim.api.nvim_command("autocmd FileType python,shell,yaml setlocal commentstring=#\\ %s")
      end,
      keys = { { 'v', 'gc' } }
    }

    -- Status line
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function()
        require("config.lualine").setup()
      end,
    }

    -- telescope
    use {
      "nvim-telescope/telescope.nvim",
      setup = function()
        require("config.telescope").setup()
      end,
      config = function()
        require("config.telescope").config()
      end,
      requires = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        { "nvim-telescope/telescope-project.nvim" }
      },
      wants = {
        'plenary.nvim',
        'telescope-fzf-native.nvim',
        'telescope-project.nvim',
      },
      --cmd = { 'Telescope' },
      --module = 'telescope',
    }

    -- Session
    use {
      "rmagatti/auto-session",
      requires = {
        {
          'rmagatti/session-lens',
          --after = 'auto-session',
          config = function()
            require 'config.autosession'.lens_config()
          end
        },
        --'nvim-telescope/telescope.nvim'
      },
      setup = function()
        require 'config.autosession'.setup()
      end,
      config = function()
        require 'config.autosession'.config()
      end,
      disable = true,
      --cmd = { 'SaveSession', 'SearchSession' }
    }

    use {
      'jedrzejboczar/possession.nvim',
      requires = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
      wants = { 'telescope.nvim' },
      config = function()
        require 'config.possession'.config()
      end,
    }

    use {
      'goolord/alpha-nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function()
        require("config.alpha").setup()
      end
    }

    -- nvim-tree
    use {
      "kyazdani42/nvim-tree.lua",
      requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icon
      },
      setup = function()
        require("config.nvimtree").setup()
      end,
      config = function()
        require("config.nvimtree").config()
      end,
      cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' }
    }

    -- Completion
    use {
      "hrsh7th/nvim-cmp",
      config = function()
        require("config.cmp").config()
      end,
      requires = {
        { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
        { "saadparwaiz1/cmp_luasnip", after = 'nvim-cmp' },
        "hrsh7th/cmp-nvim-lsp",
        {
          "L3MON4D3/LuaSnip",
          config = function()
            require("config.luasnip").setup()
          end
        },
        "rafamadriz/friendly-snippets",
      },
      event = 'InsertEnter *',
    }

    use {
      "neovim/nvim-lspconfig",
      requires = {
        "williamboman/mason.nvim",
        "rainzm/lsp_signature.nvim",
        "williamboman/mason-lspconfig.nvim",
        "folke/lua-dev.nvim",
      },
    }

    use {
      "windwp/nvim-autopairs",
      config = function() require("nvim-autopairs").setup {} end,
    }

    -- dap
    use {
      "rcarriga/nvim-dap-ui",
      requires = {
        "mfussenegger/nvim-dap",
        --"leoluz/nvim-dap-go",
      },
      config = function()
        require("config.dap").dap_config()
      end
    }
  end

  vim.cmd [[packadd packer.nvim]]
  vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
  ]])
  -- Init and start packer
  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M
