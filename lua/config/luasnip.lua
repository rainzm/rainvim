local M = {}

function M.setup()
  local luasnip = require "luasnip"
  luasnip.filetype_extend("vimwiki", {"markdown"})
  require("luasnip.loaders.from_vscode").lazy_load()
end

return M
