-- ray-x/go.nvim

---- from https://github.com/ray-x/go.nvim#sample-vimrc
require 'go'.setup({
  lsp_keymaps = false, -- disable c-k
  goimports = 'gopls', -- if set to 'gopls' will use golsp format
  gofmt = 'gopls', -- if set to gopls will use golsp format
  tag_transform = false,
  test_dir = '',
  comment_placeholder = '   ',
  lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
  lsp_on_attach = true, -- use on_attach from go.nvim
  dap_debug = true,
  -- lsp_cfg = true, -- false: use your own lspconfig
  lsp_cfg = {
    capabilities = {
      textDocument = {
        completion = {
          completionItem = {
            snippetSupport = false,
          },
        },
      },
    },
    settings = {
      gopls = {
        directoryFilters = {
          '-/cloud', '-vendor', '-manifests', '-testdata', '-/test-workdir', '-**/node_modules', '-**/.kube',
          '-aws-controller', '-genistio', '-gitops', '-helm', '-infrastructure', '-iam', '-onboarding', '-registry', '-release', '-tctl', '-teamsync', '-tsboperator', '-wasmfetcher', '-tetrate',
        },
        -- see https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
        analyses = {
          shadow = true,
        }
      }
    }
  },
  lsp_inlay_hints = {
    enable = false, -- this is the only field apply to neovim > 0.10
  },
})

local protocol = require'vim.lsp.protocol'

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimports()
  end,
  group = format_sync_grp,
})

-- maps

local map = vim.api.nvim_set_keymap
local silent = { silent = true, noremap = true }

map('n', '<c-a>', ':GoAlt!<cr>', silent)
-- had this in case copilot used <c-k> for next result?
-- map('n', '<c-l>', ':BufferLineCycleNext<cr>', silent)

-- abbreviations

local cmd = vim.cmd
cmd('iab reqq require.NoError(t, err)')
cmd('iab ree require.Equal(t,')
cmd('iab rene require.NotEmpty(t,')
cmd('iab ret require.True(t,')
cmd('iab rel require.Len(t,')
cmd('iab testt func TestX(t *testing.T) {<CR>')
cmd('iab jsonm d, _ := json.MarshalIndent(x, "", "  ")<CR>println(string(d))')
