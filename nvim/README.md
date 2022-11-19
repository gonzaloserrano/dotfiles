# Nvim from scratch for Go

## v0

- `brew install neovim`
- alias `nvim` to `vi` in my zsh config file
- read about `:h base-directories` and `:h runtimepath`
- [cloned packer](https://github.com/wbthomason/packer.nvim#quickstart) in ` ~/.local/share/nvim/site/pack/...` (base data directory)
- created `init.lua` in `.config/nvim/` (base config directory) with the following contents:
```lua
require('plugins')
```
- created `plugins.lua` inside `.config/nvim/lua` with:
```lua
return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
end)
```
- run `vi` and run `:PackerSync`. This created `.config/nvim/plugin/packer_compiled.lua`
