return {
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		enabled = false,
		version = false, -- Never set this value to "*"! Never!
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"echasnovski/mini.pick", -- for file_selector provider mini.pick
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
			"ibhagwan/fzf-lua", -- for file_selector provider fzf
			"stevearc/dressing.nvim", -- for input provider dressing
			"folke/snacks.nvim", -- for input provider snacks
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
			},
			"MeanderingProgrammer/render-markdown.nvim",
		},
		config = function()
			require("avante").setup({
				-- add any opts here
				-- for example
				provider = "glm",
				providers = {
					kimi = {
						__inherited_from = "openai",
						api_key_name = "SILICONFLOW_API_KEY", -- Set this to your SiliconFlow API key environment variable name
						endpoint = "https://api.siliconflow.cn/v1",
						model = "Pro/moonshotai/Kimi-K2-Instruct",
						extra_request_body = {
							temperature = 0.75,
							max_tokens = 32768,
						},
					},
					qwen3 = {
						__inherited_from = "openai",
						api_key_name = "ALIYUN_API_KEY", -- Set this to your SiliconFlow API key environment variable name
						endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1",
						model = "qwen3-coder-plus",
						--model = "Moonshot-Kimi-K2-Instruct",
						extra_request_body = {
							temperature = 0.75,
							max_tokens = 65536,
						},
					},
					glm = {
						__inherited_from = "openai",
						api_key_name = "ZHIPU_API_KEY", -- Set this to your SiliconFlow API key environment variable name
						endpoint = "https://open.bigmodel.cn/api/paas/v4",
						model = "GLM-4.5",
						extra_request_body = {
							temperature = 0.75,
							max_tokens = 32768,
						},
					},
					["copilot-claude37"] = {
						__inherited_from = "copilot",
						model = "claude-3.7-sonnet",
					},
					["copilot-claude35"] = {
						__inherited_from = "copilot",
						model = "claude-3.5-sonnet",
					},
				},
			})
			local cmp = require("cmp")
			-- cmp.setup.filetype({ "AvanteInput" }, {
			-- 	enabled = true,
			-- 	sources = {
			-- 		{ name = "nvim_lsp" },
			-- 		{ name = "avante_commands" },
			-- 		{ name = "avante_mentions" },
			-- 		{ name = "avante_files" },
			-- 	},
			-- })
		end,
	},
}
