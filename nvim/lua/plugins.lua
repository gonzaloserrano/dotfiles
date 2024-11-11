return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'lunarvim/Onedarker.nvim'
  use 'neovim/nvim-lspconfig'
  use {
    'ray-x/go.nvim', -- needs lspconfig
    requires = { 
	    { 
		    'ray-x/guihua.lua',
		    run = 'cd lua/fzy && make',
	    } 
    }
  }
  use { -- for go.nvim
    'nvim-telescope/telescope.nvim',
	requires = { 
	  {'nvim-lua/plenary.nvim'},
	  { 'nvim-telescope/telescope-live-grep-args.nvim' }
	},
	config = function()
	  require('telescope').load_extension('live_grep_args')
	end,
  }
  use {
	'nvim-telescope/telescope-github.nvim',
	config = function()
	  require('telescope').load_extension('gh')
	end,
  }
  use {
	'Marskey/telescope-sg',
	config = function()
	  require('telescope').load_extension('ast_grep')
	end,
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use {
	'Theyashsawarkar/bufferline.nvim',
    -- 'akinsho/bufferline.nvim', 
    tag = "v3.*", 
    requires = 'nvim-tree/nvim-web-devicons'
  }

  use 'lewis6991/gitsigns.nvim'

  use 'leisiji/interestingwords.nvim'

  use 'mizlan/iswap.nvim'

  use {
    'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  use {
	  'rmehri01/onenord.nvim'
  }

  -- use 'github/copilot.vim'

-- use {
--   "jackMort/ChatGPT.nvim",
--   commit = "24bcca7",
--   config = function()
--     require('chatgpt").setup({
--       -- optional configuration
--     })
--   end,
--   requires = {
--     "MunifTanjim/nui.nvim",
--     "nvim-lua/plenary.nvim",
--     "nvim-telescope/telescope.nvim"
--   }
-- }

  use {
	  "chrisgrieser/nvim-various-textobjs",
	  config = function () 
		  require("various-textobjs").setup({ useDefaultKeymaps = true })
	  end,
  }

  use { "MaximilianLloyd/adjacent.nvim" }

  use { "almo7aya/openingh.nvim" }

  use { 'echasnovski/mini.completion', branch = 'stable' }
  use { 'echasnovski/mini.fuzzy', branch = 'stable' }
  use { 'echasnovski/mini.pairs', branch = 'stable' }
  use { 'echasnovski/mini.indentscope', branch = 'stable' }
  -- use { 'echasnovski/mini.trailspace', branch = 'stable' }
  use {'kevinhwang91/nvim-bqf', ft = 'qf'}
  use {'nvim-treesitter/nvim-treesitter-context'}
  use {'nvim-treesitter/nvim-treesitter-textobjects'}
  use {'ziontee113/syntax-tree-surfer'}
  use {'j-hui/fidget.nvim'}
  --
  use {
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

		  require("gp").setup(config)
		  -- shortcuts might be setup here (see Usage > Shortcuts in Readme)
	  end,
  }
end)
