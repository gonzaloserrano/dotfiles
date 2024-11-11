-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

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
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/gonzalo/.cache/nvim/packer_hererocks/2.1.1727870382/share/lua/5.1/?.lua;/Users/gonzalo/.cache/nvim/packer_hererocks/2.1.1727870382/share/lua/5.1/?/init.lua;/Users/gonzalo/.cache/nvim/packer_hererocks/2.1.1727870382/lib/luarocks/rocks-5.1/?.lua;/Users/gonzalo/.cache/nvim/packer_hererocks/2.1.1727870382/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/gonzalo/.cache/nvim/packer_hererocks/2.1.1727870382/lib/lua/5.1/?.so"
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
  ["Onedarker.nvim"] = {
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/Onedarker.nvim",
    url = "https://github.com/lunarvim/Onedarker.nvim"
  },
  ["adjacent.nvim"] = {
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/adjacent.nvim",
    url = "https://github.com/MaximilianLloyd/adjacent.nvim"
  },
  ["bufferline.nvim"] = {
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://github.com/Theyashsawarkar/bufferline.nvim"
  },
  ["fidget.nvim"] = {
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["go.nvim"] = {
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/go.nvim",
    url = "https://github.com/ray-x/go.nvim"
  },
  ["gp.nvim"] = {
    config = { "\27LJ\2\nó\4\0\2\18\0\22\1i6\2\0\0009\2\1\0029\2\2\2+\4\1\0+\5\2\0B\2\3\0026\3\0\0009\3\3\3\18\5\0\0B\3\2\0029\4\4\0039\4\5\0049\5\4\3\18\b\4\0009\6\6\4)\t\1\0)\n\3\0B\6\4\0026\a\a\0009\a\b\a'\t\t\0\21\n\4\0\23\n\0\nB\a\3\2\18\n\4\0009\b\6\4)\výÿB\b\3\2&\6\b\6=\6\5\0056\5\n\0009\a\v\3B\5\2\4H\b\29€9\n\v\0038\n\b\n9\n\f\n\15\0\n\0X\v\24€6\v\r\0\18\r\n\0B\v\2\2\a\v\a\0X\v\19€9\v\v\0038\v\b\v\18\14\n\0009\f\6\n)\15\1\0)\16\3\0B\f\4\0026\r\a\0009\r\b\r'\15\t\0\21\16\n\0\23\16\0\16B\r\3\2\18\16\n\0009\14\6\n)\17ýÿB\14\3\2&\f\14\f=\f\f\vF\b\3\3R\bá\1276\5\a\0009\5\14\5'\a\15\0006\b\0\0009\b\16\b\18\n\3\0B\b\2\0A\5\1\0026\6\a\0009\6\14\6'\b\17\0006\t\0\0009\t\16\t\18\v\1\0B\t\2\0A\6\1\0026\a\0\0009\a\18\a\18\t\5\0'\n\19\0\18\v\6\0&\t\v\t'\n\19\0B\a\3\0026\b\0\0009\b\1\b9\b\20\b\18\n\2\0)\v\0\0)\fÿÿ+\r\1\0\18\14\a\0B\b\6\0016\b\0\0009\b\1\b9\b\21\b)\n\0\0\18\v\2\0B\b\3\1K\0\1\0\21nvim_win_set_buf\23nvim_buf_set_lines\6\n\nsplit\23Command params:\n%s\finspect\25Plugin structure:\n%s\vformat\ttype\vsecret\14providers\npairs\6*\brep\vstring\bsub\19openai_api_key\vconfig\rdeepcopy\20nvim_create_buf\bapi\bvim\f \3\0\2\f\0\r\0\22'\2\0\0'\3\1\0'\4\2\0'\5\3\0&\2\5\0029\3\4\0B\3\1\0029\4\5\0'\6\6\0009\a\a\3&\6\a\6B\4\2\0019\4\b\0\18\6\1\0009\a\t\0009\a\n\a+\b\0\0009\t\v\3\18\n\2\0009\v\f\3B\4\a\1K\0\1\0\18system_prompt\nmodel\frewrite\vTarget\vPrompt\tname(Implementing selection with agent: \tinfo\22get_command_agentT\n\nRespond exclusively with the snippet that should replace the selection above.APlease rewrite this according to the contained instructions.(```{{filetype}}\n{{selection}}\n```\n\n*Having following from {{filename}}:\n\nó\2\0\2\f\0\n\0\17'\2\0\0'\3\1\0'\4\2\0'\5\3\0&\2\5\0029\3\4\0B\3\1\0029\4\5\0\18\6\1\0009\a\6\0009\a\a\a+\b\0\0009\t\b\3\18\n\2\0009\v\t\3B\4\a\1K\0\1\0\18system_prompt\nmodel\tenew\vTarget\vPrompt\22get_command_agentWMake sure the code compiles properly! Don't respond with code if you are not sure.JPlease respond by writing table driven unit tests for the code above.(```{{filetype}}\n{{selection}}\n```\n\n6I have the following Go code from {{filename}}:\n\n¿\2\0\2\f\0\n\0\17'\2\0\0'\3\1\0'\4\2\0'\5\3\0&\2\5\0029\3\4\0B\3\1\0029\4\5\0\18\6\1\0009\a\6\0009\a\a\a+\b\0\0009\t\b\3\18\n\2\0009\v\t\3B\4\a\1K\0\1\0\18system_prompt\nmodel\tenew\vTarget\vPrompt\22get_command_agent1Don't respond with code if you are not sure.<Please respond by writing the godoc for the code above.(```{{filetype}}\n{{selection}}\n```\n\n6I have the following Go code from {{filename}}:\n\nË\1\1\0\4\0\14\0\0185\0\t\0005\1\1\0003\2\0\0=\2\2\0013\2\3\0=\2\4\0013\2\5\0=\2\6\0013\2\a\0=\2\b\1=\1\n\0006\1\v\0'\3\f\0B\1\2\0029\1\r\1\18\3\0\0B\1\2\1K\0\1\0\nsetup\agp\frequire\nhooks\1\0\1\nhooks\0\nGoDoc\0\14UnitTests\0\14Implement\0\18InspectPlugin\1\0\4\14UnitTests\0\nGoDoc\0\18InspectPlugin\0\14Implement\0\0\0" },
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/gp.nvim",
    url = "https://github.com/robitx/gp.nvim"
  },
  ["guihua.lua"] = {
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/guihua.lua",
    url = "https://github.com/ray-x/guihua.lua"
  },
  ["interestingwords.nvim"] = {
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/interestingwords.nvim",
    url = "https://github.com/leisiji/interestingwords.nvim"
  },
  ["iswap.nvim"] = {
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/iswap.nvim",
    url = "https://github.com/mizlan/iswap.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mini.completion"] = {
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/mini.completion",
    url = "https://github.com/echasnovski/mini.completion"
  },
  ["mini.fuzzy"] = {
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/mini.fuzzy",
    url = "https://github.com/echasnovski/mini.fuzzy"
  },
  ["mini.indentscope"] = {
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/mini.indentscope",
    url = "https://github.com/echasnovski/mini.indentscope"
  },
  ["mini.pairs"] = {
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/mini.pairs",
    url = "https://github.com/echasnovski/mini.pairs"
  },
  ["nvim-bqf"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/opt/nvim-bqf",
    url = "https://github.com/kevinhwang91/nvim-bqf"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/nvim-tree/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/nvim-treesitter-context",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-context"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-various-textobjs"] = {
    config = { "\27LJ\2\nX\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\22useDefaultKeymaps\2\nsetup\21various-textobjs\frequire\0" },
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/nvim-various-textobjs",
    url = "https://github.com/chrisgrieser/nvim-various-textobjs"
  },
  ["nvim-web-devicons"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/opt/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["onenord.nvim"] = {
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/onenord.nvim",
    url = "https://github.com/rmehri01/onenord.nvim"
  },
  ["openingh.nvim"] = {
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/openingh.nvim",
    url = "https://github.com/almo7aya/openingh.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["syntax-tree-surfer"] = {
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/syntax-tree-surfer",
    url = "https://github.com/ziontee113/syntax-tree-surfer"
  },
  ["telescope-github.nvim"] = {
    config = { "\27LJ\2\nG\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\agh\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/telescope-github.nvim",
    url = "https://github.com/nvim-telescope/telescope-github.nvim"
  },
  ["telescope-live-grep-args.nvim"] = {
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/telescope-live-grep-args.nvim",
    url = "https://github.com/nvim-telescope/telescope-live-grep-args.nvim"
  },
  ["telescope-sg"] = {
    config = { "\27LJ\2\nM\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\rast_grep\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/telescope-sg",
    url = "https://github.com/Marskey/telescope-sg"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\nS\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\19live_grep_args\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/gonzalo/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-various-textobjs
time([[Config for nvim-various-textobjs]], true)
try_loadstring("\27LJ\2\nX\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\22useDefaultKeymaps\2\nsetup\21various-textobjs\frequire\0", "config", "nvim-various-textobjs")
time([[Config for nvim-various-textobjs]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\nS\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\19live_grep_args\19load_extension\14telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: telescope-sg
time([[Config for telescope-sg]], true)
try_loadstring("\27LJ\2\nM\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\rast_grep\19load_extension\14telescope\frequire\0", "config", "telescope-sg")
time([[Config for telescope-sg]], false)
-- Config for: telescope-github.nvim
time([[Config for telescope-github.nvim]], true)
try_loadstring("\27LJ\2\nG\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\agh\19load_extension\14telescope\frequire\0", "config", "telescope-github.nvim")
time([[Config for telescope-github.nvim]], false)
-- Config for: gp.nvim
time([[Config for gp.nvim]], true)
try_loadstring("\27LJ\2\nó\4\0\2\18\0\22\1i6\2\0\0009\2\1\0029\2\2\2+\4\1\0+\5\2\0B\2\3\0026\3\0\0009\3\3\3\18\5\0\0B\3\2\0029\4\4\0039\4\5\0049\5\4\3\18\b\4\0009\6\6\4)\t\1\0)\n\3\0B\6\4\0026\a\a\0009\a\b\a'\t\t\0\21\n\4\0\23\n\0\nB\a\3\2\18\n\4\0009\b\6\4)\výÿB\b\3\2&\6\b\6=\6\5\0056\5\n\0009\a\v\3B\5\2\4H\b\29€9\n\v\0038\n\b\n9\n\f\n\15\0\n\0X\v\24€6\v\r\0\18\r\n\0B\v\2\2\a\v\a\0X\v\19€9\v\v\0038\v\b\v\18\14\n\0009\f\6\n)\15\1\0)\16\3\0B\f\4\0026\r\a\0009\r\b\r'\15\t\0\21\16\n\0\23\16\0\16B\r\3\2\18\16\n\0009\14\6\n)\17ýÿB\14\3\2&\f\14\f=\f\f\vF\b\3\3R\bá\1276\5\a\0009\5\14\5'\a\15\0006\b\0\0009\b\16\b\18\n\3\0B\b\2\0A\5\1\0026\6\a\0009\6\14\6'\b\17\0006\t\0\0009\t\16\t\18\v\1\0B\t\2\0A\6\1\0026\a\0\0009\a\18\a\18\t\5\0'\n\19\0\18\v\6\0&\t\v\t'\n\19\0B\a\3\0026\b\0\0009\b\1\b9\b\20\b\18\n\2\0)\v\0\0)\fÿÿ+\r\1\0\18\14\a\0B\b\6\0016\b\0\0009\b\1\b9\b\21\b)\n\0\0\18\v\2\0B\b\3\1K\0\1\0\21nvim_win_set_buf\23nvim_buf_set_lines\6\n\nsplit\23Command params:\n%s\finspect\25Plugin structure:\n%s\vformat\ttype\vsecret\14providers\npairs\6*\brep\vstring\bsub\19openai_api_key\vconfig\rdeepcopy\20nvim_create_buf\bapi\bvim\f \3\0\2\f\0\r\0\22'\2\0\0'\3\1\0'\4\2\0'\5\3\0&\2\5\0029\3\4\0B\3\1\0029\4\5\0'\6\6\0009\a\a\3&\6\a\6B\4\2\0019\4\b\0\18\6\1\0009\a\t\0009\a\n\a+\b\0\0009\t\v\3\18\n\2\0009\v\f\3B\4\a\1K\0\1\0\18system_prompt\nmodel\frewrite\vTarget\vPrompt\tname(Implementing selection with agent: \tinfo\22get_command_agentT\n\nRespond exclusively with the snippet that should replace the selection above.APlease rewrite this according to the contained instructions.(```{{filetype}}\n{{selection}}\n```\n\n*Having following from {{filename}}:\n\nó\2\0\2\f\0\n\0\17'\2\0\0'\3\1\0'\4\2\0'\5\3\0&\2\5\0029\3\4\0B\3\1\0029\4\5\0\18\6\1\0009\a\6\0009\a\a\a+\b\0\0009\t\b\3\18\n\2\0009\v\t\3B\4\a\1K\0\1\0\18system_prompt\nmodel\tenew\vTarget\vPrompt\22get_command_agentWMake sure the code compiles properly! Don't respond with code if you are not sure.JPlease respond by writing table driven unit tests for the code above.(```{{filetype}}\n{{selection}}\n```\n\n6I have the following Go code from {{filename}}:\n\n¿\2\0\2\f\0\n\0\17'\2\0\0'\3\1\0'\4\2\0'\5\3\0&\2\5\0029\3\4\0B\3\1\0029\4\5\0\18\6\1\0009\a\6\0009\a\a\a+\b\0\0009\t\b\3\18\n\2\0009\v\t\3B\4\a\1K\0\1\0\18system_prompt\nmodel\tenew\vTarget\vPrompt\22get_command_agent1Don't respond with code if you are not sure.<Please respond by writing the godoc for the code above.(```{{filetype}}\n{{selection}}\n```\n\n6I have the following Go code from {{filename}}:\n\nË\1\1\0\4\0\14\0\0185\0\t\0005\1\1\0003\2\0\0=\2\2\0013\2\3\0=\2\4\0013\2\5\0=\2\6\0013\2\a\0=\2\b\1=\1\n\0006\1\v\0'\3\f\0B\1\2\0029\1\r\1\18\3\0\0B\1\2\1K\0\1\0\nsetup\agp\frequire\nhooks\1\0\1\nhooks\0\nGoDoc\0\14UnitTests\0\14Implement\0\18InspectPlugin\1\0\4\14UnitTests\0\nGoDoc\0\18InspectPlugin\0\14Implement\0\0\0", "config", "gp.nvim")
time([[Config for gp.nvim]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType qf ++once lua require("packer.load")({'nvim-bqf'}, { ft = "qf" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
