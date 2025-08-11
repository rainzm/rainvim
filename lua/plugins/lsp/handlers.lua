local M = {}

local icons = require("plugins.utils.icons")

function M.setup()
	-- local signs = {
	--     { name = "DiagnosticSignError", text = icons.diagnostics.Error },
	--     { name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
	--     { name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
	--     { name = "DiagnosticSignInfo",  text = icons.diagnostics.Info },
	-- }
	-- for _, sign in ipairs(signs) do
	--     vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
	-- end

	-- LSP handlers configuration
	local config = {
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
		},
		diagnostic = {
			-- virtual_text = false,
			-- virtual_text = { spacing = 4, prefix = "●" },
			virtual_text = {
				severity = {
					min = vim.diagnostic.severity.ERROR,
				},
			},
			signs = {
				text = {
					-- 使用 vim.diagnostic.severity 来引用，更规范
					[vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
					[vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
					[vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
					[vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
				},
			},
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			float = {
				focusable = true,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
			-- virtual_lines = true,
		},
	}

	-- Diagnostic configuration
	vim.diagnostic.config(config.diagnostic)
end

return M
