-- Completion
local M = {
	"hrsh7th/nvim-cmp",
	dependencies = {
		{
			"windwp/nvim-autopairs",
			config = true,
		},
		{ "hrsh7th/cmp-buffer" },
		{ "saadparwaiz1/cmp_luasnip" },
		"hrsh7th/cmp-nvim-lsp",
		{
			"L3MON4D3/LuaSnip",
			config = function()
				-- local luasnip = require "luasnip"
				-- luasnip.filetype_extend("vimwiki", { "markdown" })
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		"rafamadriz/friendly-snippets",
	},
	event = "InsertEnter *",
}

function M.init()
	vim.o.completeopt = "menu,menuone"
end

function M.config()
	local kind_icons = {
		Text = "",
		Method = "",
		Function = "",
		Constructor = "",
		Field = "",
		Variable = "",
		Class = "ﴯ",
		Interface = "",
		Module = "",
		Property = "ﰠ",
		Unit = "",
		Value = "",
		Enum = "",
		Keyword = "",
		Snippet = "",
		Color = "",
		File = "",
		Reference = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "",
		Event = "",
		Operator = "",
		TypeParameter = "",
	}

	local has_words_before = function()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	local luasnip = require("luasnip")
	local cmp = require("cmp")
	local compare = require("cmp.config.compare")
	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		-- sorting = {
		-- 	comparators = {
		-- 		--compare.sort_text,
		-- 		compare.score,
		-- 		compare.offset,
		-- 		--compare.exact,
		-- 		--compare.recently_used,
		-- 		--compare.locality,
		-- 		compare.kind,
		-- 		--compare.length,
		-- 		--compare.order,
		-- 	},
		-- },
		sorting = {
			comparators = {
				compare.sort_text,
				compare.offset,
				compare.exact,
				compare.score,
				compare.recently_used,
				compare.locality,
				compare.kind,
				compare.length,
				compare.order,
			},
		},
		mapping = {
			["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
			["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.close(),
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			}),
			-- ["<CR>"] = cmp.mapping(function(fallback)
			-- 	local entry = cmp.get_selected_entry()
			-- 	if entry then
			-- 		if entry.source.name == "nvim_lsp" and entry.source.source.client.name == "rime_ls" then
			-- 			cmp.close()
			-- 		else
			-- 			cmp.confirm({
			-- 				behavior = cmp.ConfirmBehavior.Replace,
			-- 				select = true,
			-- 			})
			-- 		end
			-- 	else
			-- 		fallback()
			-- 	end
			-- end, { "i", "s" }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				elseif not has_words_before() then
					fallback()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<Space>"] = cmp.mapping(function(fallback)
				local entry = cmp.get_selected_entry()
				if entry and entry.source.name == "nvim_lsp" and entry.source.source.client.name == "rime_ls" then
					cmp.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					})
				else
					fallback()
				end
			end, { "i", "s" }),
			-- ["<S-Tab>"] = cmp.mapping(function(fallback)
			-- 	if cmp.visible() then
			-- 		cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
			-- 	elseif luasnip.jumpable(-1) then
			-- 		luasnip.jump(-1)
			-- 	else
			-- 		fallback()
			-- 	end
			-- end, { "i", "s" }),
		},
		formatting = {
			format = function(entry, vim_item)
				-- Kind icons
				vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
				-- Source
				-- vim_item.menu = entry:get_completion_item().detail
				vim_item.menu = ({
					buffer = "[Buffer]",
					nvim_lsp = "[LSP]",
					luasnip = "[LuaSnip]",
					nvim_lua = "[Lua]",
					latex_symbols = "[LaTeX]",
					neorg = "[Neorg]",
				})[entry.source.name]
				return vim_item
			end,
		},
		window = {
			documentation = cmp.config.disable,
		},
		preselect = cmp.PreselectMode.None,
		completion = {
			completeopt = "menu,menuone",
		},
		-- preselect = cmp.PreselectMode.None,
		sources = {
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "buffer" },
			{ name = "neorg" },
			--{ name = 'nvim_lsp_signature_help' },
		},
	})
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	cmp.event:on(
		"confirm_done",
		cmp_autopairs.on_confirm_done({
			filetypes = {
				sh = false,
			},
		})
	)
end

return M
