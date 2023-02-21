-- ray-x/go.nvim

---- from https://github.com/ray-x/go.nvim#sample-vimrc
require 'go'.setup({
  goimport = 'gopls', -- if set to 'gopls' will use golsp format
  gofmt = 'gopls', -- if set to gopls will use golsp format
  -- max_line_len = 120,
  -- tag_transform = false,
  -- test_dir = '',
  comment_placeholder = ' is a ',
  lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
  lsp_on_attach = true, -- use on_attach from go.nvim
  -- dap_debug = true,
  -- extra lspconfig
  lsp_cfg = {
    -- capabilities = capabilities,
    settings = {
      -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
      gopls = {
        -- matcher = 'CaseInsensitive',
        -- analyses = { unusedparams = false },
		directoryFilters = { 'vendor', 'manifests', 'testdata', 'test-workdir', '-**/node_modules' },
        ['local'] = 'github.com/tetrateio/tetrate',
      },
    },
  },
})

local protocol = require'vim.lsp.protocol'

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})

-- maps

local map = vim.api.nvim_set_keymap
local silent = { silent = true, noremap = true }

map('n', '<c-y>', ':GoCoverage<cr>', silent)
map('n', '<c-a>', ':GoAlt!<cr>', silent)
map('n', '<c-e>', ':GoIfErr<cr>', silent)

-- abbreviations

local cmd = vim.cmd
cmd('iab reqq require.NoError(t, err)')
cmd('iab ree require.Equal(t,')
cmd('iab rene require.NotEmpty(t,')
cmd('iab ret require.True(t,')
cmd('iab rel require.Len(t,')
cmd('iab testt func TestX(t *testing.T) {<CR>')
