-- bqf better quick fix
local map = vim.api.nvim_set_keymap
local silent = { silent = true, noremap = true }
map('n', '<c-c>', ':cclose<cr>', silent)
