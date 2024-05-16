-- ray-x/go.nvim

---- from https://github.com/ray-x/go.nvim#sample-vimrc
require 'go'.setup({
  goimports = 'gopls', -- if set to 'gopls' will use golsp format
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
        analyses = { 
			-- assign = true,
			-- atomic = true,
			-- atomicalign = true,
			-- bools = true,
			-- buildtag = true,
			-- cgocall = true,
			-- composites = true,
			-- copylocks = true,
			-- deepequalerrors = true,
			-- directive = true,
			-- embed = true,
			-- errorsas = true,
			-- fieldalignment = true,
			-- httpresponse = true,
			-- ifaceassert = true,
			-- loopclosure = true,
			-- lostcancel = true,
			-- nilfunc = true,
			-- nilness = true,
			-- printf = true,
			-- shadow = true,
			-- shift = true,
			-- simplifycompositelit = true,
			-- simplifyrange = true,
			-- simplifyslice = true,
			-- sortslice = true,
			-- stdmethods = true,
			-- stringintconv = true,
			-- structtag = true,
			-- testinggoroutine = true,
			-- tests = true,
			-- timeformat = true,
			-- unmarshal = true,
			-- unreachable = true,
			-- unsafeptr = true,
			-- unusedparams = true,
			-- unusedresult = true,
			-- unusedwrite = true,
			-- useany = true,
			-- fillreturns = true,
			-- nonewvars = true,
			-- noresultvalues = true,
			-- undeclaredname = true,
			-- unusedvariable = true,
			-- fillstruct = true,
			-- infertypeargs = true,
			-- stubmethods = true
		},
		directoryFilters = {'-/cloud', '-vendor', '-manifests', '-testdata', '-**/test-workdir', '-**/node_modules', '-**/.kube' },
		-- use ['local'] insted of "local = " because it's a keyword
        ['local'] = 'github.com/tetrateio/tetrate',
		gofumpt = true,
      },
    },
  },
  -- lsp_diag_hdlr = false,
  lsp_codelens = false,
  lsp_inlay_hints = {
	  enable = false,
	  -- only_current_line = true,
  },
})

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

-- Set up completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

require('lspconfig')['gopls'].setup{
	on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
	-- settings are set by go.nvim at go.lua
}

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

-- map('n', '<c-y>', ':GoCoverage<cr>', silent)
map('n', '<c-a>', ':GoAlt!<cr>', silent)
map('n', '<c-e>', ':GoIfErr<cr>', silent)
map('n', '<c-l>', ':BufferLineCycleNext<cr>', silent)

-- abbreviations

local cmd = vim.cmd
cmd('iab reqq require.NoError(t, err)')
cmd('iab ree require.Equal(t,')
cmd('iab rene require.NotEmpty(t,')
cmd('iab ret require.True(t,')
cmd('iab rel require.Len(t,')
cmd('iab testt func TestX(t *testing.T) {<CR>')
