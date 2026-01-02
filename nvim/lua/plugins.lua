-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local map = vim.api.nvim_set_keymap
local plugins = {
  {
    'rmehri01/onenord.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      local colors = require("onenord.colors").load()

      require("onenord").setup({
          custom_highlights = {
              ["@module"] = { fg = colors.light_green },
              ["@function"] = { fg = colors.light_red },
              ["@function.method.go"] = { fg = colors.red },
              ["@function.method.call"] = { fg = colors.light_red },
              ["@function.builtin"] = { fg = colors.yellow },
              ["@constructor.go"] = { fg = colors.light_red },
              ["@variable.parameter.go"] = { fg = colors.white },
              -- ["@variable.member"] = { fg = colors.light_blue },
              ["@type"] = { fg = colors.blue },
              ["@type.go"] = { fg = colors.light_green },
              ["@type.builtin"] = { fg = colors.light_green },
              ["@property.go"] = { fg = colors.purple },
              ["@keyword"] = { fg = colors.yellow },
              ["@keyword.repeat"] = { fg = colors.yellow },
              ["@keyword.conditional"] = { fg = colors.yellow },
              ["@keyword.function.go"] = { fg = colors.yellow },
              ["@keyword.return.go"] = { fg = colors.yellow },
              ["@operator.go"] = { fg = colors.blue },
              ["@comment.todo.comment"] = { fg = colors.pink },
              ["@lsp.type.parameter.go"] = { fg = colors.white },
              ["@lsp.typemod.variable.readonly.go"] =  { fg = colors.purple },
          },
          custom_colors = {
              dark_blue = "#aeaeae",
              blue = "#c7aa8d",
              yellow = "#d5b271",
              orange = "#d48f61",
          },
      })
      vim.cmd([[colorscheme onenord]])
    end,
  },
  -- {'lunarvim/Onedarker.nvim'},
  {
      'neovim/nvim-lspconfig',
  },
  {
    'ray-x/go.nvim', -- needs lspconfig
    -- commit = 'ecffa1757ac8e84e1e128f12e0fdbf8418354f6f',
    dependencies = {  -- optional packages
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require 'go'.setup({
            lsp_semantic_highlights = false,
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
                        },
                        -- see https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
                        analyses = {
                            shadow = false,
                            QF1001 = true, -- de morgan
                            QF1006 = true,
                            QF1008 = true,
                            S1002 = true,
                            S1005 = true,
                            S1011 = true,
                            S1016 = true,
                            S1025 = true,
                            SA1014 = true,
                            SA1032 = true,
                            SA4005 = true,
                            SA4006 = true,
                            SA4008 = true,
                            SA4009 = true,
                            SA4010 = true,
                            SA4023 = true,
                            SA4031 = true,
                            SA5000 = true,
                            SA5007 = true,
                            SA5010 = true,
                            SA5011 = true,
                            SA9001 = true,
                            SA9008 = true,
                            ST1000 = false,
                            ST1005 = true,
                            ST1006 = true,
                            ST1008 = true,
                            ST1012 = true,
                            ST1013 = true,
                            slicesdelete = true,
                            copylocks = false,
                        }
                    }
                }
            },
            lsp_inlay_hints = {
                enable = false, -- this is the only field apply to neovim > 0.10
            },
        })
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 
      {'nvim-lua/plenary.nvim'},
      { 'nvim-telescope/telescope-live-grep-args.nvim' },
      -- { "MaximilianLloyd/adjacent.nvim" },
    },
    config = function()
      require('telescope').load_extension('live_grep_args')
      -- require('telescope').load_extension('adjancent')
      require('telescope').setup {
          defaults = {
              -- wrap_results = true,
              -- layout_strategy = 'vertical',
              layout_config = {
                  prompt_position = 'top',
                  -- mirror =  true,
                  -- preview_height = 0.6,
              },
              mappings = {
                  n = {
                      ['<c-d>'] = require('telescope.actions').delete_buffer
                  },
                  i = {
                      ["<C-h>"] = "which_key",
                      ['<c-d>'] = require('telescope.actions').delete_buffer
                  }
              },
              -- vimgrep_arguments = {
              --    "zg",
              --    "--column",
              --    "--color=never",
              -- },
          },
          pickers = {
              oldfiles = {
                  cwd_only = true,
              }
          },
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
    end,
  },
  {
    'nvim-telescope/telescope-github.nvim',
    config = function()
      require('telescope').load_extension('gh')
    end,
  },
  {
    'Marskey/telescope-sg',
    config = function()
      require('telescope').load_extension('ast_grep')
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
        require'nvim-treesitter.configs'.setup {
            ensure_installed = { "lua", "go", "yaml" },
            sync_install = true,
            auto_install = true,
            highlight = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-CR>",
                    node_incremental = "<C-CR>",
                    scope_incremental = false,
                    node_decremental = "<C-->",
                },
            },
        }
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true },
    config = function()
        require('lualine').setup {
            sections = {
                lualine_c = {
                    {
                        'filename',
                        path = 3,
                    },
                },
            },
        }
    end,
  },
  {
    'akinsho/bufferline.nvim', 
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require('bufferline').setup {
            -- If true, new buffers will be inserted at the start/end of the list.
            -- Default is to insert after current buffer.
            options = { sort_by = 'insert_at_end' }
        }
    end
  },
  {
    'lewis6991/gitsigns.nvim',
  },
  {'leisiji/interestingwords.nvim'},
  {
      'mizlan/iswap.nvim',
      config = function()
          require('iswap').setup{
              -- Move cursor to the other element in ISwap*With commands
              move_cursor = true,
          }
      end
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
    config = function()
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
                width = 30,
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = true,
            },
        })
    end,
  },
  { "almo7aya/openingh.nvim" },
  { 
      'nvim-mini/mini.completion',
      version = '*',
      config = function()
        require('mini.completion').setup()
      end,
  },
  {
      'nvim-mini/mini.fuzzy',
      version = '*',
      config = function()
        require('mini.fuzzy').setup()
      end
  },
  { 
      'nvim-mini/mini.pairs',
      version = '*',
      config = function()
        require('mini.pairs').setup()
      end
  },
  { 
      'nvim-mini/mini.indentscope',
      version = '*',
      config = function()
          require('mini.indentscope').setup()
          vim.cmd([[
          au FileType * if index(['yaml', 'gohtmltmpl', 'html'], &ft) < 0 | let b:miniindentscope_disable=v:true | endif
          ]])
      end
  },
  {
      'nvim-mini/mini.splitjoin',
      version = '*',
      config = function()
        require('mini.splitjoin').setup()
      end
  },
  {
      'nvim-mini/mini.snippets',
      version = '*',
      config = function()
      end
  },
  {
      'nvim-mini/mini.notify',
      version = '*',
      config = function()
        require('mini.notify').setup({
          window = {
            max_width_share = 0.6,
          },
        })
      end
  },
  {
      'nvim-mini/mini.clue',
      version = '*',
      config = function()
        local miniclue = require('mini.clue')
        miniclue.setup({
          triggers = {
            { mode = 'n', keys = '<Leader>' },
            { mode = 'x', keys = '<Leader>' },
            { mode = 'n', keys = 'g' },
            { mode = 'x', keys = 'g' },
            { mode = 'n', keys = "'" },
            { mode = 'x', keys = "'" },
            { mode = 'n', keys = '`' },
            { mode = 'x', keys = '`' },
            { mode = 'n', keys = '"' },
            { mode = 'x', keys = '"' },
            { mode = 'n', keys = '[' },
            { mode = 'x', keys = '[' },
            { mode = 'n', keys = ']' },
            { mode = 'x', keys = ']' },
            { mode = 'i', keys = '<C-x>' },
            { mode = 'n', keys = '<C-w>' },
          },
          clues = {
            miniclue.gen_clues.builtin_completion(),
            miniclue.gen_clues.g(),
            miniclue.gen_clues.marks(),
            miniclue.gen_clues.registers(),
            miniclue.gen_clues.windows(),
            miniclue.gen_clues.z(),
            miniclue.gen_clues.square_brackets(),
          },
        })
      end
  },
  {'kevinhwang91/nvim-bqf', ft = 'qf'},
  {'nvim-treesitter/nvim-treesitter-context'},
  {'nvim-treesitter/nvim-treesitter-textobjects'},
  {'ziontee113/syntax-tree-surfer'},
  {
    'sindrets/diffview.nvim'
  },
  {
    "fredrikaverpil/godoc.nvim",
    version = "*",
    dependencies = {
        { "nvim-telescope/telescope.nvim" }, -- optional
        { "folke/snacks.nvim" }, -- optional
        { "echasnovski/mini.pick" }, -- optional
        { "ibhagwan/fzf-lua" }, -- optional
        {
            "nvim-treesitter/nvim-treesitter",
            opts = {
              ensure_installed = { "go" },
            },
        },
    },
    build = "go install github.com/lotusirous/gostdsym/stdsym@latest", -- optional
    cmd = { "GoDoc" }, -- optional
    opts = {},
  },
  {
    "saghen/blink.cmp",
    lazy = false,
    version = "*",
    opts = {
      keymap = {
        preset = "enter",
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
      },
    },
  },
  {
      "coder/claudecode.nvim",
      dependencies = { "folke/snacks.nvim" },
      config = true,
      keys = {
          { "<leader>a", nil, desc = "AI/Claude Code" },
          { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
          { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
          { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
          { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
          { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
          { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
          { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
          {
            "<leader>as",
            "<cmd>ClaudeCodeTreeAdd<cr>",
            desc = "Add file",
            ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
          },
          -- Diff management
          { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
          { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
      }
   },
   {
	   "debugloop/telescope-undo.nvim",
	   dependencies = { "nvim-telescope/telescope.nvim" },
	   config = function()
		   require("telescope").load_extension("undo")
	   end
   }
}

-- Before lazy.nvim section.
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

local set = vim.opt
local fn = vim.fn

set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.number = true
set.clipboard = "unnamedplus"
set.spelllang = "en"
set.mousescroll = "ver:1"

-- backups
set.backup = true
set.shada = "!,h,'1000,<1000,s128,/1000,:1000,@1000"
local datadir = fn.stdpath('data')
vim.o.backupdir = datadir .. '/backup'
vim.o.directory = datadir .. '/tmp'
vim.o.undodir   = datadir .. '/undo'

vim.api.nvim_create_autocmd('BufWritePre', {
    callback = function()
        local extension = "~" .. vim.fn.strftime("%Y-%m-%d-%H%M%S")
        vim.o.backupext = extension
    end,
})
---


require("lazy").setup({
  spec = plugins,
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { 
    enabled = true,
    frequency = 86400, -- check for updates every day
  },
})
