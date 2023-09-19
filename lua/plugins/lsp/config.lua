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
		root_dir = function()
			return vim.fn.getcwd()
		end,
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
	marksman = {},
	clangd = {},
	pyright = {},
}

local function on_attach(client, bufnr)
	require("plugins.lsp.format").on_attach(client, bufnr)
	require("plugins.lsp.keymaps").setup(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities) -- for nvim-cmp

local function showLineDiagnostic(_)
	vim.diagnostic.open_float(0, { scope = "line" })
end

function M.setup()
	-- require("neodev").setup({})
	-- Setup LSP handlers
	require("plugins.lsp.handlers").setup()
	require("plugins.lsp.format").autoformat = true

	local mapping = require("mappings")
	local lspconfig = require("lspconfig")

	local opts = { noremap = true, silent = true }
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
	mapping.nnoremap("<leader>e", '<cmd>lua require("telescope.builtin").diagnostics({bufnr=0})<CR>')
	mapping.nnoremap("<leader>E", '<cmd>lua require("telescope.builtin").diagnostics()<CR>')
	vim.api.nvim_create_user_command("DiagnosticLine", showLineDiagnostic, { force = true })

	opts = {
		on_attach = on_attach,
		capabilities = capabilities,
		--flags = {
		-- debounce_text_changes = 150,
		--},
	}
	for server_name, _ in pairs(servers) do
		local lopts = vim.tbl_deep_extend("force", opts, servers[server_name] or {})
		lspconfig[server_name].setup(lopts)
	end
	require("plugins/lsp/rime_ls").setup_rime()
end

return M
