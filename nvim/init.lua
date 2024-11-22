-- Settings

local g = vim.g
local cmd = vim.cmd
local fn = vim.fn
local set = vim.opt

--

g.mapleader = [[ ]]
g.maplocalleader = [[,]]

-- Opts
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.number = true
set.clipboard = "unnamedplus"
set.spelllang = "en"

-- backups
set.backup = true
set.shada = "!,h,'1000,<1000,s128,/1000,:1000,@1000"
local datadir = fn.stdpath('data')
vim.o.backupdir = datadir .. '/backup'
vim.o.directory = datadir .. '/tmp'
vim.o.undodir   = datadir .. '/undo'

-- General mappings

local map = vim.api.nvim_set_keymap
local silent = { silent = true, noremap = true }

---- buffers
vim.opt.termguicolors = true
map('n', '<c-j>', ':BufferLineCyclePrev<cr>', silent)
map('n', '<c-k>', ':BufferLineCycleNext<cr>', silent)
map('n', '<c-x>', ':bdelete!<cr>', silent)
---- git
map('n', '<c-h>', ':DiffviewFileHistory %<cr>', silent)
map('n', '<c-d>', ':DiffviewOpen<cr>', silent)
----
-- map('n', 'v', '<c-v>', silent)

-- telescope
map('n', '<c-f>', ':Telescope oldfiles<cr>', silent)
map('n', '<c-s>', ':Telescope lsp_document_symbols symbols=function,method,struct<cr>', silent)
map('n', '<c-n>', ':Telescope diagnostics<cr>', silent)
map('n', '<c-p>', ':Telescope git_files<cr>', silent)
-- map('n', '<c-g>', ':Telescope live_grep<cr>', silent)
map('n', '<c-g>', ':lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>', silent)
map('n', '<c-m>', ':Telescope resume<cr>', silent)
map('n', '<c-b>', ':Telescope buffers<cr>', silent)
map('n', '<c-i>', ':Telescope jumplist<cr>', silent)
map('n', '<c-y>', ':Telescope adjacent<cr>', silent)

---- interestingwords
map('n', '<space>', ':Interestingwords --toggle<cr>', silent)
map('n', '<bs>', ':nohl | Interestingwords --remove_all<cr>', silent)
vim.g.interestingwords_colors = {
  '#F4A261', '#8CCBEA', '#A4E57E', '#FF7272', '#FFB3FF', '#9999FF', '#FFDB72', '#2A9D8F', '#3366ff',
}

map('n', ',e', ':NvimTreeFindFileToggle!<cr>', silent)

-- lsp maps
map('n', '<c-e>', ':lua vim.lsp.buf.rename()<cr>', silent)
map('n', 'gd', ':lua vim.lsp.buf.definition()<cr>', silent)
map('n', 'gt', ':lua vim.lsp.buf.type_definition()<cr>', silent)
map('n', 'gi', ':lua vim.lsp.buf.implementation()<cr>', silent)
-- map('n', 'K', ':lua vim.lsp.buf.hover()<cr>', silent) -- default in nvim 0.10.0
map('n', 'gr', ':lua vim.lsp.buf.references()<cr>', silent)
map('n', 'gn', ':lua vim.diagnostic.goto_next()<cr>', silent)
map('n', 'gb', ':lua vim.diagnostic.goto_prev()<cr>', silent)
map('n', 'ga', ':lua vim.lsp.buf.code_action()<cr>', silent)

-- copilot
-- vim.g.copilot_no_tab_map = true
-- vim.g.copilot_assume_mapped = true
-- map('i', '<c-j>', 'copilot#Accept("")', {expr=true, silent=true})
-- map('i', '<c-k>', 'copilot#Next()', {expr=true, silent=true})
-- map('i', '<c-l>', 'copilot#Dismiss()', {expr=true, silent=true})

-- chatgpt
-- map('v', '<leader>aa', ':ChatGPTEditWithInstructions<cr>', silent)
-- map('v', 'gc', ':ChatGPTEditWithInstructions<cr>', silent)

-- Jump to last position
local group = vim.api.nvim_create_augroup("jump_last_position", { clear = true })
vim.api.nvim_create_autocmd(
	"BufReadPost",
	{callback = function()
			local row, col = unpack(vim.api.nvim_buf_get_mark(0, "\""))
			if {row, col} ~= {0, 0} and row <= vim.api.nvim_buf_line_count(0) then
				vim.api.nvim_win_set_cursor(0, {row, 0})
			end
		end,
	group = group
	}
)

---- cd to root
local function get_git_root()
    local dot_git_path = vim.fn.finddir(".git", ".;")
    return vim.fn.fnamemodify(dot_git_path, ":h")
end

vim.api.nvim_create_user_command("CdGitRoot", function()
    vim.api.nvim_set_current_dir(get_git_root())
end, {})

-- Make :bd and :q behave as usual when tree is visible
vim.api.nvim_create_autocmd({'BufEnter', 'QuitPre'}, {
  nested = false,
  callback = function(e)
    local tree = require('nvim-tree.api').tree

    -- Nothing to do if tree is not opened
    if not tree.is_visible() then
      return
    end

    -- How many focusable windows do we have? (excluding e.g. incline status window)
    local winCount = 0
    for _,winId in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_config(winId).focusable then
        winCount = winCount + 1
      end
    end

    -- We want to quit and only one window besides tree is left
    if e.event == 'QuitPre' and winCount == 2 then
      vim.api.nvim_cmd({cmd = 'qall'}, {})
    end

    -- :bd was probably issued an only tree window is left
    -- Behave as if tree was closed (see `:h :bd`)
    if e.event == 'BufEnter' and winCount == 1 then
      -- Required to avoid "Vim:E444: Cannot close last window"
      vim.defer_fn(function()
        -- close nvim-tree: will go to the last buffer used before closing
        tree.toggle({find_file = true, focus = true})
        -- re-open nivm-tree
        tree.toggle({find_file = true, focus = false})
      end, 10)
    end
  end
})

-- iswap
map('n', ',s', ':ISwap<cr>', silent)
map('n', ',,', ':ISwapWithRight<cr>', silent)
map('n', ',.', ':ISwapWithLeft<cr>', silent)

-- some plugins require config to be set beforehand

require('plugins')
require('gitsigns').setup({})
