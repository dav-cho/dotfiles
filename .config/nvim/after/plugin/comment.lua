local ok, comment = pcall(require, 'Comment')
if not ok then
  vim.notify('~ Comment Call Error!')
  return
end

comment.setup()

local opts = { noremap = true, silent = true, expr = true }
local comment_command = [[v:count == 0 ? '<CMD>lua require("Comment.api").call("toggle_current_linewise_op")<CR>g@$' : '<CMD>lua require("Comment.api").call("toggle_linewise_count_op")<CR>g@$']]

vim.api.nvim_set_keymap('n', '<C-_>', comment_command, opts)
vim.api.nvim_set_keymap('v', '<C-_>', comment_command, opts)

-- comment.setup {
--   toggler = {
--     line = '<C-_>',
--   },
--   opleader = {
--     line = '<C-_>',
--   },
-- }

