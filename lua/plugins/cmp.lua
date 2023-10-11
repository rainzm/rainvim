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
		"L3MON4D3/LuaSnip",
	},
	event = "InsertEnter *",
}

function M.init()
	vim.o.completeopt = "menu,menuone"
end

function M.config()
	local kind_icons = {
		Text = " ",
		Method = " ",
		Function = "󰊕 ",
		Constructor = " ",
		Field = "󰇽 ",
		Variable = "󰂡 ",
		Class = "󰠱 ",
		Interface = " ",
		Module = " ",
		Property = "󰜢 ",
		Unit = " ",
		Value = "󰎠 ",
		Enum = " ",
		Keyword = "󰌋 ",
		Snippet = " ",
		Color = "󰏘 ",
		File = "󰈙 ",
		Reference = " ",
		Folder = "󰉋 ",
		EnumMember = " ",
		Constant = "󰏿 ",
		Struct = " ",
		Event = "",
		Operator = "󰆕 ",
		TypeParameter = "󰅲 ",
	}

	local has_words_before = function()
		unpack = unpack or table.unpack
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	local luasnip = require("luasnip")
	local cmp = require("cmp")
	local compare = require("cmp.config.compare")

	-- https://github.com/L3MON4D3/LuaSnip/issues/656
	local unlinkgrp = vim.api.nvim_create_augroup("UnlinkSnippetOnModeChange", { clear = true })
	vim.api.nvim_create_autocmd("ModeChanged", {
		group = unlinkgrp,
		pattern = { "s:n", "i:*" },
		desc = "Forget the current snippet when leaving the insert mode",
		callback = function(evt)
			if luasnip.session and luasnip.session.current_nodes[evt.buf] and not luasnip.session.jump_active then
				luasnip.unlink_current()
			end
		end,
	})
	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
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
			["<C-d>"] = function()
				if cmp.visible_docs() then
					cmp.close_docs()
				else
					cmp.open_docs()
				end
			end,
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				elseif luasnip.expand_or_locally_jumpable() then
					luasnip.expand_or_jump()
				elseif has_words_before() then
					cmp.complete()
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
				-- vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
				-- Source
				-- vim_item.menu = entry:get_completion_item().detail
				vim_item.menu = ({
					buffer = "[Buffer]",
					nvim_lsp = "[LSP]",
					luasnip = "[LuaSnip]",
					nvim_lua = "[Lua]",
					latex_symbols = "[LaTeX]",
				})[entry.source.name]
				return vim_item
			end,
		},
		view = {
			docs = {
				auto_open = false,
			},
		},
		window = {
			-- documentation = cmp.config.disable,
			documentation = cmp.config.window.bordered(),
		},
		preselect = cmp.PreselectMode.None,
		completion = {
			completeopt = "menu,menuone",
		},
		-- preselect = cmp.PreselectMode.None,
		sources = {
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{
				name = "buffer",
				option = {
					get_bufnrs = function()
						return vim.api.nvim_list_bufs()
					end,
				},
			},
		},
	})
	cmp.setup.filetype({ "markdown", "gitcommit", "norg" }, {
		sorting = {
			comparators = {
				compare.sort_text,
				compare.offset,
				compare.exact,
				compare.score,
				compare.recently_used,
				compare.kind,
				compare.length,
				compare.order,
			},
		},
		mapping = {
			["<C-e>"] = cmp.mapping.abort(),
			-- ["<CR>"] = cmp.mapping.confirm({
			-- 	behavior = cmp.ConfirmBehavior.Replace,
			-- 	select = true,
			-- }),
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
			["<CR>"] = cmp.mapping(function(fallback)
				local entry = cmp.get_selected_entry()
				if entry == nil then
					entry = cmp.core.view:get_first_entry()
				end
				if entry and entry.source.name == "nvim_lsp" and entry.source.source.client.name == "rime_ls" then
					cmp.abort()
				else
					if entry ~= nil then
						cmp.confirm({
							behavior = cmp.ConfirmBehavior.Replace,
							select = true,
						})
					else
						fallback()
					end
				end
			end, { "i", "s" }),
		},
		formatting = {
			format = function(entry, vim_item)
				-- Kind icons
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
				if entry.source.name == "nvim_lsp" and entry.source.source.client.name == "rime_ls" then
					-- vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
					vim_item.kind = ""
					vim_item.menu = "[Rime]"
					-- else
					-- vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
				end
				return vim_item
			end,
		},
		sources = {
			{ name = "neorg", priority = 90 },
			{ name = "nvim_lsp", priority = 80 },
			{ name = "luasnip", priority = 100 },
			{
				name = "buffer",
				option = {
					get_bufnrs = function()
						return vim.api.nvim_list_bufs()
					end,
				},
			},
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
