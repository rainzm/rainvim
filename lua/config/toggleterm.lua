local M = {}

function M.config()
  local width = vim.o.columns * 0.7
  local height = vim.o.lines * 0.7
  require("toggleterm").setup {
    direction = 'float',
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
      width = width - width % 1,
      height = height - height % 1,
      winblend = 10,
    },
    winbar = {
      border = 'rounded',
      enabled = false,
      name_formatter = function(term) --  term: Terminal
        return term.name
      end
    },
  }
end

return M
