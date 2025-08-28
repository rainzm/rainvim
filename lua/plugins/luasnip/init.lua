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
		--dependencies = { "rafamadriz/friendly-snippets" },
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

			-- https://github.com/L3MON4D3/LuaSnip/issues/656
			-- https://github.com/Saghen/blink.cmp/issues/2035
			vim.api.nvim_create_autocmd("ModeChanged", {
				desc = "Unlink current snippet on leaving insert/selection mode.",
				group = vim.api.nvim_create_augroup("LuaSnipModeChanged", {}),
				pattern = "[si]*:[^si]*",
				-- Blink.cmp will enter normal mode shortly on accepting snippet completion,
				-- see https://github.com/Saghen/blink.cmp/issues/2035
				-- We don't want to unlink the current snippet in that case, as a workaround
				-- wait a short time after leaving insert/select mode and unlink current
				-- snippet if still not inside insert/select mode
				callback = vim.schedule_wrap(function(args)
					if vim.fn.mode():match("^[si]") then -- still in insert/select mode
						return
					end
					if ls.session.current_nodes[args.buf] and not ls.session.jump_active then
						ls.unlink_current()
					end
				end),
			})
			-- vim.keymap.set({ "i", "s", "n" }, "<esc>", function()
			-- 	if require("luasnip").expand_or_jumpable() then
			-- 		require("luasnip").unlink_current()
			-- 	end
			-- 	return "<esc>"
			-- end, { expr = true })
		end,
	},
}
