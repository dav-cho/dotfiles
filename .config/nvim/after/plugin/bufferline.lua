local ok, bufferline = pcall(require, 'bufferline')
if not ok then
  vim.notify('~ Bufferline Call Error!')
  return
end

bufferline.setup {
  options = {
    --mode = 'buffers',
    numbers = function(opts)
      return string.format('%s%s', opts.raise(opts.ordinal), opts.lower(opts.id))
    end,

    diagnostics = 'nvim_lsp',
    diagnostics_update_in_insert = true,
    -- Customized LSP Indicators --
    --- count is an integer representing total count of errors
    --- level is a string "error" | "warning"
    --- diagnostics_dict is a dictionary from error level ("error", "warning" or "info")to number of errors for each level.
    --- this should return a string
    --- Don't get too fancy as this function will be executed a lot
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
    -- To set conditional buffer based LSP indicators use below: --
    --diagnostics_indicator = function(count, level, diagnostics_dict, context)
    --  if context.buffer:current() then
    --    return ''
    --  end

    --  return ''
    --end,

    custom_areas = {
      right = function()
        local result = {}
        local seve = vim.diagnostic.severity
        local error = #vim.diagnostic.get(0, {severity = seve.ERROR})
        local warning = #vim.diagnostic.get(0, {severity = seve.WARN})
        local info = #vim.diagnostic.get(0, {severity = seve.INFO})
        local hint = #vim.diagnostic.get(0, {severity = seve.HINT})

        if error ~= 0 then
          table.insert(result, {text = "  " .. error, guifg = "#EC5241"})
        end

        if warning ~= 0 then
          table.insert(result, {text = "  " .. warning, guifg = "#EFB839"})
        end

        if hint ~= 0 then
          table.insert(result, {text = "  " .. hint, guifg = "#A3BA5E"})
        end

        if info ~= 0 then
          table.insert(result, {text = "  " .. info, guifg = "#7EA9A7"})
        end
        return result
      end,
    },

    -- TODO: Groups
    --groups = {
    --}

    -- TODO: lsp indicator icon colors?
    --highlights = {
    --  modified = {
    --    guifg = { attribute = "fg", highlight = "TabLine" },
    --    guibg = { attribute = "bg", highlight = "TabLine" },
    --  },
    --  modified_selected = {
    --    guifg = { attribute = "fg", highlight = "Normal" },
    --    guibg = { attribute = "bg", highlight = "Normal" },
    --  },
    --  modified_visible = {
    --    guifg = { attribute = "fg", highlight = "TabLine" },
    --    guibg = { attribute = "bg", highlight = "TabLine" },
    --  },
    --},
  }
}

