if not pcall(require, "nvim-treesitter") then
  return
end

require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "go",
    "python",
    "rust",
    "typescript",
    "javascript",
    "tsx",
    "html",
    "css",
    "json",
    "yaml",
    -- "dockerfile", -- TODO
    "markdown",
  },

  -- sync_install = false, -- TODO: need?
  auto_install = true,

  highlight = {
    enable = true,
    -- additional_vim_regex_highlighting = false, -- TODO: need?
  },

  -- TODO
  -- incremental_selection = {
  --   enable = true,
  --   keymaps = {
  --     init_selection = "gnn",
  --     node_incremental = "grn",
  --     scope_incremental = "grc",
  --     node_decremental = "grm",
  --   },
  -- },

  -- TODO: Still an experimental feature. Does it work better without?
  -- indent = {
  --   enable = true,
  --   disable = { 'python' },
  -- },

  -- TODO: From old config...
  -- autopairs = {
  --   enable = true,
  -- },

  -- autotag = {
  --   enable = true,
  -- },

  -- rainbow = {
  --   enable = true,
  --   -- disable = { "jsx", "cpp" } -- list of languages you want to disable the plugin for
  --   extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
  --   max_file_lines = nil, -- Do not enable for files with more than n lines, int
  --   colors = { -- table of hex strings
  --     '#7fffd4',
  --     '#00fa9a',
  --     '#ffd700',
  --     "#ff69b4",
  --     '#ba55d3',
  --     '#ff6347',
  --     "#f5f5dc",
  --   },
  --   -- termcolors = {} -- table of colour name strings
  -- },
}
