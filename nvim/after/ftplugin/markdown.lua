-- TODO: default shiftwidth not working for some reason
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2

vim.keymap.set("n", "<Leader>--", "i- [ ] ", { buffer = true, desc = "Insert checkbox" })
