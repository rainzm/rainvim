local M = {
	"saghen/blink.cmp",
	--dependencies = { "rafamadriz/friendly-snippets" },
	dependencies = { "L3MON4D3/LuaSnip" },

	version = "1.*",
	opts = {
		keymap = {
			preset = "none",
			["<C-d>"] = { "show", "show_documentation", "hide_documentation" },

			["<C-t>"] = { "show_signature", "hide_signature", "fallback" },
			["<C-e>"] = { "hide", "fallback" },
			["<CR>"] = { "accept", "fallback" },

			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },

			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },

			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-n>"] = {},
		},
		cmdline = {
			keymap = {
				preset = "none",
				["<Tab>"] = { "show_and_insert", "select_next" },
				["<S-Tab>"] = { "show_and_insert", "select_prev" },

				["<Down>"] = { "select_next", "fallback" },
				["<Up>"] = { "select_prev", "fallback" },

				["<C-y>"] = { "select_and_accept" },
				["<C-e>"] = { "cancel" },
			},
			completion = { menu = { auto_show = false } },
		},
		snippets = { preset = "luasnip" },

		-- appearance = {
		-- 	nerd_font_variant = "mono",
		-- },

		signature = {
			enabled = true,
			trigger = {
				-- Show the signature help automatically
				enabled = false,
			},
			window = {
				min_width = 1,
				max_width = 100,
				max_height = 10,
				border = "rounded", -- Defaults to `vim.o.winborder` on nvim 0.11+ or 'padded' when not defined/<=0.10
				winblend = 0,
				winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
				direction_priority = { "n", "s" },
				-- Can accept a function if you need more control
				-- direction_priority = function()
				--   if condition then return { 'n', 's' } end
				--   return { 's', 'n' }
				-- end,

				treesitter_highlighting = true,
				show_documentation = false,
			},
		},

		completion = {
			documentation = { auto_show = false },
			accept = { auto_brackets = { enabled = true } },
			menu = {
				draw = {
					padding = 0,
					columns = { { "kind_icon", gap = 1 }, { gap = 1, "label" }, { "kind", gap = 2 } },
					components = {
						kind_icon = {
							text = function(ctx)
								return " " .. ctx.kind_icon .. " "
							end,
							highlight = function(ctx)
								return "BlinkCmpKindIcon" .. ctx.kind
							end,
						},
						kind = {
							text = function(ctx)
								return " " .. ctx.kind .. " "
							end,
						},
					},
				},
			},
		},

		sources = {
			default = { "lazydev", "lsp", "path", "snippets", "buffer" },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					-- make lazydev completions top priority (see `:h blink.cmp`)
					score_offset = 100,
				},
				--codeium = { name = "Codeium", module = "codeium.blink", async = true },
			},
		},
		-- highlight = {
		-- 	use_nvim_cmp_as_default = true,
		-- },

		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}

return M
