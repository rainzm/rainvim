local ui = {}

function ui.nvim_tree()
    vim.g.nvim_tree_show_icons = {
        git = 0,
        folders = 1,
        files = 1,
        folder_arrows = 0,
    }
    vim.g.nvim_tree_icons = {
        default = '',
        symlink = '',
    }
    vim.g.nvim_tree_special_files = {}
    local list = {
        { key = "za", action = "close_node" },
        { key = "c", action = "copy" },
        { key = "p", action = "paste" },
        { key = "v", action = "vsplit" },
        { key = "s", action = "split" },
        { key = "d", action = "remove" },
        { key = "r", action = "rename" },
        { key = "R", action = "refresh" },
    }
	require("nvim-tree").setup({
		disable_netrw = true,
		hijack_netrw = true,
		open_on_setup = false,
		ignore_ft_on_setup = {},
		open_on_tab = false,
		filters = { dotfiles = true, custom = {"_output"} },
		git = { enable = false },
		view = {
			width = 30,
			height = 30,
			hide_root_folder = true,
			side = "left",
			auto_resize = false,
			mappings = { custom_only = false, list = list },
			number = false,
			relativenumber = false,
            signcolumn = "no",
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

function ui.lightline()
    vim.g.lightline = {
	    colorscheme = 'MyGruvbox',
	    active = {
	        left = { { 'mode', 'paste' },
	            { 'readonly', 'myfilename' }},
            right = { { 'percent' },
                { 'fileformat', 'fileencoding', 'filetype' }}
	    },
        inactive = {
            left = {{'myfilename'}},
            right = {{'percent'}},
        },
        component = {
            fileformat = '%{&ff=="unix"?"":&ff}',
            fileencoding = '%{&fenc=="utf-8"?"":&fenc}',
            myfilename = '%f%m',
        },
        component_visible_condition = {
            fileformat = '&ff&&&ff!="unix"',
            fileencoding = '&fenc&&&fenc!="utf-8"',
        },
	 }
end

return ui
