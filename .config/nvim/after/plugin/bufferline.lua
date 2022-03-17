local ok, bufferline = pcall(require, 'bufferline')
if not ok then
  vim.notify('~ Bufferline Call Error!')
  return
end

-- Use default config --
--bufferline.setup()

-- My Config --
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


-- Config Options --
--bufferline.setup {
--  options = {
--    mode = "buffers", -- set to "tabs" to only show tabpages instead
--    numbers = "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
--    --- @deprecated, please specify numbers as a function to customize the styling
--    number_style = "superscript" | "subscript" | "" | { "none", "subscript" }, -- buffer_id at index 1, ordinal at index 2
--    close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
--    right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
--    left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
--    middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
--    -- NOTE: this plugin is designed with this icon in mind,
--    -- and so changing this is NOT recommended, this is intended
--    -- as an escape hatch for people who cannot bear it for whatever reason
--    indicator_icon = '▎',
--    buffer_close_icon = '',
--    modified_icon = '●',
--    close_icon = '',
--    left_trunc_marker = '',
--    right_trunc_marker = '',
--    --- name_formatter can be used to change the buffer's label in the bufferline.
--    --- Please note some names can/will break the
--    --- bufferline so use this at your discretion knowing that it has
--    --- some limitations that will *NOT* be fixed.
--    name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
--      -- remove extension from markdown files for example
--      if buf.name:match('%.md') then
--        return vim.fn.fnamemodify(buf.name, ':t:r')
--      end
--    end,
--    max_name_length = 18,
--    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
--    tab_size = 18,
--    diagnostics = false | "nvim_lsp" | "coc",
--    diagnostics_update_in_insert = false,
--    diagnostics_indicator = function(count, level, diagnostics_dict, context)
--      return "("..count..")"
--    end,
--    -- NOTE: this will be called a lot so don't do any heavy processing here
--    custom_filter = function(buf_number, buf_numbers)
--      -- filter out filetypes you don't want to see
--      if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
--        return true
--      end
--      -- filter out by buffer name
--      if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
--        return true
--      end
--      -- filter out based on arbitrary rules
--      -- e.g. filter out vim wiki buffer from tabline in your work repo
--      if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
--        return true
--      end
--      -- filter out by it's index number in list (don't show first buffer)
--      if buf_numbers[1] ~= buf_number then
--        return true
--      end
--    end,
--    offsets = {{filetype = "NvimTree", text = "File Explorer" | function , text_align = "left" | "center" | "right"}},
--    show_buffer_icons = true | false, -- disable filetype icons for buffers
--    show_buffer_close_icons = true | false,
--    show_close_icon = true | false,
--    show_tab_indicators = true | false,
--    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
--    -- can also be a table containing 2 custom separators
--    -- [focused and unfocused]. eg: { '|', '|' }
--    separator_style = "slant" | "thick" | "thin" | { 'any', 'any' },
--    enforce_regular_tabs = false | true,
--    always_show_bufferline = true | false,
--    sort_by = 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
--      -- add custom logic
--      return buffer_a.modified > buffer_b.modified
--    end
--  }
--}

