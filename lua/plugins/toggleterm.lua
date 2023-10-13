local M = {
	"akinsho/toggleterm.nvim",
	version = "*",
	cmd = "ToggleTerm",
	keys = {
		{ "<Leader>3", "<cmd>ToggleTerm<CR>", desc = "Toggle float terminal" },
		{ "<Leader>tv", "<cmd>lua vertterm_toggle()<CR>", desc = "Toggle vert termianl" },
		{ "<Leader>ts", "<cmd>lua horiterm_toggle()<CR>", desc = "Toggle hori termianl" },
	},
}

function M.config()
	local width = vim.o.columns * 0.7
	local height = vim.o.lines * 0.7
	require("toggleterm").setup({
		direction = "float",
		-- This field is only relevant if direction is set to 'float'
		float_opts = {
			width = width - width % 1,
			height = height - height % 1,
			winblend = 10,
		},
		size = function(term)
			if term.direction == "horizontal" then
				return vim.o.lines * 0.25
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.25
			end
		end,
		winbar = {
			border = "rounded",
			enabled = false,
			name_formatter = function(term) --  term: Terminal
				return term.name
			end,
		},
	})
	vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], {})
	vim.api.nvim_set_keymap("t", "<leader>3", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
	local Terminal = require("toggleterm.terminal").Terminal
	local vertTerm = Terminal:new({
		direction = "vertical",
		hidden = true,
	})
	local horiTerm = Terminal:new({
		direction = "horizontal",
		hidden = true,
	})

	vertterm_toggle = function()
		vertTerm:toggle()
	end
	horiterm_toggle = function()
		horiTerm:toggle()
	end

	-- vim.api.nvim_set_keymap("n", "<leader>tv", "<cmd>lua _vertterm_toggle()<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("t", "<leader>tv", "<cmd>lua vertterm_toggle()<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("t", "<leader>ts", "<cmd>lua horiterm_toggle()<CR>", { noremap = true, silent = true })
end

return M
