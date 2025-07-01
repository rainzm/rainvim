local M = {}

local servers = {
	gopls = {
		cmd = { "gopls", "-remote=auto" },
		settings = {
			gopls = {
				-- --tags=linux
				env = { GOFLAGS = "-mod=mod" },
				directoryFilters = { "-vendor", "-docs", "-scripts" },
			},
		},
	},
	lua_ls = {
		-- root_dir = function()
		-- 	return vim.fn.getcwd()
		-- end,
		settings = {
			Lua = {
				runtime = {
					path = { "?.lua", "?/init.lua" },
					pathStrict = true,
					version = "LuaJIT",
				},
				telemetry = {
					enable = false,
				},
				completion = {
					callSnippet = "Replace",
				},
				diagnostics = {
					disable = { "missing-fields" },
				},
			},
		},
	},
	bashls = {},
	--marksman = {},
	clangd = {},
	pyright = {},
	rust_analyzer = {},
	jsonls = {},
}

-- @param client: (required, vim.lsp.client)
local function current_function_on_attach(client, bufnr)
	-- Register the client for messages
	require("lsp-status").register_client(client.id, client.name)

	if client.server_capabilities.documentSymbolProvider then
		local group = vim.api.nvim_create_augroup("LspCurrentFunction", { clear = true })
		vim.api.nvim_create_autocmd("CursorHold", {
			group = group,
			buffer = bufnr,
			callback = function()
				if not require("plugins.lualine").show_current_function then
					return
				end
				require("lsp-status").update_current_function()
			end,
		})
	end
end

local function on_attach(client, bufnr)
	-- disable senmantic tokens: https://gist.github.com/swarn/fb37d9eefe1bc616c2a7e476c0bc0316#what-is-semantic-highlighting
	client.server_capabilities.semanticTokensProvider = nil
	require("plugins.lsp.format").on_attach(client, bufnr)
	require("plugins.lsp.keymaps").setup(client, bufnr)
	current_function_on_attach(client)
end

--local capabilities = vim.lsp.protocol.make_client_capabilities()

local function showLineDiagnostic(_)
	vim.diagnostic.open_float(0, { scope = "line" })
end

function M.setup()
	-- require("neodev").setup({})
	-- Setup LSP handlers
	require("plugins.lsp.handlers").setup()
	require("plugins.lsp.format").autoformat = true

	local mapping = require("mappings")

	local opts = { noremap = true, silent = true }
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
	mapping.nnoremap("<leader>e", '<cmd>lua require("telescope.builtin").diagnostics({bufnr=0})<CR>')
	mapping.nnoremap("<leader>E", '<cmd>lua require("telescope.builtin").diagnostics()<CR>')
	vim.api.nvim_create_user_command("DiagnosticLine", showLineDiagnostic, { force = true })

	opts = {
		on_attach = on_attach,
		--capabilities = capabilities,
	}
	for server_name, _ in pairs(servers) do
		local lopts = vim.tbl_deep_extend("force", opts, servers[server_name] or {})
		vim.lsp.config(server_name, lopts)
		vim.lsp.enable(server_name)
	end
	vim.lsp.enable("rime_ls")
	-- vim.api.nvim_create_autocmd("FileType", {
	-- 	pattern = { "copilot-chat" },
	-- 	callback = function(env)
	-- 		-- copilot cannot attach client automatically, we must attach manually.
	-- 		local rime_ls_client = vim.lsp.get_clients({ name = "rime_ls" })
	-- 		if #rime_ls_client == 0 then
	-- 			vim.cmd("LspStart rime_ls")
	-- 			rime_ls_client = vim.lsp.get_clients({ name = "rime_ls" })
	-- 		end
	-- 		if #rime_ls_client > 0 then
	-- 			vim.lsp.buf_attach_client(env.buf, rime_ls_client[1].id)
	-- 		end
	-- 	end,
	-- })
	-- vim.api.nvim_create_autocmd("FileType", {
	-- 	pattern = { "AvanteInput" },
	-- 	callback = function(env)
	-- 		-- copilot cannot attach client automatically, we must attach manually.
	-- 		local rime_ls_client = vim.lsp.get_clients({ name = "rime_ls" })
	-- 		if #rime_ls_client == 0 then
	-- 			vim.cmd("LspStart rime_ls")
	-- 			rime_ls_client = vim.lsp.get_clients({ name = "rime_ls" })
	-- 		end
	-- 		if #rime_ls_client > 0 then
	-- 			vim.lsp.buf_attach_client(env.buf, rime_ls_client[1].id)
	-- 		end
	-- 		local bufnr = env.buf
	-- 		local filetype = vim.bo[bufnr].filetype
	-- 		local text = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
	-- 		local pwd = os.getenv("PWD") or "."
	-- 		vim.lsp.buf_notify(bufnr, "textDocument/didOpen", {
	-- 			textDocument = {
	-- 				uri = "file://" .. pwd .. "/AvanteInput",
	-- 				languageId = filetype,
	-- 				version = 0,
	-- 				text = text,
	-- 			},
	-- 		})
	-- 	end,
	-- })

	-- vim.api.nvim_create_autocmd("FileType", {
	-- 	pattern = "copilot-chat",
	-- 	callback = function(args)
	-- 		local bufnr = args.buf
	-- 		local filetype = vim.bo[bufnr].filetype
	-- 		local text = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
	-- 		local pwd = os.getenv("PWD") or "."
	-- 		vim.lsp.buf_notify(bufnr, "textDocument/didOpen", {
	-- 			textDocument = {
	-- 				uri = "file://" .. pwd .. "/copilot-chat",
	-- 				languageId = filetype,
	-- 				version = 0,
	-- 				text = text,
	-- 			},
	-- 		})
	-- 	end,
	-- })
	--vim.lsp.enable("iwes")
end

return M
