local M = {}

M.map = function(mode, before, after, opts)
  vim.keymap.set(mode, before, after, opts)
end

---- noremap
M.nnoremap = function(before, after, opts)
  local options = { noremap = true }
  options = vim.tbl_deep_extend("force", options, opts or {})
  vim.keymap.set("n", before, after, opts)
end

M.inoremap = function(before, after, opts)
  local options = { noremap = true }
  options = vim.tbl_deep_extend("force", options, opts or {})
  vim.keymap.set("i", before, after, opts)
end

M.vnoremap = function(before, after, opts)
  local options = { noremap = true }
  options = vim.tbl_deep_extend("force", options, opts or {})
  vim.keymap.set("v", before, after, opts)
end

---- buf noremap
M.buf_nnoremap = function(bufnr, before, after, opts)
  local options = { buffer = bufnr, noremap = true }
  options = vim.tbl_deep_extend("force", options, opts or {})
  vim.keymap.set("n", before, after, opts)
end

M.buf_inoremap = function(bufnr, before, after, opts)
  local options = { buffer = bufnr, noremap = true }
  options = vim.tbl_deep_extend("force", options, opts or {})
  vim.keymap.set("i", before, after, opts)
end

M.buf_vnoremap = function(bufnr, before, after, opts)
  local options = { buffer = bufnr, noremap = true }
  options = vim.tbl_deep_extend("force", options, opts or {})
  vim.keymap.set("v", before, after, opts)
end

return M
