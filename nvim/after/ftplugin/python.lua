vim.g.python_indent = {
  open_paren = "shiftwidth()",
  nested_paren = "shiftwidth()",
  continue = "shiftwidth()",
  closed_paren_align_last_line = false,
}

vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.colorcolumn = "89"

vim.keymap.set("n", "<Leader>py", "<Cmd>!python %<CR>", { buffer = true, desc = ":!python %" })
vim.keymap.set("n", "<Leader>pe", "<Cmd>!pipenv run python %<CR>", { buffer = true, desc = ":!pipenv run python %" })
vim.keymap.set("n", "<Leader>pi", function()
  vim.cmd(string.format([[TermExec cmd="python %s"]], vim.fn.expand("%:~:.")))
end, { buffer = true, desc = "[ToggleTerm] python %" })
vim.keymap.set("n", "<Leader>==", "o<Esc>88i#<Esc>0o<Esc>k", { buffer = true, desc = "Insert linbelowe break comment" })
vim.keymap.set("n", "<Leader>po", 'oprint("-" * 100)<Esc>', { buffer = true, desc = "print below" })
vim.keymap.set("n", "<Leader>pO", 'Oprint("-" * 100)<Esc>', { buffer = true, desc = "print above" })
vim.keymap.set("n", "<Leader>ym", function()
  local module = vim.fn.expand("%:~:.")
  module = string.gsub(module, "/", ".")
  module = string.gsub(module, ".py$", "")
  vim.fn.setreg("+", module)
  return module
end, { buffer = true, desc = "Yank module name" })
