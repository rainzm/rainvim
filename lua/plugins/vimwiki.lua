local M = {
    'vimwiki/vimwiki',
    keys = { { '<Leader>ww' } }
}

function M.init()
    vim.g.vimwiki_global_ext = 0
    vim.g.vimwiki_list = {
        {
            auto_export = 1,
            auto_header = 1,
            path = '$HOME/Documents/vimwiki/',
            syntax = 'markdown',
            ext = '.md',
            template_path = '$HOME/Documents/vimwiki/templates/',
            automatic_nested_syntaxes = 1,
            template_default = 'GitHub',
            template_ext = '.html5',
            path_html = '$HOME/Documents/vimwiki/site_html/',
            custom_wiki2html = '$HOME/Documents/Setting/wiki2html.sh',
            autotags = 1,
            list_margin = 0,
            links_space_char = '_',
            nested_syntaxes = { python = 'python', go = 'go', json = 'json' },
        }
    }

    vim.g.vimwiki_listsyms = '✗○◐●✓'

    vim.api.nvim_command("augroup VimWiki")
    vim.api.nvim_command("autocmd!")
    vim.api.nvim_command("autocmd FileType vimwiki setlocal colorcolumn=80")
    vim.api.nvim_command("autocmd FileType vimwiki nmap <silent><buffer> <leader>ct <Plug>VimwikiToggleListItem")
    vim.api.nvim_command(
        'autocmd FileType vimwiki inoremap <expr><silent><buffer> <CR> complete_info()["selected"] != "-1" ? "\\<C-y>" : "\\<C-]>\\<Esc>:VimwikiReturn 1 5\\<CR>"')
    vim.api.nvim_command("augroup VimWiki")
end

return M
