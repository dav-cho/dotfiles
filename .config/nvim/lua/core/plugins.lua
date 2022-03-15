-- Auto Install Packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Autocommand for :PackerSync or :PackerCompile on save
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])

-- Use protected call to prevent error on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  vim.notify('~ Packer CALL ERROR')
  return
end

-- Use popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end,
  },
}

return require('packer').startup(function(use)
  -- Main --
  use 'wbthomason/packer.nvim' -- have packer manage itself.
  use 'nvim-lua/plenary.nvim'
  --use 'nvim-lua/popup.nvim' -- TODO: need?

  -- Theming --
  use "lunarvim/darkplus.nvim"
  use 'folke/tokyonight.nvim'
  --use 'nanotech/jellybeans.vim'
  --use "lukas-reineke/indent-blankline.nvim"

  -- LSP --
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'b0o/SchemaStore.nvim'
  use 'RRethy/vim-illuminate'

  -- Completion --
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use "hrsh7th/cmp-nvim-lsp"
  use 'hrsh7th/cmp-nvim-lua'
  use 'saadparwaiz1/cmp_luasnip'

  -- Snippets --
  use 'L3MON4D3/LuaSnip'

  -- Treesitter --
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- Telescope --
  use 'nvim-telescope/telescope.nvim'
  use 'kyazdani42/nvim-web-devicons'

  -- Vim --
  use 'tpope/vim-surround' -- TODO: make it work with '.' (repeat command)
  use 'easymotion/vim-easymotion'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

