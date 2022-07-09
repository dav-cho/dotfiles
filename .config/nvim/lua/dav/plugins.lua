-- TODO: Need? Duplicate of first_load.lua... but how to get `packer_bootstrap` from first_load?
-- Auto Install Packer
-- local fn = vim.fn
-- local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
-- 
-- if fn.empty(fn.glob(install_path)) > 0 then
--   packer_bootstrap = fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
-- end

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
-- _ = vim.cmd [[packadd packer.nvim]]

-- TODO: use new vim.api.nvim_create_autocmd
-- Autocommand for :PackerSync or :PackerCompile on save
vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]])

-- vim.api.nvim_create_augroup("packer_user_config", {
-- })
-- vim.api.nvim_create_autocmd("BufWritePost", {
-- 	group = "packer_user_config",
-- 	-- command = "plugins.lua source <afile> | PackerSync", -- cannot be used with callback
-- 	callback = function()
-- 		-- do something...
-- 	end,
-- })

-- TODO
local ok, packer = pcall(require, "packer")
if not ok then
  return
--   local first_load = require "dav.first_load"()
--   if not first_load then
--     return
-- end
end

local use = packer.use

-- return require ("packer").startup {
packer.startup {
  function()
    -- Main --
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'nvim-lualine/lualine.nvim'
    -- use 'akinsho/bufferline.nvim'
    use {'akinsho/bufferline.nvim', tag = "v2.*"}

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
     use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

     -- Vim --
     use 'tpope/vim-surround' -- TODO: make it work with '.' (repeat command)
     use 'easymotion/vim-easymotion'
     use 'tpope/vim-repeat'

    -- Themes --
    use "lunarvim/darkplus.nvim"
    -- use 'folke/tokyonight.nvim'
    -- use 'marko-cerovac/material.nvim'

    -- Other --
    use 'windwp/nvim-autopairs'
    use 'windwp/nvim-ts-autotag'
    use 'numToStr/Comment.nvim'
    use {
      'prettier/vim-prettier',
      run = 'yarn install --frozen-lockfile --production',
    }
    use 'norcalli/nvim-colorizer.lua'
    use 'lewis6991/gitsigns.nvim'
    
    -- TODO: how to get this from first_load?
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require('packer').sync()
    end
  end,

  config = {
  },
}
