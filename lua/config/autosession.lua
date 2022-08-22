local M = {}

function M.setup()
  local ms = require 'mappings'
  ms.nnoremap('<Leader>ls', '<cmd>SearchSession<CR>')
end

function M.config()
  local function restore_nvim_tree()
    local nvim_tree = require('nvim-tree')
    nvim_tree.change_dir(vim.fn.getcwd())
    nvim_tree.refresh()
  end

  require("auto-session").setup {
    --log_level = "info",
    --auto_save_enabled = true,
    auto_restore_enabled = false,
    --auto_session_enable_last_session = false,
    auto_session_use_git_branch = true,
    --auto_session_create_enabled = true,
    postrestore_cmds = { restore_nvim_tree }
  }
end

function M.lens_config()
  require 'session-lens'.setup {
    theme_conf = {
      layout_strategy = 'vertical',
      layout_config = { width = 0.5, height = 0.5, prompt_position = 'bottom' },
    },
    previewer = false,
  }
  require("telescope").load_extension "session-lens"
end

return M
