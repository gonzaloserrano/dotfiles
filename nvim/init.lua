require('plugins')

-- Settings

local g = vim.g
local cmd = vim.cmd
g.mapleader = [[ ]]
g.maplocalleader = [[,]]

-- Maps

local map = vim.api.nvim_set_keymap
local silent = { silent = true, noremap = true }
map('n', '<c-j>', ':BufferLineCyclePrev<cr>', silent)
map('n', '<c-k>', ':BufferLineCycleNext<cr>', silent)
map('n', '<c-x>', ':BufferClose!<cr>', silent)

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

map('n', '<c-v>', ':lua vim.lsp.buf.rename()<cr>', silent)

---- ray-x/go.nvim
require('go').setup()
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})

---- treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua", "go" },
  sync_install = true,
  auto_install = true,
  highlight = {
    enable = true,
  },
}

map('n', '<c-f>', ':Telescope oldfiles<cr>', silent)
map('n', '<c-s>', ':Telescope lsp_document_symbols symbols=function,method,struct<cr>', silent)
map('n', '<c-n>', ':Telescope diagnostics<cr>', silent)
map('n', '<c-p>', ':Telescope git_files<cr>', silent)
map('n', '<c-g>', ':Telescope live_grep<cr>', silent)
map('n', '<c-b>', ':Telescope buffers<cr>', silent)

---- lualine
require('lualine').setup()

---- bufferline
vim.opt.termguicolors = true
require('bufferline').setup {
  -- If true, new buffers will be inserted at the start/end of the list.
  -- Default is to insert after current buffer.
  insert_at_end = true,
}

---- gitsigns
require('gitsigns').setup()

