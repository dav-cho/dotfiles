local function prequire(theme)
  local prefix = 'themes.lualine.'
  local ok, theme = pcall(require, prefix .. theme)
  if not ok then
    vim.notify('~ Lualine Theme "' .. theme .. '" Call Error!')
    return
  end
end

-- Themes --
prequire('evil_lualine')
--prequire('bubbles')
--prequire('slanted-gaps')


-- TODO: My Config --
--local ok, lualine = pcall(require, 'lualine')
--if not ok then
--  vim.notify('~ lualine Call Error!')
--  return
--end

--lualine.setup {
--  options = {
--    icons_enabled = true,
--    theme = 'auto',
--    component_separators = { left = '', right = ''},
--    section_separators = { left = '', right = ''},
--    disabled_filetypes = {},
--    always_divide_middle = true,
--  },
--  sections = {
--    lualine_a = {'mode'},
--    lualine_b = {'branch', 'diff', 'diagnostics'},
--    lualine_c = {'filename'},
--    lualine_x = {'encoding', 'fileformat', 'filetype'},
--    lualine_y = {'progress'},
--    lualine_z = {'location'}
--  },
--  inactive_sections = {
--    lualine_a = {},
--    lualine_b = {},
--    lualine_c = {'filename'},
--    lualine_x = {'location'},
--    lualine_y = {},
--    lualine_z = {}
--  },
--  tabline = {},
--  extensions = {}
--}


-- Default Config --
--lualine.setup {
--  options = {
--    icons_enabled = true,
--    theme = 'auto',
--    component_separators = { left = '', right = ''},
--    section_separators = { left = '', right = ''},
--    disabled_filetypes = {},
--    always_divide_middle = true,
--  },
--  sections = {
--    lualine_a = {'mode'},
--    lualine_b = {'branch', 'diff', 'diagnostics'},
--    lualine_c = {'filename'},
--    lualine_x = {'encoding', 'fileformat', 'filetype'},
--    lualine_y = {'progress'},
--    lualine_z = {'location'}
--  },
--  inactive_sections = {
--    lualine_a = {},
--    lualine_b = {},
--    lualine_c = {'filename'},
--    lualine_x = {'location'},
--    lualine_y = {},
--    lualine_z = {}
--  },
--  tabline = {},
--  extensions = {}
--}

