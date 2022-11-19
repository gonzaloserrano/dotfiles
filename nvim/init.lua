require('plugins')

-- Settings

local g = vim.g
local cmd = vim.cmd
g.mapleader = [[ ]]
g.maplocalleader = [[,]]

-- Maps

local map = vim.api.nvim_set_keymap
local silent = { silent = true, noremap = true }
map('n', '<c-j>', '<cmd>tabpre<cr>', silent)
map('n', '<c-k>', '<cmd>tabnext<cr>', silent)

-- Colors

---- lunarvim/Onedarker.nvim
cmd("colorscheme onedarker")

-- Go

---- neovim/nvim-lspconfig
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
end

require('lspconfig')['gopls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

---- ray-x/go.nvim
require('go').setup()
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})

