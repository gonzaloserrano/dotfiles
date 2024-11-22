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
	dependencies = {  -- optional packages
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
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
			  wrap_results = true,
			  layout_strategy = 'vertical',
			  layout_config = {
				  prompt_position = 'top',
				  mirror =  true,
				  preview_height = 0.6,
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
	  configure = function()
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
				adaptive_size = true,
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
  -- 'github/copilot.vim'
-- {
--   "jackMort/ChatGPT.nvim",
--   commit = "24bcca7",
--   config = function()
--     require('chatgpt").setup({
--       -- optional configuration
--     })
--   end,
--   dependencies = {
--     "MunifTanjim/nui.nvim",
--     "nvim-lua/plenary.nvim",
--     "nvim-telescope/telescope.nvim"
--   }
-- }
--[[
  {
	  "chrisgrieser/nvim-various-textobjs",
	  config = function () 
		  require("various-textobjs").init({ useDefaultKeymaps = true })
	  end,
  },
]]--
  { "almo7aya/openingh.nvim" },
  { 
	  'echasnovski/mini.completion',
	  version = '*',
	  config = function()
		require('mini.completion').setup()
	  end,
  },
  { 
	  'echasnovski/mini.fuzzy',
	  version = '*',
	  config = function()
	  end
  },
  { 
	  'echasnovski/mini.pairs',
	  version = '*',
	  config = function()
		require('mini.pairs').setup()
	  end
  },
  { 
	  'echasnovski/mini.indentscope',
	  version = '*',
	  config = function()
		  require('mini.indentscope').setup()
		  vim.cmd([[
		  au FileType * if index(['yaml', 'gohtmltmpl'], &ft) < 0 | let b:miniindentscope_disable=v:true | endif
		  ]])
	  end
  },
  {'kevinhwang91/nvim-bqf', ft = 'qf'},
  {'nvim-treesitter/nvim-treesitter-context'},
  {'nvim-treesitter/nvim-treesitter-textobjects'},
  {'ziontee113/syntax-tree-surfer'},
  {
	  'j-hui/fidget.nvim',
	  config = function()
		require('fidget').setup()
	  end
  },
  --
  {
	  "robitx/gp.nvim",
	  config = function()
		  local config = {
			  hooks = {
				  InspectPlugin = function(plugin, params)
					  local bufnr = vim.api.nvim_create_buf(false, true)
					  local copy = vim.deepcopy(plugin)
					  local key = copy.config.openai_api_key
					  copy.config.openai_api_key = key:sub(1, 3) .. string.rep("*", #key - 6) .. key:sub(-3)
					  for provider, _ in pairs(copy.providers) do
						  local s = copy.providers[provider].secret
						  if s and type(s) == "string" then
							  copy.providers[provider].secret = s:sub(1, 3) .. string.rep("*", #s - 6) .. s:sub(-3)
						  end
					  end
					  local plugin_info = string.format("Plugin structure:\n%s", vim.inspect(copy))
					  local params_info = string.format("Command params:\n%s", vim.inspect(params))
					  local lines = vim.split(plugin_info .. "\n" .. params_info, "\n")
					  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
					  vim.api.nvim_win_set_buf(0, bufnr)
				  end,
				  Implement = function(gp, params)
					  local template = "Having following from {{filename}}:\n\n"
					  .. "```{{filetype}}\n{{selection}}\n```\n\n"
					  .. "Please rewrite this according to the contained instructions."
					  .. "\n\nRespond exclusively with the snippet that should replace the selection above."

					  local agent = gp.get_command_agent()
					  gp.info("Implementing selection with agent: " .. agent.name)

					  gp.Prompt(
					  params,
					  gp.Target.rewrite,
					  nil, -- command will run directly without any prompting for user input
					  agent.model,
					  template,
					  agent.system_prompt
					  )
				  end,
				  UnitTests = function(gp, params)
					  local template = "I have the following Go code from {{filename}}:\n\n"
					  .. "```{{filetype}}\n{{selection}}\n```\n\n"
					  .. "Please respond by writing table driven unit tests for the code above."
					  .. "Make sure the code compiles properly! Don't respond with code if you are not sure."
					  local agent = gp.get_command_agent()
					  gp.Prompt(params, gp.Target.enew, nil, agent.model, template, agent.system_prompt)
				  end,
				  GoDoc = function(gp, params)
					  local template = "I have the following Go code from {{filename}}:\n\n"
					  .. "```{{filetype}}\n{{selection}}\n```\n\n"
					  .. "Please respond by writing the godoc for the code above."
					  .. "Don't respond with code if you are not sure."
					  local agent = gp.get_command_agent()
					  gp.Prompt(params, gp.Target.enew, nil, agent.model, template, agent.system_prompt)
				  end,
			  },
		  }

		  -- require("gp").init(config)
		  -- shortcuts might be setup here (see Usage > Shortcuts in Readme)
	  end,
  },
  {
	'sindrets/diffview.nvim'
  }
}


-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

require("lazy").setup({
  spec = plugins,
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
