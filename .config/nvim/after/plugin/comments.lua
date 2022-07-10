local nnoremap = require("dav.utils.keymap").nnoremap
local vnoremap = require("dav.utils.keymap").vnoremap

if not pcall(require, "Comment") then
  return
end

require("Comment").setup()

local comment_command = function()
  local count = vim.v.count
  if count == 0 then
    return "<CMD>lua require('Comment.api').call('toggle_current_linewise_op')<CR>g@$"
  else
    return "<CMD>lua require('Comment.api').call('toggle_linewise_count_op')<CR>g@$"
  end
end

nnoremap("<C-_>", function() return comment_command() end, { silent = true, expr = true })
vnoremap("<C-_>", function() return comment_command() end, { silent = true, expr = true })



-- OLD
-- local comment_command = [[v:count == 0 ? "<CMD>lua require('Comment.api').call('toggle_current_linewise_op')<CR>g@$" : "<CMD>lua require('Comment.api').call('toggle_linewise_count_op')<CR>g@$"]]
-- local comment_command = [[v:count == 0 ? ]]
--                         .. [["<CMD>lua require('Comment.api').call('toggle_current_linewise_op')<CR>g@$" : ]]
--                         .. [["<CMD>lua require('Comment.api').call('toggle_linewise_count_op')<CR>g@$"]]

-- nnoremap("<c-_>", comment_command, { silent = true, expr = true })
-- vnoremap("<C-_>", comment_command, { silent = true, expr = true })


---- Defaults:
-- {
--     ---Add a space b/w comment and the line
--     padding = true,
--
--     ---Whether the cursor should stay at its position
--     ---NOTE: This only affects NORMAL mode mappings and doesn"t work with dot-repeat
--     sticky = true,
--
--     ---Lines to be ignored while comment/uncomment.
--     ---Could be a regex string or a function that returns a regex string.
--     ---Example: Use "^$" to ignore empty lines
--     ignore = nil,
--
--     ---LHS of toggle mappings in NORMAL + VISUAL mode
--     toggler = {
--         ---Line-comment toggle keymap
--         line = "gcc",
--         ---Block-comment toggle keymap
--         block = "gbc",
--     },
--
--     ---LHS of operator-pending mappings in NORMAL + VISUAL mode
--     opleader = {
--         ---Line-comment keymap
--         line = "gc",
--         ---Block-comment keymap
--         block = "gb",
--     },
--
--     ---LHS of extra mappings
--     extra = {
--         ---Add comment on the line above
--         above = "gcO",
--         ---Add comment on the line below
--         below = "gco",
--         ---Add comment at the end of line
--         eol = "gcA",
--     },
--
--     ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
--     ---NOTE: If `mappings = false` then the plugin won"t create any mappings
--     mappings = {
--         ---Operator-pending mapping
--         ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
--         ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
--         basic = true,
--         ---Extra mapping
--         ---Includes `gco`, `gcO`, `gcA`
--         extra = true,
--         ---Extended mapping
--         ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
--         extended = false,
--     },
--
--     ---Pre-hook, called before commenting the line
--     pre_hook = nil,
--
--     ---Post-hook, called after commenting is done
--     post_hook = nil,
-- }
