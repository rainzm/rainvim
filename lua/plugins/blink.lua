local M = {
	"saghen/blink.cmp",
	--dependencies = { "rafamadriz/friendly-snippets" },
	dependencies = { "L3MON4D3/LuaSnip" },

	version = "1.*",
	opts = {
		keymap = {
			preset = "enter",
			["<C-d>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-space>"] = {},

			["<C-k>"] = {},
		},
		snippets = { preset = "luasnip" },

		accept = { auto_brackets = { enabled = true } },

		appearance = {
			nerd_font_variant = "mono",
		},

		completion = {
			documentation = { auto_show = false },
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
