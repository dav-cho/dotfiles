local ok, comment = pcall(require, 'Comment')
if not ok then
  vim.notify('~ Comment Call Error!')
  return
end

comment.setup {
  toggler = {
    line = '<C-_>',
  },
}


-- TODO: Comment over multiple lines

--local map = require 'utils.map'

-- vim.api.nvim_set_keymap('v', '<C-_>', '<cmd>lua require("Comment.api").toggle_linewise_op(vmode, cfg)<cr>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('v', '<C-_>', '<cmd>lua require("Comment.api").toggle_linewise_count(cfg)<cr>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('v', '<C-_>', '<cmd>lua require("Comment.api").toggle_current_linewise_op(vmode, cfg)<cr>', { noremap = true, silent = true })

