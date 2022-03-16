local prequire = require 'utils.prequire'
local configs = require 'nvim-treesitter.configs'

configs.setup {
  -- One of 'all', 'maintained' (parsers with maintainers), or a list of languages
  --ensure_installed = 'maintained',
  ensure_installed = {
    'javascript',
    'typescript',
    'tsx',
    'python',
    'go',
    'html',
    'css',
    'markdown',
  },

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  --ignore_install = { 'javascript' },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    --disable = { 'c', 'rust' },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- Sample --
--local status_ok, configs = pcall(require, "nvim-treesitter.configs")
--if not status_ok then
--	return
--end

--treesitter_configs.setup {
--  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
--  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
--  ignore_install = { "" }, -- List of parsers to ignore installing
--  highlight = {
--    -- use_languagetree = true,
--    enable = true, -- false will disable the whole extension
--    -- disable = { "css", "html" }, -- list of language that will be disabled
--    disable = { "css" }, -- list of language that will be disabled
--    additional_vim_regex_highlighting = true,
--  },
--  autopairs = {
--    enable = true,
--  },
--  indent = { enable = true, disable = { "yaml", "python", "css" } },
--  context_commentstring = {
--    enable = true,
--    enable_autocmd = false,
--  },
--  autotag = {
--    enable = true,
--    disable = { "xml" },
--  },
--  rainbow = {
--    enable = true,
--    colors = {
--      "Gold",
--      "Orchid",
--      "DodgerBlue",
--      -- "Cornsilk",
--      -- "Salmon",
--      -- "LawnGreen",
--    },
--    disable = { "html" },
--  },
--  playground = {
--    enable = true,
--  },
--}
