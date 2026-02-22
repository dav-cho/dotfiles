-- https://github.com/nvim-treesitter/nvim-treesitter#folding
vim.keymap.set("n", "<Leader>zf", function()
  vim.opt_local.foldnestmax = 1
  vim.opt_local.foldmethod = "expr"
  vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  -- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
end, { desc = "Set YAML treesitter folds" })
