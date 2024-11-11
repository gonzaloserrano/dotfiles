local set = vim.opt
set.expandtab = true
set.shiftwidth = 2
set.tabstop = 2
set.softtabstop = 2

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

-- Set up completion
local capabilities = vim.lsp.protocol.make_client_capabilities()

require('lspconfig')['buf_ls'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
  filetypes = {"proto"},
}
