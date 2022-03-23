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
local ok, packer = pcall(require, 'packer')
if not ok then
  vim.notify('~ Packer Call Error!')
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
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-lualine/lualine.nvim'
  use 'akinsho/bufferline.nvim'

  -- Theming --
  use "lunarvim/darkplus.nvim"
  use 'folke/tokyonight.nvim'
  use 'marko-cerovac/material.nvim'
  --use 'nanotech/jellybeans.vim'
  --use "lukas-reineke/indent-blankline.nvim"

  -- LSP --
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'b0o/SchemaStore.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'
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
  use 'p00f/nvim-ts-rainbow'

  -- Telescope --
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'

  -- Vim --
  use 'tpope/vim-surround' -- TODO: make it work with '.' (repeat command)
  use 'easymotion/vim-easymotion'

  -- Other --
  use 'windwp/nvim-autopairs'
  use 'numToStr/Comment.nvim'
  use {
    'prettier/vim-prettier',
    --ft = { 'html', 'css', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    run = 'yarn install --frozen-lockfile --production',
  }
  use 'norcalli/nvim-colorizer.lua'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

