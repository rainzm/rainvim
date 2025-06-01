-- startup config
local M = {
	"goolord/alpha-nvim",
	dependencies = { "kyazdani42/nvim-web-devicons" },
}

function M.config()
	local api = vim.api
	-- Generates a button for alpha.nvim dashboard configuration.
	-- @param label the text that will be displayed at this button
	-- @param shortcut the shortcut key label text
	-- @param hl_icon the highlight group of the label icon
	-- @param hl_label the highlight group for the button label text
	-- @return table options table that will be passed onto the alpha setup function
	local btn_gen = function(label, shortcut, hl_label, hl_icon)
		return {
			type = "button",
			on_press = function()
				local key =
					api.nvim_replace_termcodes(shortcut:gsub("%s", ""):gsub("LDR", "<leader>"), true, false, true)
				api.nvim_feedkeys(key, "normal", false)
			end,
			val = label,
			opts = {
				position = "center",
				shortcut = shortcut,
				cursor = 5,
				width = 40,
				align_shortcut = "right",
				hl_shortcut = "AlphaKeyPrefix",
				hl = {
					{ hl_icon, 1, 3 }, -- highlight the icon glyph
					{ hl_label, 4, 15 }, -- highlight the part after the icon glyph
				},
			},
		}
	end

	local banners = {
		["pacman"] = {
			[[                                    ██████                                    ]],
			[[                                ████▒▒▒▒▒▒████                                ]],
			[[                              ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                              ]],
			[[                            ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                            ]],
			[[                          ██▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒                              ]],
			[[                          ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▓▓▓▓                          ]],
			[[                          ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▒▒▓▓                          ]],
			[[                        ██▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒    ██                        ]],
			[[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
			[[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
			[[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
			[[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
			[[                        ██▒▒██▒▒▒▒▒▒██▒▒▒▒▒▒▒▒██▒▒▒▒██                        ]],
			[[                        ████  ██▒▒██  ██▒▒▒▒██  ██▒▒██                        ]],
			[[                        ██      ██      ████      ████                        ]],
		},
		["areee"] = {
			"⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⣀⣤⣴⣶⣾⣿⣿⣿⣶⣶⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⢿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀ ",
			"⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⣿⣿⡟⠁⠀⠀⠀⠈⢻⣿⣿⣿⠀⠀⠀⠀⠀⠀ ",
			"⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⠛⠛⠛⠛⠛⠛⢛⣿⣮⣿⣿⣿⠀⠀⠀⠀⠀⠀⢈⣿⣿⡟⠀⠀⠀⠀⠀⠀ ",
			"⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣧⡀⠀⠀⠀⢀⣼⣿⣿⣿⣿⣿⣧⡀⠀⠀⠀⢀⣼⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣶⣿⣿⣿⣿⠟⠉⠻⣿⣿⣿⣿⣶⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣠⣷⡀⢹⣿⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠋⠛⠋⠛⠙⠛⠙⠛⠙⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
		},
		["uwu"] = {
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⣶⣿⣿⣿⣿⣶⣶⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀ ",
			"⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⡿⠿⠛⠻⠿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠛⠿⢿⣿⣿⣿⡇⠀⠀⠀⠀⠀ ",
			"⠀⠀⠀⠀⠀⠀⢸⣿⣿⠏⣠⣤⡄⣠⣤⡌⢿⣿⣿⣿⣿⡿⢁⣤⣄⢀⣤⣄⠹⣿⣿⡇⠀⠀⠀⠀⠀ ",
			"⠀⠀⠀⠀⠀⠀⠸⣿⣿⠀⢿⣿⣿⣿⣿⡟⢸⣿⣿⣿⣿⡇⠸⣿⣿⣿⣿⡿⠀⣿⣿⠇⠀⠀⠀⠀⠀ ",
			"⠀⠀⠀⠀⠀⠀⠀⢻⣿⣆⠀⠙⠿⠟⠋⢀⣾⣿⣿⣿⣿⣷⡀⠈⠻⡿⠋⠁⣰⣿⡟⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣶⣶⣶⣾⣿⣿⡿⠋⠙⢿⣿⣿⣷⣶⣶⣶⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⢁⣴⣧⡀⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠙⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠋⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠛⠙⠛⠙⠛⠛⠋⠛⠋⠛⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
		},
	}

	local heading = {
		type = "text",
		val = banners["areee"],
		opts = {
			position = "center",
			hl = "AlphaHeading",
		},
	}

	local buttons = {
		type = "group",
		val = {
			--btn_gen("  Find File", " LDR tff ", "AlphaButtonLabelText", "WildMenu"),
			btn_gen("󱁴  Files", " LDR p  ", "AlphaButtonLabelText", "String"),
			--btn_gen("  Sessions", " LDR ls ", "AlphaButtonLabelText", "Boolean"),
			btn_gen("󱑁  Sessions", " LDR ls ", "AlphaButtonLabelText", "Boolean"),
			btn_gen("󱠏  Projects", " LDR lp ", "AlphaButtonLabelText", "String"),
			--btn_gen("󰺿  Notebooks", "LDR nn ", "AlphaButtonLabelText", "String"),
			--btn_gen("󱓩  Work Today", "LDR nwt", "AlphaButtonLabelText", "String"),
			--btn_gen("  Settings" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
		},
		opts = {
			position = "center",
			spacing = 1,
		},
	}

	--local loaded = {
	--  type = "text",
	--  val = string.format(" Loaded %d plugins", vim.tbl_count(packer_plugins)),
	--  opts = {
	--    position = "center",
	--    hl = "AlphaLoaded",
	--  },
	--}

	local footing = {
		type = "text",
		val = "-rainvim- ",
		opts = {
			position = "center",
			hl = "AlphaFooting",
		},
	}

	local layout = {
		{ type = "padding", val = 9 },
		heading,
		{ type = "padding", val = 2 },
		footing,
		{ type = "padding", val = 1 },
		buttons,
		--{ type = "padding", val = 1 },
		--loaded,
	}

	local config = {
		layout = layout,
		opts = { margin = 10 },
	}
	require("alpha").setup(config)
end

return M
