-- Settings

local g = vim.g
local cmd = vim.cmd
g.mapleader = [[ ]]
g.maplocalleader = [[,]]

-- Opts
local set = vim.opt
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.number = true
set.clipboard = "unnamedplus"

-- General mappings

local map = vim.api.nvim_set_keymap
local silent = { silent = true, noremap = true }

---- buffers
map('n', '<c-j>', ':BufferLineCyclePrev<cr>', silent)
map('n', '<c-k>', ':BufferLineCycleNext<cr>', silent)
map('n', '<c-x>', ':bdelete<cr>', silent)
---- git
map('n', '<c-h>', ':term DELTA_PAGER="" git log -p %<cr>', silent)
map('n', '<c-d>', ':term DELTA_PAGER="" git diff %<cr>', silent)
----
map('n', 'v', '<c-v>', silent)

-- Colors

---- lunarvim/Onedarker.nvim
cmd("colorscheme onedarker")

-- Go
---- moved to ftplugin/go.lua

---- treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua", "go", "yaml" },
  sync_install = true,
  auto_install = true,
  highlight = {
    enable = true,
  },
}

---- lualine
require('lualine').setup()

---- bufferline
vim.opt.termguicolors = true
require('bufferline').setup {
  -- If true, new buffers will be inserted at the start/end of the list.
  -- Default is to insert after current buffer.
  options = { sort_by = 'insert_at_end' }
}

---- gitsigns
require('gitsigns').setup()

---- interestingwords
map('n', '<space>', ':Interestingwords --toggle<cr>', silent)
map('n', '<bs>', ':nohl | Interestingwords --remove_all<cr>', silent)
vim.g.interestingwords_colors = {
  '#F4A261', '#8CCBEA', '#A4E57E', '#FF7272', '#FFB3FF', '#9999FF', '#FFDB72', '#2A9D8F', '#3366ff',
}

---- nvim-tree.lua + icons
require('nvim-tree').setup({
  sort_by = 'case_sensitive',
  respect_buf_cwd = true,
  sync_root_with_cwd = true,
  reload_on_bufenter = true,
  actions = {
    change_dir = { 
      enable = true,
    },
  },
  view = {
    adaptive_size = true,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

-- require('nvim-web-devicons').setup()

map('n', ',e', ':NvimTreeFindFileToggle!<cr>', silent)

---- iswap
require('iswap').setup{
  -- Move cursor to the other element in ISwap*With commands
  move_cursor = true,
}
map('n', ',s', ':ISwap<cr>', silent)
map('n', ',,', ':ISwapWithRight<cr>', silent)
map('n', ',.', ':ISwapWithLeft<cr>', silent)

---- neovim/nvim-lspconfig
-- lsp maps
map('n', '<c-v>', ':lua vim.lsp.buf.rename()<cr>', silent)
map('n', 'gd', ':lua vim.lsp.buf.definition()<cr>', silent)
map('n', 'gt', ':lua vim.lsp.buf.type_definition()<cr>', silent)
map('n', 'gi', ':lua vim.lsp.buf.implementation()<cr>', silent)
map('n', 'K', ':lua vim.lsp.buf.hover()<cr>', silent)
map('n', 'gr', ':lua vim.lsp.buf.references()<cr>', silent)
map('n', 'gn', ':lua vim.diagnostic.goto_next()<cr>', silent)
map('n', 'gb', ':lua vim.diagnostic.goto_prev()<cr>', silent)
map('n', 'ga', ':lua vim.lsp.buf.code_action()<cr>', silent)

-- copilot
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
map('i', '<c-j>', 'copilot#Accept("")', {expr=true, silent=true})
map('i', '<c-k>', 'copilot#Next()', {expr=true, silent=true})
map('i', '<c-l>', 'copilot#Dismiss()', {expr=true, silent=true})

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
---- telescope

require('telescope').load_extension('adjacent')

map('n', '<c-f>', ':Telescope oldfiles<cr>', silent)
map('n', '<c-s>', ':Telescope lsp_document_symbols symbols=function,method,struct<cr>', silent)
map('n', '<c-n>', ':Telescope diagnostics<cr>', silent)
map('n', '<c-p>', ':Telescope git_files<cr>', silent)
map('n', '<c-g>', ':Telescope live_grep<cr>', silent)
map('n', '<c-b>', ':Telescope buffers<cr>', silent)
map('n', '<c-i>', ':Telescope jumplist<cr>', silent)
map('n', '<c-y>', ':Telescope adjacent<cr>', silent)

vim.keymap.set("n", ";", "<cmd>lua require('telescope.builtin').resume(require('telescope.themes').get_ivy({}))<cr>", opts)

require('telescope').setup {
    extensions = {
        ast_grep = {
            command = {
                'sg',
                '--json=stream',
            }, -- must have --json=stream
            grep_open_files = false, -- search in opened files
            lang = 'go', -- string value, specify language for ast-grep `nil` for default
        }
    }
}

---- cd to root

local function get_git_root()
    local dot_git_path = vim.fn.finddir(".git", ".;")
    return vim.fn.fnamemodify(dot_git_path, ":h")
end

vim.api.nvim_create_user_command("CdGitRoot", function()
    vim.api.nvim_set_current_dir(get_git_root())
end, {})

--  mini
require('mini.completion').setup()
require('mini.pairs').setup()
-- require('mini.trailspace').setup()

require('mini.indentscope').setup()
vim.cmd([[
    au FileType * if index(['yaml', 'gohtmltmpl'], &ft) < 0 | let b:miniindentscope_disable=v:true | endif
]])

-- some plugins require config to be set beforehand

require('plugins')
