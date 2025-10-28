local set_lualine_theme = function(theme)
  require("lualine").setup({ options = { theme = theme } })
end

local illuminate_default = function()
  vim.cmd([[hi IlluminatedWordText guibg=#434c5e guifg=none gui=none]])
  vim.cmd([[hi IlluminatedWordRead guibg=#434c5e guifg=none gui=none]])
  vim.cmd([[hi IlluminatedWordWrite guibg=#434c5e guifg=none gui=none]])
end

return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    opts = function(_, opts)
      local colors = {
        -- grays
        bg = "#121212",
        cursor_line = "#1d1d1d",
        cursor_line_bright = "#333333",
        ts_context = "#222222",
        win_separator = "#404040",
        line_nr = "#595959",
        float_border = "#777777",
        comment = "#808080",
        cursor_line_nr = "#a6a6a6",
        text = "#e0e0e0", -- 88%
        -- colors
        diagnostic_virtual_text_error = "#964a5f",
        diagnostic_virtual_text_hint = "#7d6c91",
        diagnostic_virtual_text_info = "#69878c",
        diagnostic_virtual_text_warn = "#ad8957",
        emerald = "#36c692",
        orange = "#eb9d65",
        pine_light = "#60b2c7",
        yellow = "#d9c18c",
      }

      return vim.tbl_deep_extend("force", opts, {
        variant = "main",
        dark_variant = "main",
        dim_inactive_windows = false,
        extend_background_behind_borders = false,
        styles = { italic = false },
        highlight_groups = {
          BufferlineTab = { fg = colors.comment, bg = colors.bg },
          BufferlineTabSelected = { fg = "iris", bg = colors.bg },
          BufferLineFill = { bg = colors.bg },
          ColorColumn = { bg = colors.cursor_line },
          Comment = { fg = colors.comment },
          Constant = { fg = colors.pine_light },
          CurSearch = { fg = "base", bg = "love", inherit = false, blend = 85 },
          CursorLine = { bg = colors.cursor_line },
          CursorLineNr = { fg = colors.cursor_line_nr },
          DiagnosticVirtualTextError = { fg = colors.diagnostic_virtual_text_error, bg = "none" },
          DiagnosticVirtualTextHint = { fg = colors.diagnostic_virtual_text_hint, bg = "none" },
          DiagnosticVirtualTextInfo = { fg = colors.diagnostic_virtual_text_info, bg = "none" },
          DiagnosticVirtualTextWarn = { fg = colors.diagnostic_virtual_text_warn, bg = "none" },
          FlashLabel = { bg = "iris" },
          FloatBorder = { fg = colors.float_border },
          Folded = { link = "Comment" },
          IlluminatedWordRead = { bg = colors.cursor_line_bright },
          IlluminatedWordText = { bg = colors.cursor_line_bright },
          IlluminatedWordWrite = { bg = colors.cursor_line_bright },
          Include = { fg = "iris" },
          LineNr = { fg = colors.line_nr },
          LspSignatureActiveParameter = { link = "LspReferenceRead" },
          MatchParen = { link = "Cursor", reverse = true },
          Normal = { fg = colors.text, bg = colors.bg },
          NormalFloat = { bg = "none" },
          NormalNC = { link = "Normal" },
          Number = { fg = colors.orange },
          Operator = { fg = colors.comment },
          Pmenu = { bg = "NormalFloat" },
          Search = { fg = "base", bg = "rose", blend = 85 },
          String = { fg = colors.yellow },
          TelescopeBorder = { link = "FloatBorder" },
          TelescopeSelection = { bg = colors.cursor_line_bright },
          Todo = { fg = "iris", bg = "none", blend = 0 },
          TreesitterContext = { bg = colors.ts_context },
          TreesitterContextLineNumber = { bg = colors.bg, fg = colors.cursor_line_nr },
          WinBar = { link = "Normal" },
          WinSeparator = { fg = colors.win_separator },
          ["@attribute"] = { fg = "iris" },
          ["@comment.todo"] = { link = "Todo" },
          ["@constant"] = { link = "Constant" },
          ["@constant.builtin"] = { fg = "love" },
          ["@function.builtin"] = { fg = "love" },
          ["@function.method.call"] = { link = "Function" },
          ["@keyword.operator"] = { link = "Keyword" },
          ["@punctuation"] = { link = "Operator" },
          ["@punctuation.special"] = { link = "@constant.builtin" },
          ["@text"] = { fg = colors.text },
          ["@text.diff.add"] = { fg = colors.emerald },
          ["@text.diff.delete"] = { fg = "love" },
          ["@type.builtin"] = { fg = colors.pine_light },
          ["@variable"] = { fg = colors.text },
          ["@variable.builtin"] = { fg = "love" },
          ["@variable.member"] = { fg = "foam" },
          ["@variable.parameter"] = { fg = "iris" },
        },
      })
    end,
    config = function(_, opts)
      require("rose-pine").setup(opts)
      vim.cmd("colorscheme rose-pine")
      set_lualine_theme("rose-pine")

      local lualine_theme = require("lualine.themes.rose-pine")
      local colors = {
        light = "#444444",
        dark = "#303030",
        text = "#e0e0e0",
      }

      lualine_theme = vim.tbl_deep_extend("force", lualine_theme, {
        normal = {
          b = { bg = colors.light, gui = "none" },
          c = { bg = colors.dark, fg = colors.text },
        },
        insert = {
          b = { bg = colors.light },
          c = { bg = colors.dark },
        },
        visual = {
          b = { bg = colors.light },
          c = { bg = colors.dark },
        },
        replace = {
          b = { bg = colors.light },
          c = { bg = colors.dark },
        },
        command = {
          b = { bg = colors.light },
          c = { bg = colors.dark },
        },
        inactive = {
          b = { bg = colors.light },
          c = { bg = colors.dark },
        },
      })
      set_lualine_theme(lualine_theme)
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "moon", -- storm, moon, night, day
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
      },
      on_highlights = function(hl, colors)
        hl.WinSeparator = { fg = colors.fg_gutter }
        hl.Todo = { fg = colors.magenta2 }
        hl.Folded = { link = "Comment" }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd("colorscheme tokyonight")
      set_lualine_theme("tokyonight")
    end,
  },
  {
    "rmehri01/onenord.nvim",
    lazy = true,
    opts = function()
      local colors = require("onenord.colors").load()
      return {
        theme = "dark",
        custom_highlights = {
          CursorLineNr = { fg = "#EBCB8B" },
          Normal = { bg = "#2B303B" },
          NormalNC = { bg = "#2B303B" },
          Search = { bg = colors.fg, fg = colors.bg },
          Visual = { bg = colors.selection, fg = colors.none },
          BufferlineTabSelected = { fg = colors.light_purple },
          IlluminatedWordText = { style = "None", bg = colors.highlight_dark, sp = colors.yellow },
          IlluminatedWordRead = { style = "None", bg = colors.highlight_dark, sp = colors.yellow },
          IlluminatedWordWrite = { style = "None", bg = colors.highlight_dark, sp = colors.yellow },
        },
      }
    end,
    config = function(_, opts)
      require("onenord").setup(opts)
      set_lualine_theme("onenord")
    end,
  },
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = true,
    config = function()
      vim.g.moonflyItalics = false
      vim.g.moonflyWinSeparator = 2
      vim.cmd("colorscheme moonfly")

      vim.cmd("hi ColorColumn guibg=#212121")
      vim.cmd("hi CursorLine guibg=#141414")
      vim.cmd("hi FloatBorder guifg=#4d4d4d guibg=none")
      vim.cmd("hi IlluminatedWordRead guibg=#242933 guifg=none gui=none")
      vim.cmd("hi IlluminatedWordText guibg=#242933 guifg=none gui=none")
      vim.cmd("hi IlluminatedWordWrite guibg=#242933 guifg=none gui=none")
      vim.cmd("hi NormalFloat guibg=none guifg=none gui=none")
      vim.cmd("hi Search guifg=#282c34 guibg=#ebd09c")
      vim.cmd("hi TelescopeBorder guifg=#4d4d4d")
      vim.cmd("hi TelescopeNormal guibg=#0d0d0d")
      vim.cmd("hi TelescopeSelection guibg=#262626")
      vim.cmd("hi link @constant.builtin MoonflyCranberry")
      vim.cmd("hi link @variable.builtin @parameter")
      vim.cmd("hi link Boolean MoonflyOrange")
      vim.cmd("hi link Operator MoonflyWhite")
      vim.cmd("hi! link DiffAdd MoonflyLime")
      vim.cmd("hi! link DiffChange MoonflyTurquoise")
      vim.cmd("hi! link DiffDelete MoonflyCranberry")
      vim.cmd("hi! link Todo MoonflyRedAlert")

      set_lualine_theme("moonfly")
    end,
  },
  {
    "navarasu/onedark.nvim",
    lazy = true,
    opts = function(_, opts)
      require("onedark").load()
      local colors = require("onedark.colors")
      return vim.tbl_deep_extend("force", opts, {
        style = "darker", -- dark, darker, cool, deep, warm, warmer
        code_style = {
          comments = "none",
        },
        diagnostics = {
          darker = true, -- darker colors for diagnostic
          undercurl = true, -- use undercurl instead of underline for diagnostics
          background = true, -- use background color for virtual text
        },
        colors = {
          bg4 = "#4e525d",
          bg5 = "#62656f",
        },
        highlights = {
          IlluminatedWordText = { bg = colors.bg3 },
          IlluminatedWordRead = { bg = colors.bg3 },
          IlluminatedWordWrite = { bg = colors.bg3 },
        },
      })
    end,
    config = function(_, opts)
      local onedark = require("onedark")
      onedark.setup(opts)
      onedark.load()
      set_lualine_theme("onedark")
    end,
  },
  {
    "sainnhe/everforest",
    lazy = true,
    config = function()
      vim.g.everforest_background = "hard"
      vim.g.everforest_enable_italic = 0
      vim.g.everforest_disable_italic_comment = 1
      vim.cmd("colorscheme everforest")
      require("lualine").setup({ options = { theme = "everforest" } })
    end,
  },
  {
    -- *After changes, run `:CatppuccinCompile`
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = function(_, opts)
      local ucolors = require("catppuccin.utils.colors")
      local colors = require("catppuccin.palettes").get_palette()

      return vim.tbl_deep_extend("force", opts, {
        compile = {
          enabled = true,
          path = vim.fn.stdpath("cache") .. "/catppuccin",
        },
        styles = {
          comments = {},
          conditionals = {},
        },
        integrations = {
          dap = {
            enabled = true,
            enable_ui = true,
          },
          symbols_outline = true,
        },
        custom_highlights = {
          Comment = { fg = ucolors.brighten(colors.surface2, 0.2) },
          IlluminatedWordText = { bg = colors.surface0, style = {} },
          IlluminatedWordWrite = { bg = colors.surface0, style = {} },
          IlluminatedWordRead = { bg = colors.surface0, style = {} },
          Todo = { fg = colors.yellow, bg = "" },
          Visual = { bg = ucolors.blend(ucolors.darken(colors.sky, 0.5, colors.base), colors.base, 0.6) },
          WinSeparator = { fg = colors.overlay0 },
          ["@parameter"] = { style = {} },
          ["@text.todo"] = { fg = colors.yellow, bg = "" },
        },
        statusline = {
          options = {
            theme = "palenight",
          },
        },
      })
    end,
    config = function(_, opts)
      vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
      require("catppuccin").setup(opts)
      vim.cmd("colorscheme catppuccin")
      set_lualine_theme("catppuccin")
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {
      compile = false,
      undercurl = false,
      commentStyle = { italic = false },
      functionStyle = {},
      keywordStyle = { italic = false },
      statementStyle = { bold = false },
      typeStyle = { italic = false },
      transparent = false,
      dimInactive = false,
      terminalColors = true,
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      overrides = function(colors) -- add/modify highlights
        local palette = colors.palette
        local theme = colors.theme
        return {
          BufferLineTabSelected = { fg = palette.sakuraPink },
          Cursorline = { bg = theme.ui.bg_p1 },
          DiagnosticError = { fg = palette.lotusRed },
          DiagnosticSignError = { fg = palette.lotusRed },
          DiagnosticSignWarn = { fg = palette.autumnYellow },
          DiagnosticVirtualTextError = { fg = palette.dragonRed },
          DiagnosticVirtualTextWarn = { fg = palette.boatYellow1 },
          DiagnosticWarn = { fg = palette.autumnYellow },
          IlluminatedWordRead = { bg = theme.ui.bg_p2 },
          IlluminatedWordText = { bg = theme.ui.bg_p2 },
          IlluminatedWordWrite = { bg = theme.ui.bg_p2 },
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
          Todo = { fg = palette.sakuraPink, bg = "none" },
          WinSeparator = { fg = theme.ui.bg_p2 },
          ["@variable.builtin"] = { italic = false },
        }
      end,
      theme = "wave", -- Load "wave" theme when 'background' option is not set
      background = { -- map the value of 'background' option to a theme
        dark = "wave", -- try "dragon" !
        light = "lotus",
      },
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd("colorscheme kanagawa")
    end,
  },
  {
    "tomasiser/vim-code-dark",
    lazy = true,
    config = function()
      vim.cmd("colorscheme codedark")
      vim.cmd("hi Todo guifg=#d16d9e guibg=None")
      vim.cmd("hi TSConstant guifg=#4fc1ff")
      illuminate_default()
      set_lualine_theme("codedark")
    end,
  },
  {
    "lunarvim/darkplus.nvim",
    lazy = true,
    config = function()
      local set_highlights = function(config)
        for group, properties in pairs(config) do
          local fg = properties.fg == nil and "" or "guifg=" .. properties.fg
          local bg = properties.bg == nil and "" or "guibg=" .. properties.bg
          local style = properties.style == nil and "" or "gui=" .. properties.style
          vim.cmd(table.concat({ "highlight", group, fg, bg, style }, " "))
        end
      end

      local highlight_overrides = {
        Comment = { fg = "#6A9955", style = "none" },
        CursorLine = { bg = "None" },
        CursorLineNr = { fg = "#FFB13B" },
        PmenuSel = { bg = "#053E61" },
        SignColumn = { bg = "None" },
        WinSeparator = { fg = "#888888", bg = "none" },
      }

      vim.g.transparent_background = true

      vim.cmd("colorscheme darkplus")

      set_highlights(highlight_overrides)
      vim.cmd([[highlight @text.todo guifg=#d16d9e]])
      vim.cmd([[highlight PmenuSel blend=0]])

      illuminate_default()
      set_lualine_theme("base16")
    end,
  },
  {
    "marko-cerovac/material.nvim",
    lazy = true,
    config = function()
      local material = require("material")
      local colors = require("material.colors")
      vim.g.material_style = "darker"
      material.setup({
        plugins = {
          "dap",
          "gitsigns",
          "indent-blankline",
          "nvim-cmp",
          "telescope",
          "trouble",
        },
        custom_highlights = {
          PmenuSel = { fg = colors.editor.contrast, bg = colors.purple },
          IlluminatedWordText = { bg = colors.editor.active },
          IlluminatedWordRead = { bg = colors.editor.active },
          IlluminatedWordWrite = { bg = colors.editor.active },
        },
      })
      vim.cmd("colorscheme material")
    end,
  },
}
