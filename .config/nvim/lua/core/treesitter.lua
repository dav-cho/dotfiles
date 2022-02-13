----------------------------- treesitter -----------------------------

require'nvim-treesitter.configs'.setup {
  --ensure_installed = 'maintained', 
  ensure_installed = {
    'lua',
    'javascript',
    'typescript',
    'tsx',
    'python',
    'java',
    'c',
    'go',
    'graphql',
    'html',
    'css',
    'scss',
    'json',
    'regex',
    'comment',
    'latex'
  }, 
  highlight = {
    enable = true           -- false will disable the whole extension
  },
  --textobjects = { enable = true }
}

----------------------------------------------------------------------

