# Nvim from scratch for Go

## Why

I'm doing this because my [lunarvim](https://www.lunarvim.org/) install, a
neovim distribution, [broke](https://github.com/ray-x/go.nvim/issues/239) for
the "Goto definition" feature of this Go plugin
[https://github.com/ray-x/go.nvim](ray-x/go.nvim). 

I could not fix it, because I have no idea how nvim works, and Lunarvim has
dozens of plugins. So I will try to have a minimal nvim install that makes me
happy for programming Go and I will document how I did it.

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

## v1

- copy basic stuff from [packer's guy config](https://github.com/wbthomason/dotfiles/blob/linux/neovim/.config/nvim/init.lua), ie a more convinient way to set the [leader key](https://stackoverflow.com/questions/1764263/what-is-the-leader-in-a-vimrc-file) for custom mappings
- add tab navigation maps
- add [onedarker](https://github.com/LunarVim/onedarker.nvim) colorscheme, adding `use "lunarvim/Onedarker.nvim"` to `plugins.lua`, then running `:PackerSync`, then adding `vim.cmd("colorscheme onedarker")` to `init.lua`. Packer added the plugin source to `.local/share/nvim/site/pack/packer/start/Onedarker.nvim`.
