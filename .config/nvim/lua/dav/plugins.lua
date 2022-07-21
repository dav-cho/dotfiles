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
    use "wbthomason/packer.nvim"
    use "nvim-lua/plenary.nvim"
    use "nvim-lua/popup.nvim"
    use "kyazdani42/nvim-web-devicons"
    use "nvim-lualine/lualine.nvim"
    use { "akinsho/bufferline.nvim", tag = "v2.*" }

    -- Themes --
    use "lunarvim/darkplus.nvim"
    -- use "folke/tokyonight.nvim"
    -- use "marko-cerovac/material.nvim"

    -- LSP --
    use "neovim/nvim-lspconfig"
    use "williamboman/nvim-lsp-installer"
    use "b0o/SchemaStore.nvim"
    use "jose-elias-alvarez/null-ls.nvim"
    use "RRethy/vim-illuminate"
    use "j-hui/fidget.nvim"

    -- Completion --
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-nvim-lsp-document-symbol"
    use "hrsh7th/cmp-nvim-lsp-signature-help"
    use "saadparwaiz1/cmp_luasnip"
    use "onsails/lspkind-nvim"
    use "lukas-reineke/cmp-under-comparator"

    -- Snippets --
    use "L3MON4D3/LuaSnip"

    -- Treesitter --
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate"
    }
    use "p00f/nvim-ts-rainbow"

    -- Telescope --
    use "nvim-telescope/telescope.nvim"
    use "nvim-telescope/telescope-file-browser.nvim"
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

    -- Vim --
    use "tpope/vim-surround"
    use "easymotion/vim-easymotion"
    use "tpope/vim-repeat"

    -- Debugger --
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'
    use 'nvim-telescope/telescope-dap.nvim'
    use 'mfussenegger/nvim-dap-python'
    use 'leoluz/nvim-dap-go'

    -- Other --
    use "windwp/nvim-autopairs"
    use "windwp/nvim-ts-autotag"
    use "numToStr/Comment.nvim"
    -- TODO
    -- use {
    --   "prettier/vim-prettier",
    --   run = "yarn install --frozen-lockfile --production",
    -- }
    -- use {
    --   "prettier/vim-prettier",
    --   ft = { "html", "javascript", "typescript", "typescriptreact" },
    --   run = "yarn install",
    -- }
    use "norcalli/nvim-colorizer.lua"
    use "lewis6991/gitsigns.nvim"

    -- New --
    -- use {
    --   "folke/trouble.nvim",
    --   requires = "kyazdani42/nvim-web-devicons",
    --   config = function()
    --     require("trouble").setup {
    --       -- your configuration comes here
    --       -- or leave it empty to use the default settings
    --       -- refer to the configuration section below
    --     }
    --   end
    -- }

    -- use "rcarriga/nvim-notify"

    -- use {
    --   "AckslD/nvim-neoclip.lua",
    --   requires = {
    --     { 'nvim-telescope/telescope.nvim' },
    --   },
    --   config = function()
    --     require('neoclip').setup()
    --   end,
    -- }

    -- use "folke/zen-mode.nvim"
    -- use "folke/twilight.nvim"
    -- use "junegunn/goyo.vim"
    -- use "junegunn/limelight.vim"

    -- use { "iamcco/markdown-preview.nvim", ft = "markdown", run = "cd app && yarn install" }

    -- use { "liuchengxu/vista.vim", cmd = "Vista" }

    -- use "windwp/nvim-spectre"

    -- use "danymat/neogen"

    -- use "tamago324/lir.nvim"

    -- if executable "mmv" then
    --   use "tamago324/lir-mmv.nvim"
    -- end

    -- use "pechorin/any-jump.vim"

    -- use "TimUntersberger/neogit"

    -- use "sindrets/diffview.nvim"

    -- use "rhysd/git-messenger.vim"




    -- TODO: how to get this from first_load?
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require("packer").sync()
    end
  end,

  config = {
  },
}
