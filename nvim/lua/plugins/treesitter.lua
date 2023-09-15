return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
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
            ["ar"] = "@loop.outer",
            ["ir"] = "@loop.inner",
            ["av"] = "@conditional.outer",
            ["iv"] = "@conditonal.inner",
            ["aq"] = "@block.outer",
            ["iq"] = "@block.inner",
            ["ax"] = "@comment.outer",
          },
          selection_modes = {
            ["@class.outer"] = "V",
            ["@class.inner"] = "V",
            ["@function.outer"] = "V",
            ["@function.inner"] = "V",
            ["@loop.outer"] = "V",
            ["@loop.inner"] = "V",
            ["@conditional.outer"] = "V",
            ["@conditional.inner"] = "V",
            ["@block.outer"] = "V",
            ["@block.inner"] = "V",
            ["@comment.outer"] = "V",
          },
        },
        move = {
          enable = true,
          goto_next_start = {
            ["]g"] = "@class.outer",
            ["]f"] = "@function.outer",
            ["]a"] = "@parameter.inner",
            ["]r"] = "@loop.outer",
            ["]v"] = "@conditional.outer",
            ["]q"] = "@block.outer",
            ["]x"] = "@comment.outer",
          },
          goto_next_end = {
            ["]G"] = "@class.outer",
            ["]F"] = "@function.outer",
            ["]A"] = "@parameter.outer",
            ["]R"] = "@loop.outer",
            ["]V"] = "@conditional.outer",
            ["]Q"] = "@block.outer",
            ["]X"] = "@comment.outer",
          },
          goto_previous_start = {
            ["[g"] = "@class.outer",
            ["[f"] = "@function.outer",
            ["[a"] = "@parameter.inner",
            ["[r"] = "@loop.outer",
            ["[v"] = "@conditional.outer",
            ["[q"] = "@block.outer",
            ["[x"] = "@comment.outer",
          },
          goto_previous_end = {
            ["[G"] = "@class.outer",
            ["[F"] = "@function.outer",
            ["[A"] = "@parameter.outer",
            ["[R"] = "@loop.outer",
            ["[V"] = "@conditional.outer",
            ["[Q"] = "@block.outer",
            ["[X"] = "@comment.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<M-CR><M-g>"] = "@class.outer",
            ["<M-CR><M-f>"] = "@function.outer",
            ["<M-CR><M-CR>"] = "@parameter.inner",
            ["<M-CR><M-r>"] = "@loop.outer",
            ["<M-CR><M-v>"] = "@conditional.outer",
            ["<M-CR><M-q>"] = "@block.outer",
            ["<M-CR><M-x>"] = "@comment.outer",
            ["<M-CR><M-e>"] = "@element",
          },
          swap_previous = {
            ["<M-BS><M-g>"] = "@class.outer",
            ["<M-BS><M-f>"] = "@function.outer",
            ["<M-BS><M-BS>"] = "@parameter.inner",
            ["<M-BS><M-r>"] = "@loop.outer",
            ["<M-BS><M-v>"] = "@conditional.outer",
            ["<M-BS><M-q>"] = "@block.outer",
            ["<M-BS><M-x>"] = "@comment.outer",
            ["<M-BS><M-e>"] = "@element",
          },
        },
      },
    },
    config = function(_, opts)
      local repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

      vim.keymap.set({ "n", "x", "o" }, ";", repeat_move.repeat_last_move_next)
      vim.keymap.set({ "n", "x", "o" }, "<Bslash>", repeat_move.repeat_last_move_previous)
      vim.keymap.set({ "n", "x", "o" }, "f", repeat_move.builtin_f)
      vim.keymap.set({ "n", "x", "o" }, "F", repeat_move.builtin_F)
      vim.keymap.set({ "n", "x", "o" }, "t", repeat_move.builtin_t)
      vim.keymap.set({ "n", "x", "o" }, "T", repeat_move.builtin_T)

      local next_fold, prev_fold = repeat_move.make_repeatable_move_pair(
        function() vim.cmd("normal! zj") end,
        function() vim.cmd("normal! zk") end
      )
      vim.keymap.set({ "n", "x", "o" }, "zj", next_fold, { silent = true, desc = "Down next fold" })
      vim.keymap.set({ "n", "x", "o" }, "zk", prev_fold, { silent = true, desc = "Up next fold" })

      local next_diff, prev_diff = repeat_move.make_repeatable_move_pair(
        function() vim.cmd("normal! ]c") end,
        function() vim.cmd("normal! [c") end
      )
      vim.keymap.set("n", "]c", next_diff, { desc = "Jumpto next diff" })
      vim.keymap.set("n", "[c", prev_diff, { desc = "Jumpto next diff" })

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
      }
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
