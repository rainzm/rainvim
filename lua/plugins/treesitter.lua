return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false, -- last release is way too old and doesn't work on Windows
		build = ":TSUpdate",
		-- event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				-- init = function()
				--   -- PERF: no need to load the plugin, if we only need its queries for mini.ai
				--   local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
				--   local opts = require("lazy.core.plugin").values(plugin, "opts", false)
				--   local enabled = false
				--   if opts.textobjects then
				--     for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
				--       if opts.textobjects[mod].enable then
				--         enabled = true
				--         break
				--       end
				--     end
				--   end
				--   if not enabled then
				--     require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
				--   end
				-- end,
			},
			{ "nvim-treesitter/playground" },
		},
		-- keys = {
		--   { "<c-space>", desc = "Increment selection" },
		--   { "<bs>", desc = "Schrink selection", mode = "x" },
		-- },
		---@type TSConfig
		opts = {
			highlight = { enable = true, dditional_vim_regex_highlighting = false },
			--indent = { enable = true, disable = { "python" } },
			--context_commentstring = { enable = true, enable_autocmd = false },
			ensure_installed = {
				"bash",
				"help",
				"go",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"regex",
				"tsx",
				"vim",
				"yaml",
				"query",
				"regex",
			},
			textobjects = {
				select = {
					enable = true,

					-- Automatically jump forward to textobj, similar to targets.vim
					lookahead = true,

					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						-- You can optionally set descriptions to the mappings (used in the desc parameter of
						-- nvim_buf_set_keymap) which plugins like which-key display
						["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
						-- You can also use captures from other query groups like `locals.scm`
						["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
					},
					-- You can choose the select mode (default is charwise 'v')
					--
					-- Can also be a function which gets passed a table with the keys
					-- * query_string: eg '@function.inner'
					-- * method: eg 'v' or 'o'
					-- and should return the mode ('v', 'V', or '<c-v>') or a table
					-- mapping query_strings to modes.
					selection_modes = {
						["@parameter.outer"] = "v", -- charwise
						["@function.outer"] = "V", -- linewise
						["@class.outer"] = "<c-v>", -- blockwise
					},
					-- If you set this to `true` (default is `false`) then any textobject is
					-- extended to include preceding or succeeding whitespace. Succeeding
					-- whitespace has priority in order to act similarly to eg the built-in
					-- `ap`.
					--
					-- Can also be a function which gets passed a table with the keys
					-- * query_string: eg '@function.inner'
					-- * selection_mode: eg 'v'
					-- and should return true of false
					include_surrounding_whitespace = true,
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_end = {
						["g]f"] = "@function.outer",
						["g]c"] = "@class.outer",
					},
					goto_previous_start = {
						["g[f"] = "@function.outer",
						["g[c"] = "@class.outer",
					},
				},
			},
			-- incremental_selection = {
			--   enable = true,
			--   keymaps = {
			--     init_selection = "<C-space>",
			--     node_incremental = "<C-space>",
			--     scope_incremental = "<nop>",
			--     node_decremental = "<bs>",
			--   },
			-- },
		},
		---@param opts TSConfig
		config = function(_, opts)
			-- local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
			-- ft_to_parser.vimwiki = "markdown"
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
