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
end)
