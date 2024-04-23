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

## v2

- add [go.nvim](https://github.com/ray-x/go.nvim) with packers in `plugins.lua`, and configured it in `init.lua` with:
```lua
-- Go

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})

require('go').setup()
```
- opened a go file, unindented some code, pressed `:w` and nothing happened when I expected that goimports would format it according to the code above. Buuuuuuh!
- ran `:healthcheck` and found these warnings:
```
## Go Plugin Check
  - WARNING: lspconfig: not installed/loaded
  - WARNING: nvim-treesitter: not installed/loaded
  - WARNING: guihua: not installed/loaded
  - WARNING: nvim-dap-virtual-text: not installed/loaded
  - WARNING: telescope: not installed/loaded
  - WARNING: nvim-dap-ui: not installed/loaded
  - WARNING: nvim-dap: not installed/loaded
  - WARNING: Not all plugin installed
  - OK: GOPATH is set
  - INFO: GOROOT is not set
  - OK: GOBIN is set
  - INFO: Not all enviroment variables set
```

- To fix it, installed https://github.com/neovim/nvim-lspconfig. Then opened the go file again, and run `:LspInfo`:
```
    Language client log: /Users/gonzalo/.local/state/nvim/lsp.log
    Detected filetype:   go

    0 client(s) attached to this buffer:

    Configured servers list:
```
YUNO CLIENTS ATTACHED!!!! (╯°□°)╯︵ ┻━┻
- Read in [reddit](https://www.reddit.com/r/neovim/comments/oapq4p/cant_get_gopls_to_work/) to run `:lua require'lspconfig'.gopls.setup{}`. It still did not work, but the output was different:
```
    Language client log: /Users/gonzalo/.local/state/nvim/lsp.log
    Detected filetype:   go

    0 client(s) attached to this buffer:

    Other clients that match the filetype: go

    Config: gopls
     filetypes:         go, gomod, gowork, gotmpl
     root directory:    /Users/gonzalo/go/src/github.com/gonzaloserrano/foo
     cmd:               gopls
     cmd is executable: true
     autostart:         true
     custom handlers:

    Configured servers list: gopls
```
- Back to nvim-lspconfig readme again, where I skipped the require section :facepalm:. Added this to `init.lua`:
```lua
require('lspconfig')['gopls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
```
`:LspInfo` now shows `gopls` is attached. Saving the file formats it correctly.
- Let's try jump to definition. I added this to `init.lua`:
```lua
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
``` 
For some reson pressing `gd` in normal mode did not work. Then I tried running `:lua vim.lsp.buf.definition()` and that worked!

I found that `on_attach` needed to be defined before the `require('lspconfig')['gopls'].setup` line,
otherwise on_attach was not correctly passed to lspconfig.

## v3

Moar plugins:
- popup/panes for everything with [telescope](https://github.com/nvim-telescope/telescope.nvim). It seemed to work great out of the box. Added some mappings that I have with my lunarvim install:
```lua
map('n', '<c-f>', ':Telescope oldfiles<cr>', silent)
map('n', '<c-s>', ':Telescope lsp_document_symbols symbols=function,method,struct<cr>', silent)
map('n', '<c-n>', ':Telescope diagnostics<cr>', silent)
map('n', '<c-p>', ':Telescope git_files<cr>', silent)
map('n', '<c-g>', ':Telescope live_grep<cr>', silent)
map('n', '<c-b>', ':Telescope buffers<cr>', silent)
```
- better syntax highlight with [treesitter](https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation). Run `:TSInstall go` in a go file (found out via `:checkhealth`). See [instructions](https://github.com/nvim-treesitter/nvim-treesitter#language-parsers). Requires this init:
```lua
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua", "go" },
  sync_install = true,
  auto_install = true,
  highlight = {
    enable = true,
  },
}
```
For some reason lua files errored, so I run `TSInstall lua` and forced a reinstall and now worked :thinkinface:. Go files looked great, with improved syntax highlight.

## v4

Moar plugins to make pretty [buffers at top](https://github.com/akinsho/bufferline.nvim), [status bar](https://github.com/nvim-lualine/lualine.nvim) and [git changes](https://github.com/lewis6991/gitsigns.nvim). They have their own setup.

## v5

- fix buffer close map
- add maps for git diff and git log (I use [delta](https://github.com/dandavison/delta) for diffing)
- add maps for go.nvim: since I wanted maps just for go files, I've created `ftplugin/go.lua` and moved all the go stuff there, along with new maps.

## v6

Add [interestingwords](https://github.com/leisiji/interestingwords.nvim), [nvimtree](https://github.com/nvim-tree/nvim-tree.lua), [swap args](https://github.com/mizlan/iswap.nvim), [code completion](hrsh7th/nvim-cmp)

## v7

And [GitHub copilot](https://github.com/github/copilot.vim) plugin.

## Next versions

Trying plugins, fixing LSP/gopls stuff, etc etc. No more reporting of this since standard vim 101.
