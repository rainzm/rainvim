local M = {}

local servers = {
    gopls = {
        cmd = { 'gopls', '-remote=auto' },
        settings = {
            gopls = {
                env = { GOFLAGS = "-mod=mod" },
                directoryFilters = { '-vendor', '-docs', '-scripts' },
            }
        }
    },
    lua_ls = {
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { 'vim' },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false, -- THIS IS THE IMPORTANT LINE TO ADD
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
    },
    bashls = {},
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
    -- Setup LSP handlers
    require("plugins.lsp.handlers").setup()
    require("neodev").setup({})
    require("plugins.lsp.format").autoformat = true

    local mapping = require "mappings"
    local lspconfig = require "lspconfig"


    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    mapping.nnoremap('<leader>e', '<cmd>lua require("telescope.builtin").diagnostics({bufnr=0})<CR>')
    mapping.nnoremap('<leader>E', '<cmd>lua require("telescope.builtin").diagnostics()<CR>')
    vim.api.nvim_create_user_command('DiagnosticLine', showLineDiagnostic, { force = true })

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
end

return M
