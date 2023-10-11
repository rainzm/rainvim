return {
	{
		"github/copilot.vim",
		enabled = false,
		init = function()
			vim.g.copilot_proxy = "127.0.0.1:7890"
			vim.g.copilot_no_tab_map = true
			-- imap <silent> <leader>j <Plug>(copilot-next)
			-- imap <silent> <leader>k <Plug>(copilot-previous)
			vim.cmd([[
			    imap <silent><script><expr> <C-n> copilot#Accept("\<CR>")
                imap <silent> <C-\> <Plug>(copilot-dismiss)
            ]])
		end,
		config = function()
			-- imap <silent> <C-]> <Plug>(copilot-next)
			-- imap <silent> <C-[> <Plug>(copilot-previous)
		end,
	},
	{
		"Exafunction/codeium.vim",
		init = function()
			vim.g.codeium_no_map_tab = true
			vim.keymap.set("i", "<C-n>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<c-]>", function()
				vim.fn["codeium#CycleCompletions"](1)
				require("lualine").refresh({
					scope = "window",
					place = { "statusline" },
				})
			end, { expr = true, silent = true })
			-- vim.keymap.set("i", "<c-\\>", function()
			-- 	return vim.fn["codeium#CycleCompletions"](-1)
			-- end, { expr = true })
			vim.keymap.set("i", "<c-\\>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true, silent = true })
		end,
	},
}
