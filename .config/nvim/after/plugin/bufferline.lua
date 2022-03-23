local ok, bufferline = pcall(require, 'bufferline')
if not ok then
  vim.notify('~ Bufferline Call Error!')
  return
end

bufferline.setup {
  options = {
    --mode = 'tabs',

    -- numbers = function(opts)
    --   return string.format('%s%s', opts.raise(opts.ordinal), opts.lower(opts.id))
    -- end,

    name_formatter = function(buf)
      local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
      local head = vim.fn.fnamemodify(buf.path, ':p:h:t')
      local path = vim.fn.fnamemodify(buf.path, ':~')

      print(path) -- show full path in status line

      if head == cwd or head == '.' then
        return buf.name
      else
        return string.format('%s/%s', head, buf.name)
      end
    end,
    -- name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
    --   -- remove extension from markdown files for example
    --   if buf.name:match('%.md') then
    --     return vim.fn.fnamemodify(buf.name, ':t:r')
    --   end
    -- end,

    max_name_length = 30,
    -- max_prefix_length = 30,
    -- tab_size = 20,

    diagnostics = 'nvim_lsp',
    diagnostics_update_in_insert = true,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      -- return " " .. icon .. count
      return icon .. count
    end,

    -- persist_buffer_sort = false,
    -- enforce_regular_tabs = true,
    -- always_show_bufferline = true,
    sort_by = 'tabs',

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
  }
}

