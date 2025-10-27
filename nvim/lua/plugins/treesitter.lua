return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", lazy = true },
    },
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    ft = { "diff" },
    opts = {
      ensure_installed = {
        "comment",
        "css",
        "dockerfile",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "rust",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
      auto_install = true,
      highlight = {
        enable = true,
        ---@diagnostic disable-next-line: unused-local
        disable = function(lang, buf)
          local max_filesize = 1024 ^ 2 * 2 -- 2 MiB
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        -- ---@diagnostic disable-next-line: unused-local
        -- disable = function(lang, buf)
        --   local max_lines = 10000
        --   local ok, count = pcall(vim.api.nvim_buf_line_count, buf)
        --   if ok and count and count > max_lines then
        --     return true
        --   end
        -- end,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<M-v>",
          node_incremental = "<M-v>",
          node_decremental = "<M-V>",
          scope_incremental = false,
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["ag"] = "@class.outer",
            ["ig"] = "@class.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["a;"] = "@conditional.outer",
            ["i;"] = "@conditional.inner",
            ["a/"] = "@comment.*",
          },
          selection_modes = function(opts)
            if opts.query_string:match("@parameter.*") then
              return "v"
            end
            return "V"
          end,
        },
        move = {
          enable = true,
          goto_next_start = {
            ["]g"] = "@class.outer",
            ["]f"] = "@function.outer",
            ["]a"] = "@parameter.inner",
            ["]l"] = "@loop.outer",
            ["];"] = "@conditional.outer",
            ["]/"] = "@comment.*",
          },
          goto_next_end = {
            ["]G"] = "@class.outer",
            ["]F"] = "@function.outer",
            ["]A"] = "@parameter.outer",
            ["]L"] = "@loop.outer",
            ["]:"] = "@conditional.outer",
            ["]?"] = "@comment.*",
          },
          goto_previous_start = {
            ["[g"] = "@class.outer",
            ["[f"] = "@function.outer",
            ["[a"] = "@parameter.inner",
            ["[l"] = "@loop.outer",
            ["[;"] = "@conditional.outer",
            ["[/"] = "@comment.*",
          },
          goto_previous_end = {
            ["[G"] = "@class.outer",
            ["[F"] = "@function.outer",
            ["[A"] = "@parameter.outer",
            ["[L"] = "@loop.outer",
            ["[:"] = "@conditional.outer",
            ["[?"] = "@comment.*",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<M-CR><M-g>"] = "@class.outer",
            ["<M-CR><M-f>"] = "@function.outer",
            ["<M-CR><M-CR>"] = "@parameter.inner",
            ["<M-CR><M-l>"] = "@loop.outer",
            ["<M-CR><M-;>"] = "@conditional.outer",
          },
          swap_previous = {
            ["<M-BS><M-g>"] = "@class.outer",
            ["<M-BS><M-f>"] = "@function.outer",
            ["<M-BS><M-BS>"] = "@parameter.inner",
            ["<M-BS><M-l>"] = "@loop.outer",
            ["<M-BS><M-;>"] = "@conditional.outer",
          },
        },
      },
    },
    config = function(_, opts)
      local repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

      vim.keymap.set({ "n", "x", "o" }, ";", repeat_move.repeat_last_move_next)
      vim.keymap.set({ "n", "x", "o" }, "<BSlash>", repeat_move.repeat_last_move_previous)
      vim.keymap.set({ "n", "x", "o" }, "<M-,>", repeat_move.repeat_last_move_previous)
      vim.keymap.set({ "n", "x", "o" }, "f", repeat_move.builtin_f_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "F", repeat_move.builtin_F_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "t", repeat_move.builtin_t_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "T", repeat_move.builtin_T_expr, { expr = true })

      vim.keymap.set({ "n", "x", "o" }, "<M-;>", function()
        repeat_move.repeat_last_move_next()
        vim.defer_fn(function()
          vim.cmd("normal! zz")
        end, 10)
      end, { desc = "repeat_last_move_next() + redraw center" })
      vim.keymap.set({ "n", "x", "o" }, "<M-Bslash>", function()
        repeat_move.repeat_last_move_previous()
        vim.defer_fn(function()
          vim.cmd("normal! zz")
        end, 10)
      end, { desc = "repeat_last_move_previous() + redraw center" })

      vim.keymap.set({ "n", "x", "o" }, "<M-:>", function()
        repeat_move.repeat_last_move_next()
        vim.defer_fn(function()
          vim.cmd("normal! zt")
        end, 10)
      end, { desc = "repeat_last_move_next() + redraw top" })
      vim.keymap.set({ "n", "x", "o" }, "<M-|>", function()
        repeat_move.repeat_last_move_previous()
        vim.defer_fn(function()
          vim.cmd("normal! zt")
        end, 10)
      end, { desc = "repeat_last_move_previous() + redraw top" })

      local function map_repeat_moves(modes, next, prev, options)
        local next_move, prev_move = repeat_move.make_repeatable_move_pair(function()
          vim.cmd.normal({ next.cmd, bang = true })
        end, function()
          vim.cmd.normal({ prev.cmd, bang = true })
        end)
        vim.keymap.set(modes, next.cmd, next_move, vim.tbl_deep_extend("force", { desc = next.desc }, options or {}))
        vim.keymap.set(modes, prev.cmd, prev_move, vim.tbl_deep_extend("force", { desc = prev.desc }, options or {}))
      end

      map_repeat_moves(
        { "n", "x", "o" },
        { cmd = "zj", desc = "Down next fold" },
        { cmd = "zk", desc = "Up next fold" },
        { silent = true }
      )
      map_repeat_moves(
        { "n", "x", "o" },
        { cmd = "]c", desc = "next change" },
        { cmd = "[c", desc = "previous change" }
      )
      map_repeat_moves(
        { "n", "x", "o" },
        { cmd = "]m", desc = "next method" },
        { cmd = "[m", desc = "previous method" },
        { silent = true }
      )
      map_repeat_moves(
        { "n", "x", "o" },
        { cmd = "]`", desc = "next lowercase mark" },
        { cmd = "[`", desc = "previous lowercase mark" },
        { silent = true }
      )

      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "nvim-treesitter/playground",
    keys = {
      { "<Leader>TS", "<Cmd>TSPlaygroundToggle<CR>", silent = true, desc = "[TSPlayground] Toggle" },
    },
    opts = {
      playground = {
        enable = true,
        disable = {},
        updatetime = 25,
        persist_queries = false,
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<CR>",
          show_help = "?",
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    event = "VeryLazy",
    keys = {
      {
        "io", -- additional: iS
        "<Cmd>lua require('various-textobjs').subword('inner')<CR>",
        mode = { "o", "x" },
        desc = "[various-textobjs] subword('inner')",
      },
      {
        "ao", -- additional: aS
        "<Cmd>lua require('various-textobjs').subword('outer')<CR>",
        mode = { "o", "x" },
        desc = "[various-textobjs] subword('outer')",
      },
      {
        "i<M-i>", -- override: ig
        "<Cmd>lua require('various-textobjs').greedyOuterIndentation('inner')<CR>",
        mode = { "o", "x" },
        desc = "[various-textobjs] greedyOuterIndentation('inner')",
      },
      {
        "a<M-i>", -- override: ag
        "<Cmd>lua require('various-textobjs').greedyOuterIndentation('outer')<CR>",
        mode = { "o", "x" },
        desc = "[various-textobjs] greedyOuterIndentation('outer')",
      },
      {
        "i<M-b>", -- override: io
        "<Cmd>lua require('various-textobjs').anyBracket('inner')<CR>",
        mode = { "o", "x" },
        desc = "[various-textobjs] anyBracket('inner')",
      },
      {
        "a<M-b>", -- override: ao
        "<Cmd>lua require('various-textobjs').anyBracket('outer')<CR>",
        mode = { "o", "x" },
        desc = "[various-textobjs] anyBracket('outer')",
      },
      {
        "<M-]>", -- override: r
        "<Cmd>lua require('various-textobjs').restOfParagraph()<CR>",
        mode = { "o", "x" },
        desc = "[various-textobjs] restOfParagraph()",
      },
      {
        "g-", -- override: n
        "<Cmd>lua require('various-textobjs').nearEoL()<CR>",
        mode = { "o", "x" },
        desc = "[various-textobjs] nearEoL()",
      },
      {
        "i|", -- override: |
        "<Cmd>lua require('various-textobjs').column()<CR>",
        mode = { "o", "x" },
        desc = "[various-textobjs] column()",
      },
      {
        "iu", -- override: L
        "<Cmd>lua require('various-textobjs').url()<CR>",
        mode = { "o", "x" },
        desc = "[various-textobjs] url()",
      },
      {
        "id", -- override: !
        "<Cmd>lua require('various-textobjs').diagnostic()<CR>",
        mode = { "o", "x" },
        desc = "[various-textobjs] diagnostic()",
      },
      {
        "gW", -- override: gw
        "<Cmd>lua require('various-textobjs').visibleInWindow()<CR>",
        mode = { "o", "x" },
        desc = "[various-textobjs] visibleInWindow()",
      },
      {
        "gx",
        function()
          require("various-textobjs").url()
          if vim.fn.mode():find("v") then
            local unnamed = [["]]
            local orig = vim.fn.getreg(unnamed)
            local orig_type = vim.fn.getregtype(unnamed)
            vim.cmd.normal({ "y", bang = true })
            vim.ui.open(vim.fn.getreg(unnamed))
            for _, reg in ipairs({ unnamed, "+", "*" }) do
              vim.fn.setreg(reg, orig, orig_type)
            end
          end
        end,
        desc = "[various-textobjs] URL Opener",
      },
      {
        ">P",
        function()
          require("various-textobjs").lastChange()
          if vim.fn.mode():find("v") then
            vim.cmd.normal({ ">", bang = true })
          end
        end,
        desc = "[various-textobjs] indent last put",
      },
      {
        "<lt>P",
        function()
          require("various-textobjs").lastChange()
          if vim.fn.mode():find("v") then
            vim.cmd.normal({ "<", bang = true })
          end
        end,
        desc = "[various-textobjs] dedent last put",
      },
    },
    opts = {
      keymaps = {
        useDefaults = true,
        disabledDefaults = {
          "ig",
          "ag",
          "C",
          "Q",
          "io",
          "ao",
          "r",
          "n",
          "|",
          "L",
          "!",
          "gw",
          "gW",
          "i,",
          "a,",
        },
      },
    },
  },
  {
    "folke/flash.nvim",
    keys = {
      {
        "<Space>/",
        function()
          require("flash").jump()
        end,
        mode = { "n", "x", "o" },
        desc = "[Flash] Jump (fuzzy)",
      },
      {
        "<Leader>/",
        function()
          require("flash").jump({ search = { mode = "exact" } })
        end,
        mode = { "n", "x", "o" },
        desc = "[Flash] Jump (exact)",
      },
      {
        "<M-/>",
        function()
          require("flash").jump({ continue = true })
        end,
        desc = "[Flash] Jump (fuzzy)",
      },
      {
        "<Leader>?",
        function()
          require("flash").treesitter()
        end,
        mode = { "n", "x", "o" },
        desc = "[Flash] Treesitter",
      },
      {
        "r",
        function()
          require("flash").remote()
        end,
        mode = { "o" },
        desc = "[Flash] Remote",
      },
      {
        "<M-r>",
        function()
          require("flash").treesitter_search()
        end,
        mode = { "o", "x" },
        desc = "[Flash] Treesitter Search",
      },
      {
        "<C-g>/",
        function()
          require("flash").toggle()
        end,
        mode = { "c" },
        desc = "[Flash] Toggle Search",
      },
      {
        "gL",
        function()
          require("flash").jump({
            search = { mode = "search", max_length = 0 },
            label = { after = { 0, 0 }, min_pattern_length = 0 },
            pattern = "^",
            action = function(match, state)
              vim.api.nvim_win_call(match.win, function()
                vim.api.nvim_win_set_cursor(match.win, match.pos)
                vim.diagnostic.open_float()
              end)
              state:restore()
            end,
            labels = "abcdefghijklmnopqrstuvwxyz1234567890",
          })
        end,
        desc = "[Flash] show diagnostics at target line",
      },
    },
    opts = {
      search = {
        mode = "fuzzy",
      },
      label = {
        min_pattern_length = 2,
      },
      highlight = {
        backdrop = false,
      },
      modes = {
        char = {
          enabled = false,
          highlight = { backdrop = false },
        },
      },
      prompt = {
        win_config = {
          row = -3,
        },
      },
      remote_op = {
        restore = true,
      },
    },
  },
}
