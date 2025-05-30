return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			-- labels = "sdfgqwertyuopzxcvbnm",
			search = {
				-- search/jump in all windows
				multi_window = false,
				--incremental = true,
			},
			highlight = {
				-- show a backdrop with hl FlashBackdrop
				backdrop = false,
				matches = false,
			},
			label = {
				after = false,
				before = { 0, 0 },
				uppercase = false,
			},
			modes = {
				search = {
					enabled = false,
				},
				char = {
					enabled = false,
				},
			},
			prompt = {
				enabled = false,
			},
			-- op
		},
        -- stylua: ignore
        keys = {
            -- {
            --     "f",
            --     mode = { "n", "x", "o" },
            --     function() require("flash").jump({ search = { wrap = false } }) end,
            --     desc = "Flash"
            -- },
            -- {
            --     "F",
            --     mode = { "n", "x", "o" },
            --     function() require("flash").jump({ search = { forward = false, wrap = false } }) end,
            --     desc = "Flash"
            -- },
            {
                "R",
                mode = { "n", "x", "o" },
                function() require("flash").treesitter() end,
                desc =
                "Flash Treesitter"
            },
            -- {
            --     "r",
            --     mode = "o",
            --     function() require("flash").remote() end,
            --     desc =
            --     "Remote Flash"
            -- },
        },
	},
	{
		"rainzm/flash-zh.nvim",
		event = "VeryLazy",
		rocks = "luautf8",
		dependencies = "folke/flash.nvim",
		opts = {
			char_map = {
				append_comma = {
					["."] = "…",
				},
			},
		},
		keys = {
			{
				"f",
				mode = { "n", "x", "o" },
				function()
					require("flash-zh").jump({
						search = { wrap = false },
					})
				end,
				desc = "Flash between Chinese",
			},
			{
				"F",
				mode = { "n", "x", "o" },
				function()
					require("flash-zh").jump({ search = { forward = false, wrap = false } })
				end,
				desc = "Flash between Chinese",
			},
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash-zh").jump({ chinese_only = false })
				end,
				desc = "Flash between Chinese",
			},
		},
	},
}
