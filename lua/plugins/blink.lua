local M = {
	"saghen/blink.cmp",
	enabled = false,
	dependencies = { "rafamadriz/friendly-snippets" },

	version = "1.*",
	opts = {
		keymap = { preset = "default" },

		appearance = {
			nerd_font_variant = "mono",
		},

		completion = {
			documentation = { auto_show = false },
			menu = {
				-- nvim-cmp style menu
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind" },
						--{ "source_name", gap = 1 },
					},
				},
			},
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}

return M
