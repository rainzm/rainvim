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
  require("config.lsp.keymaps").setup(client, bufnr)
  require "lsp_signature".on_attach({
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      floating_window_off_x = 1, -- adjust float windows x position.
      floating_window_off_y = 0, -- adjust float windows y position.
      hint_enable = false, -- virtual hint enable
      floating_window = false,
      handler_opts = {
          border = 'rounded',
          style = "minimal",
      },
      max_height = 4,
      --transparency = 30,
      toggle_key = '<C-t>',
      select_signature_key = '<C-n>',
  }, bufnr)
  vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format({async = false})]]
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities) -- for nvim-cmp


-- Setup LSP handlers
require("config.lsp.handlers").setup()

local function showLineDiagnostic(opts)
  vim.diagnostic.open_float(0, { scope = "line" })
end

function M.setup()
  require("neodev").setup({})

  local mapping = require "mappings"
  local lspconfig = require "lspconfig"

  local icons = require "config.icons"

  require("mason").setup {
      ui = {
          border = "rounded",
          icons = {
              package_installed = icons.lsp.server_installed,
              package_pending = icons.lsp.server_pending,
              package_uninstalled = icons.lsp.server_uninstalled,
          },
      },
  }
  require("mason-lspconfig").setup {
      --ensure_installed = vim.tbl_keys(servers),
      automatic_installation = false,
  }

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
