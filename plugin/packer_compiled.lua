-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/rain/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/rain/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/rain/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/rain/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/rain/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    loaded = true,
    path = "/home/rain/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/rain/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/rain/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["hop.nvim"] = {
    config = { "\27LJ\2\n1\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\bhop\frequire\0" },
    loaded = true,
    path = "/home/rain/.local/share/nvim/site/pack/packer/start/hop.nvim",
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["lightline.vim"] = {
    config = { '\27LJ\2\nå\4\0\0\5\0\20\0!6\0\0\0009\0\1\0005\1\3\0005\2\6\0004\3\3\0005\4\4\0>\4\1\0035\4\5\0>\4\2\3=\3\a\0024\3\3\0005\4\b\0>\4\1\0035\4\t\0>\4\2\3=\3\n\2=\2\v\0015\2\r\0004\3\3\0005\4\f\0>\4\1\3=\3\a\0024\3\3\0005\4\14\0>\4\1\3=\3\n\2=\2\15\0015\2\16\0=\2\17\0015\2\18\0=\2\19\1=\1\2\0K\0\1\0 component_visible_condition\1\0\2\15fileformat\21&ff&&&ff!="unix"\17fileencoding\26&fenc&&&fenc!="utf-8"\14component\1\0\3\15fileformat\26%{&ff=="unix"?"":&ff}\17fileencoding\31%{&fenc=="utf-8"?"":&fenc}\15myfilename\t%f%m\rinactive\1\2\0\0\fpercent\1\0\0\1\2\0\0\15myfilename\vactive\nright\1\4\0\0\15fileformat\17fileencoding\rfiletype\1\2\0\0\fpercent\tleft\1\0\0\1\3\0\0\rreadonly\15myfilename\1\3\0\0\tmode\npaste\1\0\1\16colorscheme\14MyGruvbox\14lightline\6g\bvim\0' },
    loaded = true,
    path = "/home/rain/.local/share/nvim/site/pack/packer/start/lightline.vim",
    url = "https://github.com/itchyny/lightline.vim"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/home/rain/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/rain/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\nß\a\0\0\a\0'\00096\0\0\0009\0\1\0005\1\3\0=\1\2\0006\0\0\0009\0\1\0005\1\5\0=\1\4\0006\0\0\0009\0\1\0004\1\0\0=\1\6\0004\0\t\0005\1\a\0>\1\1\0005\1\b\0>\1\2\0005\1\t\0>\1\3\0005\1\n\0>\1\4\0005\1\v\0>\1\5\0005\1\f\0>\1\6\0005\1\r\0>\1\a\0005\1\14\0>\1\b\0006\1\15\0'\3\16\0B\1\2\0029\1\17\0015\3\18\0004\4\0\0=\4\19\0035\4\20\0005\5\21\0=\5\22\4=\4\23\0035\4\24\0=\4\25\0035\4\26\0005\5\27\0=\0\28\5=\5\29\4=\4\30\0035\4\31\0=\4 \0035\4$\0005\5\"\0005\6!\0=\6#\5=\5%\4=\4&\3B\1\2\1K\0\1\0\factions\14open_file\1\0\0\18window_picker\1\0\0\1\0\1\venable\2\ntrash\1\0\2\20require_confirm\2\bcmd\ntrash\tview\rmappings\tlist\1\0\1\16custom_only\1\1\0\b\tside\tleft\16auto_resize\1\vnumber\1\19relativenumber\1\21hide_root_folder\2\vheight\3\30\nwidth\3\30\15signcolumn\ano\bgit\1\0\1\venable\1\ffilters\vcustom\1\2\0\0\f_output\1\0\1\rdotfiles\2\23ignore_ft_on_setup\1\0\4\17hijack_netrw\2\18disable_netrw\2\16open_on_tab\1\18open_on_setup\1\nsetup\14nvim-tree\frequire\1\0\2\bkey\6R\vaction\frefresh\1\0\2\bkey\6r\vaction\vrename\1\0\2\bkey\6d\vaction\vremove\1\0\2\bkey\6s\vaction\nsplit\1\0\2\bkey\6v\vaction\vvsplit\1\0\2\bkey\6p\vaction\npaste\1\0\2\bkey\6c\vaction\tcopy\1\0\2\bkey\aza\vaction\15close_node\28nvim_tree_special_files\1\0\2\fdefault\bÓòí\fsymlink\bÔíÅ\20nvim_tree_icons\1\0\4\ffolders\3\1\bgit\3\0\18folder_arrows\3\0\nfiles\3\1\25nvim_tree_show_icons\6g\bvim\0" },
    loaded = true,
    path = "/home/rain/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/rain/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/rain/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/rain/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/rain/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n¶\4\0\0\t\0\26\0'6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\19\0005\3\v\0005\4\t\0005\5\5\0006\6\0\0'\b\3\0B\6\2\0029\6\4\6=\6\6\0056\6\0\0'\b\3\0B\6\2\0029\6\a\6=\6\b\5=\5\n\4=\4\f\0035\4\r\0=\4\14\0035\4\16\0005\5\15\0=\5\17\4=\4\18\3=\3\20\0025\3\22\0005\4\21\0=\4\23\3=\3\24\2B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\25\0'\2\23\0B\0\2\1K\0\1\0\19load_extension\15extensions\bfzf\1\0\0\1\0\4\14case_mode\15smart_case\25override_file_sorter\2\28override_generic_sorter\2\nfuzzy\2\rdefaults\1\0\0\18layout_config\15horizontal\1\0\0\1\0\4\19preview_cutoff\0032\vheight\4≥ÊÃô\3≥Êåˇ\3\nwidth\4Õô≥Ê\fÃô≥ˇ\3\20prompt_position\vbottom\25file_ignore_patterns\1\2\0\0\r^vendor/\rmappings\1\0\1\20layout_strategy\15horizontal\6i\1\0\0\n<C-s>\15file_split\n<C-v>\1\0\0\16file_vsplit\22telescope.actions\nsetup\14telescope\frequire\0" },
    loaded = true,
    path = "/home/rain/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "/home/rain/.local/share/nvim/site/pack/packer/start/vim-polyglot",
    url = "https://github.com/sheerun/vim-polyglot"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\nß\a\0\0\a\0'\00096\0\0\0009\0\1\0005\1\3\0=\1\2\0006\0\0\0009\0\1\0005\1\5\0=\1\4\0006\0\0\0009\0\1\0004\1\0\0=\1\6\0004\0\t\0005\1\a\0>\1\1\0005\1\b\0>\1\2\0005\1\t\0>\1\3\0005\1\n\0>\1\4\0005\1\v\0>\1\5\0005\1\f\0>\1\6\0005\1\r\0>\1\a\0005\1\14\0>\1\b\0006\1\15\0'\3\16\0B\1\2\0029\1\17\0015\3\18\0004\4\0\0=\4\19\0035\4\20\0005\5\21\0=\5\22\4=\4\23\0035\4\24\0=\4\25\0035\4\26\0005\5\27\0=\0\28\5=\5\29\4=\4\30\0035\4\31\0=\4 \0035\4$\0005\5\"\0005\6!\0=\6#\5=\5%\4=\4&\3B\1\2\1K\0\1\0\factions\14open_file\1\0\0\18window_picker\1\0\0\1\0\1\venable\2\ntrash\1\0\2\20require_confirm\2\bcmd\ntrash\tview\rmappings\tlist\1\0\1\16custom_only\1\1\0\b\tside\tleft\16auto_resize\1\vnumber\1\19relativenumber\1\21hide_root_folder\2\vheight\3\30\nwidth\3\30\15signcolumn\ano\bgit\1\0\1\venable\1\ffilters\vcustom\1\2\0\0\f_output\1\0\1\rdotfiles\2\23ignore_ft_on_setup\1\0\4\17hijack_netrw\2\18disable_netrw\2\16open_on_tab\1\18open_on_setup\1\nsetup\14nvim-tree\frequire\1\0\2\bkey\6R\vaction\frefresh\1\0\2\bkey\6r\vaction\vrename\1\0\2\bkey\6d\vaction\vremove\1\0\2\bkey\6s\vaction\nsplit\1\0\2\bkey\6v\vaction\vvsplit\1\0\2\bkey\6p\vaction\npaste\1\0\2\bkey\6c\vaction\tcopy\1\0\2\bkey\aza\vaction\15close_node\28nvim_tree_special_files\1\0\2\fdefault\bÓòí\fsymlink\bÔíÅ\20nvim_tree_icons\1\0\4\ffolders\3\1\bgit\3\0\18folder_arrows\3\0\nfiles\3\1\25nvim_tree_show_icons\6g\bvim\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: hop.nvim
