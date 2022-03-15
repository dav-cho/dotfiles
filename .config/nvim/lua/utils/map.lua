return function(mode, before, after, opts)
  local options = { noremap = true }

  if opts then
    for k, v in pairs(opts) do
      options[k] = v
    end
  end

  vim.api.nvim_set_keymap(mode, before, after, options)
end

