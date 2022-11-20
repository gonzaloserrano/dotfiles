return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'lunarvim/Onedarker.nvim'
  use 'neovim/nvim-lspconfig'
  use 'ray-x/go.nvim' -- needs lspconfig
  use { -- for go.nvim
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'nvim-treesitter/nvim-treesitter'

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
end)
