return function(mode, before, after, opts)
  local options = { noremap = true }
  options = vim.tbl_deep_extend('force', options, opts or {})
  vim.api.nvim_set_keymap(mode, before, after, options)
end

-- TODO: able to pass in string formatter?
--return function(mode, before, after, opts, formatter)
--  --if formatter then
--    after = formatter
--  end
--
--  local options = { noremap = true }
--  options = vim.tbl_deep_extend('force', options, opts or {})
--
--  vim.api.nvim_set_keymap(mode, before, after, options)
--end

--return function(mode, before, after, opts)
--  local options = { noremap = true }
--
--  -if opts then
--  for k, v in pairs(opts) do
--    options[k] = v
--  end
--  --end
--
--  vim.api.nvim_set_keymap(mode, before, after, options)
--end

