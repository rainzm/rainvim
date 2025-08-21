return {
	{
		"mireq/luasnip-snippets",
		dependencies = { "L3MON4D3/LuaSnip" },
		config = function()
			-- Mandatory setup function
			require("luasnip_snippets.common.snip_utils").setup()
		end,
	},
	{

		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "v2.*",
		lazy = true,
		config = function()
			local ls = require("luasnip")
			ls.setup({
				-- Required to automatically include base snippets, like "c" snippets for "cpp"
				load_ft_func = require("luasnip_snippets.common.snip_utils").load_ft_func,
				ft_func = require("luasnip_snippets.common.snip_utils").ft_func,
				-- To enable auto expansin
				enable_autosnippets = true,
				-- Uncomment to enable visual snippets triggered using <c-x>
				-- store_selection_keys = '<c-x>',
			})
			require("plugins.luasnip.custom")
			local unlinkgrp = vim.api.nvim_create_augroup("UnlinkSnippetOnModeChange", { clear = true })
			vim.api.nvim_create_autocmd("ModeChanged", {
				group = unlinkgrp,
				pattern = { "s:n", "i:*" },
				desc = "Forget the current snippet when leaving the insert mode",
				callback = function(evt)
					if ls.session and ls.session.current_nodes[evt.buf] and not ls.session.jump_active then
						ls.unlink_current()
					end
				end,
			})
		end,
	},
}
