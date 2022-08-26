local M = {}

local servers = {
  gopls = {
    cmd = { 'gopls', '-remote=auto' },
    settings = {
      gopls = {
        --    env = { GOOS = 'linux' },
        directoryFilters = { '-vendor', '-docs', '-scripts' },
      }
    }
  },
  sumneko_lua = {},
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
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities) -- for nvim-cmp


-- Setup LSP handlers
require("config.lsp.handlers").setup()

function M.setup()
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
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = false,
  }

  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
    --flags = {
    -- debounce_text_changes = 150,
    --},
  }
  for server_name, _ in pairs(servers) do
    local lopts = vim.tbl_deep_extend("force", opts, servers[server_name] or {})
    if server_name == "sumneko_lua" then
      lopts = require("lua-dev").setup({ lspconfig = lopts })
    end
    lspconfig[server_name].setup(lopts)
  end
  vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]
end

return M
