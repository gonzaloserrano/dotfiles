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
cmd("colorscheme onedarker")