time([[Config for hop.nvim]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\bhop\frequire\0", "config", "hop.nvim")
time([[Config for hop.nvim]], false)
-- Config for: lightline.vim
time([[Config for lightline.vim]], true)
try_loadstring('\27LJ\2\nå\4\0\0\5\0\20\0!6\0\0\0009\0\1\0005\1\3\0005\2\6\0004\3\3\0005\4\4\0>\4\1\0035\4\5\0>\4\2\3=\3\a\0024\3\3\0005\4\b\0>\4\1\0035\4\t\0>\4\2\3=\3\n\2=\2\v\0015\2\r\0004\3\3\0005\4\f\0>\4\1\3=\3\a\0024\3\3\0005\4\14\0>\4\1\3=\3\n\2=\2\15\0015\2\16\0=\2\17\0015\2\18\0=\2\19\1=\1\2\0K\0\1\0 component_visible_condition\1\0\2\15fileformat\21&ff&&&ff!="unix"\17fileencoding\26&fenc&&&fenc!="utf-8"\14component\1\0\3\15fileformat\26%{&ff=="unix"?"":&ff}\17fileencoding\31%{&fenc=="utf-8"?"":&fenc}\15myfilename\t%f%m\rinactive\1\2\0\0\fpercent\1\0\0\1\2\0\0\15myfilename\vactive\nright\1\4\0\0\15fileformat\17fileencoding\rfiletype\1\2\0\0\fpercent\tleft\1\0\0\1\3\0\0\rreadonly\15myfilename\1\3\0\0\tmode\npaste\1\0\1\16colorscheme\14MyGruvbox\14lightline\6g\bvim\0', "config", "lightline.vim")
time([[Config for lightline.vim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n¶\4\0\0\t\0\26\0'6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\19\0005\3\v\0005\4\t\0005\5\5\0006\6\0\0'\b\3\0B\6\2\0029\6\4\6=\6\6\0056\6\0\0'\b\3\0B\6\2\0029\6\a\6=\6\b\5=\5\n\4=\4\f\0035\4\r\0=\4\14\0035\4\16\0005\5\15\0=\5\17\4=\4\18\3=\3\20\0025\3\22\0005\4\21\0=\4\23\3=\3\24\2B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\25\0'\2\23\0B\0\2\1K\0\1\0\19load_extension\15extensions\bfzf\1\0\0\1\0\4\14case_mode\15smart_case\25override_file_sorter\2\28override_generic_sorter\2\nfuzzy\2\rdefaults\1\0\0\18layout_config\15horizontal\1\0\0\1\0\4\19preview_cutoff\0032\vheight\4≥ÊÃô\3≥Êåˇ\3\nwidth\4Õô≥Ê\fÃô≥ˇ\3\20prompt_position\vbottom\25file_ignore_patterns\1\2\0\0\r^vendor/\rmappings\1\0\1\20layout_strategy\15horizontal\6i\1\0\0\n<C-s>\15file_split\n<C-v>\1\0\0\16file_vsplit\22telescope.actions\nsetup\14telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
