-- ray-x/go.nvim

---- from https://github.com/ray-x/go.nvim#sample-vimrc

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
