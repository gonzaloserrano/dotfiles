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
    tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
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
    'akinsho/bufferline.nvim', 
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

  use 'github/copilot.vim'

  use {
    "jackMort/ChatGPT.nvim",
	commit = "24bcca7",
    config = function()
      require("chatgpt").setup({
        -- optional configuration
      })
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  }

  use {
	  "chrisgrieser/nvim-various-textobjs",
	  config = function () 
		  require("various-textobjs").setup({ useDefaultKeymaps = true })
	  end,
  }

  use({ "MaximilianLloyd/adjacent.nvim" })

  use({ "almo7aya/openingh.nvim" })

  use { 'echasnovski/mini.completion', branch = 'stable' }
  use { 'echasnovski/mini.pairs', branch = 'stable' }
end)
