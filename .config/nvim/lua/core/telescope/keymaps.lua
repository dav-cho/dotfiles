local map_tele = function(before, after, type, opts)  -- type = 'builtin' | 'extensions' | etc...
  local options = { noremap = true, silent = true }

  local rhs = ''
  if type == 'builtin' then
    rhs = string.format("<cmd>lua require('telescope.%s').%s()<CR>", type, after)
  elseif type == 'extensions' then
    rhs = string.format("<cmd>lua require('telescope').%s.%s()<CR>", type, after)
  else
    vim.notify('~ Invalid Type')
  end

  options = vim.tbl_deep_extend('force', options, opts or {})
  vim.api.nvim_set_keymap('n', before, rhs, options)
end

-- File Pickers
map_tele('<leader>ff', 'find_files', 'builtin')
map_tele('<leader>gs', 'grep_string', 'builtin')
map_tele('<leader>lg', 'live_grep', 'builtin')
map_tele('<leader>bb', 'file_browser.file_browser', 'extensions')

-- Vim Pickers
map_tele('<leader>bu', 'buffers', 'builtin')
map_tele('<leader>re', 'registers', 'builtin')
map_tele('<leader>ju', 'jumplist', 'builtin')

map_tele('<leader>fo', 'oldfiles', 'builtin')
map_tele('<leader>fc', 'commands', 'builtin')
map_tele('<leader>fh', 'help_tags', 'builtin')
map_tele('<leader>fr', 'resume', 'builtin')

map_tele('<C-r>', 'command_history', 'builtin')
map_tele('<leader>bf', 'current_buffer_fuzzy_find', 'builtin')

-- Neovim LSP Pickers
-- map_tele('<leader>lr', 'lsp_references', 'builtin')
map_tele('<F12>', 'lsp_references', 'builtin')
map_tele('<leader>ls', 'lsp_document_symbols', 'builtin')
map_tele('<leader>la', 'lsp_code_actions', 'builtin')
-- map_tele('<leader>li', 'lsp_implementations', 'builtin)
-- map_tele('<leader>ld', 'lsp_type_definitions', 'builtin)

-- Git Pickers
map_tele('<leader>st', 'git_status', 'builtin')
map_tele('<leader>co', 'git_commits', 'builtin')
map_tele('<leader>br', 'git_branchs', 'builtin')

-- Treesitter Picker
map_tele('<leader>ts', 'treesitter', 'builtin')

-- Lists Pickers
map_tele('<leader>fb', 'builtin', 'builtin')
map_tele('<leader>fl', 'reloader', 'builtin')

