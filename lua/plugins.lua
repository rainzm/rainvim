return {
    { 'sheerun/vim-polyglot' },
    -- Library used by other plugins
    { "nvim-lua/plenary.nvim", module = "plenary", lazy = true },
    -- Git
    {
        'tpope/vim-fugitive',
        cmd = { 'Git', 'Gstatus', 'Gblame', 'Gpush', 'Gpull' }
    },
    -- Better reg
    {
        "tversteeg/registers.nvim",
        opts = {
            window = {
                border = "rounded",
                transparency = 5,
            }
        },
        keys = { { '"' } },
    },
    -- Better windows
    {
        "rainzm/vim-choosewin",
        init = function()
            vim.g.choosewin_blink_on_land = 0
        end,
        cmd = { 'ChooseWin', 'ChooseWinCopy', 'ChooseWinSwap' }
    },
    -- Better icons
    {
        "kyazdani42/nvim-web-devicons",
        module = "nvim-web-devicons",
    },
    -- Markdown
    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        ft = "markdown",
        cmd = { "MarkdownPreview" },
        config = function()
            vim.g.mkdp_filetypes = { 'markdown', 'vimwiki' }
        end
    },
    -- commentary
    {
        "echasnovski/mini.comment",
        config = function()
            require("mini.comment").setup()
        end,
        keys = { { mode = { "v", "n" }, "gc" } }
    },
    {
        'ethanholz/nvim-lastplace',
        opts = {
            lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
            lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
            lastplace_open_folds = true,
        },
        event = { "BufReadPre" },
    },
    {
        "echasnovski/mini.bufremove",
        lazy = true,
    },
}
