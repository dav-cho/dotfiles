-- WIP
vim.keymap.set("n", "<Leader>zf", function()
  vim.opt_local.foldnestmax = 1
  -- vim.opt_local.foldlevel = 0
  vim.opt_local.foldmethod = "expr"
  -- vim.wo.foldmethod = 'expr'

  -- https://github.com/nvim-treesitter/nvim-treesitter#folding
  vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  -- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  -- vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
end, { desc = "Set YAML treesitter folds" })
