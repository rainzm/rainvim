local M = {
	{
		"ggandor/flit.nvim",
		keys = function()
			local ret = {}
			for _, key in ipairs({ "f", "F" }) do
				ret[#ret + 1] = { key, mode = { "n", "x", "o", "v" }, desc = key }
			end
			return ret
		end,
		opts = {
			labeled_modes = "nvx",
			keys = { f = "f", F = "F", t = "", T = "" },
		},
	},
	{
		"ggandor/leap.nvim",
		dependencies = {
			"tpope/vim-repeat",
		},
		keys = {
			{
				mode = { "n", "v" },
				"t",
				"<cmd>lua require('plugins.move').leapChineseForward()<cr>",
				desc = "Leap Chinese Forward",
			},
			{
				mode = { "n", "v" },
				"T",
				"<cmd>lua require('plugins.move').leapChineseBackward()<cr>",
				desc = "Leap Chinese Backward",
			},
			{ "s", mode = { "n", "x", "o", "v" }, desc = "Leap forward to" },
			{ "S", mode = { "n", "x", "o", "v" }, desc = "Leap backward to" },
			{ "gs", mode = { "n", "x", "o", "v" }, desc = "Leap from windows" },
		},
		config = function(_, opts)
			local leap = require("leap")
			for k, v in pairs(opts) do
				leap.opts[k] = v
			end
			leap.add_default_mappings(true)
			vim.keymap.del({ "x", "o" }, "x")
			vim.keymap.del({ "x", "o" }, "X")
			vim.api.nvim_create_autocmd("User", {
				pattern = "LeapPatternPost",
				callback = require("input").switchEnglish,
			})
		end,
	},
}

function M.leapChineseForward()
	require("input").switchChinese()
	require("leap").leap({})
end

function M.leapChineseBackward()
	require("input").switchChinese()
	require("leap").leap({ backward = true })
end

return M
