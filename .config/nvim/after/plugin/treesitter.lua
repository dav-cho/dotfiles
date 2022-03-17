local function prequire(module)
  local ok, lib = pcall(require, module)
  if ok then return lib end

  vim.notify('~ ' .. module ' Call Error!')
end

--local prequire = require 'utils.prequire'
local configs = require 'nvim-treesitter.configs'

configs.setup {
  -- One of 'all', 'maintained' (parsers with maintainers), or a list of languages
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

