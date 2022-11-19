return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use "lunarvim/Onedarker.nvim"
  use 'neovim/nvim-lspconfig'
  use 'ray-x/go.nvim'
end)
