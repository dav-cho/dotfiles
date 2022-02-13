------------------------------- Packer -------------------------------

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)


return require('packer').startup(function()

  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'tpope/vim-surround'
  use 'ojroques/nvim-hardline'
  use 'hoob3rt/lualine.nvim'
  use 'hrsh7th/nvim-compe'
  use 'windwp/nvim-autopairs'
  use 'lewis6991/gitsigns.nvim'

  use 'kyazdani42/nvim-web-devicons'
  use 'gruvbox-community/gruvbox'
  use 'tyrannicaltoucan/vim-quantum'
  use 'joshdick/onedark.vim'
  use {'dracula/vim', as = 'dracula'}
  use 'nanotech/jellybeans.vim'
  use 'tomasiser/vim-code-dark'
  use 'drewtempelmeyer/palenight.vim'
  use 'junegunn/seoul256.vim'
  use 'ayu-theme/ayu-vim'
  use 'dikiaap/minimalist'
  use 'sainnhe/gruvbox-material'
  use 'NLKNguyen/papercolor-theme'
  use 'sainnhe/everforest'
  use 'sainnhe/sonokai'
  use 'sainnhe/edge'
  use 'ghifarit53/tokyonight-vim'
  use 'rakr/vim-one'
  use 'kaicataldo/material.vim'
  use 'sts10/vim-pink-moon'
  use 'arcticicestudio/nord-vim'
  use 'ulwlu/elly.vim'
  use 'widatama/vim-phoenix'

  --use 'mhinz/vim-janah'
  --use 'jnurmine/Zenburn'
  --use 'ackyshake/Spacegray.vim'
  --use 'danishprakash/vim-yami'
  --use 'cocopon/iceberg.vim'
  --use 'sonph/onehalf'
  --use 'sickill/vim-monokai'
  --use 'embark-theme/vim', { 'as': 'embark' }
  --use 'danilo-augusto/vim-afterglow'
  --use 'trevordmiller/nova-vim'
  --use 'kristijanhusak/vim-hybrid-material'
  --use 'w0ng/vim-hybrid'
  --use 'ajmwagar/vim-deus'
  --use 'artanikin/vim-synthwave84'
  --use ''Rigellute/shades-of-purple.vim''
  --
  --use 'jaredgorski/fogbell.vim'


  --use {'psf/black', { 'branch': 'stable' }}
  --use {junegunn/fzf.vim}

  --use {
  --  'nvim-telescope/telescope.nvim',
  --  requires = {
  --    {'nvim-lua/popup.nvim'},
  --    {'nvim-lua/plenary.nvim'}
  --  }
  --}
  --use {
  --  'lewis6991/gitsigns.nvim',
  --  requires = {
  --    'nvim-lua/plenary.nvim'
  --  }
  --}
  
end)

----------------------------------------------------------------------

