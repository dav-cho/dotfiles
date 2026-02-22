return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", lazy = true },
      "nvim-treesitter/nvim-treesitter-context",
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
        "sql",
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

      -- TODO:
      -- - `-` is repeat prev 
      -- - `BS` becomes tab prev 
      -- - `BSlash` becomes `Tab` (newer jump list)

      vim.keymap.set({ "n", "x", "o" }, ";", repeat_move.repeat_last_move_next)
      vim.keymap.set({ "n", "x", "o" }, "<BSlash>", repeat_move.repeat_last_move_previous)
      vim.keymap.set({ "n", "x", "o" }, "-", repeat_move.repeat_last_move_previous) -- TODO
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

  -- -- WIP: main branch
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   branch = "main",
  --   build = ":TSUpdate",
  --   event = { "BufReadPre", "BufNewFile" },
  --   opts = {
  --     ensure_installed = {
  --       "comment",
  --       -- "css",
  --       "dockerfile",
  --       "go",
  --       "html",
  --       "javascript",
  --       "json",
  --       "lua",
  --       "markdown",
  --       "markdown_inline",
  --       "python",
  --       "rust",
  --       "tsx",
  --       "typescript",
  --       "vim",
  --       "yaml",
  --     },
  --     parser_filetypes = {
  --       javascript = { "javascriptreact", "ecma", "ecmascript", "jsx", "js" },
  --       -- python = { "py", "gyp" },
  --       ssh_config = { "sshconfig" },
  --       terraform = { "terraform-vars" },
  --       tsx = { "typescriptreact", "typescript.tsx" },
  --       typescript = { "ts" },
  --       xml = { "xsd", "xslt", "svg" },
  --     },
  --     highlights = {
  --       disable = function(buf)
  --         local max_filesize = 1024 ^ 2 * 2 -- 2 MiB
  --         local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
  --         if ok and stats and stats.size > max_filesize then
  --           return true
  --         end
  --       end,
  --       -- disable = function()
  --       --   local max_lines = 10000
  --       --   local ok, count = pcall(vim.api.nvim_buf_line_count, buf)
  --       --   if ok and count and count > max_lines then
  --       --     return true
  --       --   end
  --       -- end,
  --     },
  --   },
  --   config = function(_, opts)
  --     require("nvim-treesitter").install(opts.ensure_installed)
  --
  --     -- TODO: tmp
  --     vim.keymap.set("n", "<space><space>", function()
  --       local parsers = require("nvim-treesitter").get_installed("parsers")
  --       print(vim.inspect(parsers))
  --     end)
  --
  --     -- local installed = require("nvim-treesitter").get_installed("parsers")
  --
  --     local function get_parser_filetypes()
  --       local filetypes = {}
  --       local installed = require("nvim-treesitter").get_installed("parsers")
  --       -- for _, parser in ipairs(require("nvim-treesitter").get_installed("parsers")) do
  --       for _, parser in ipairs(installed) do
  --         vim.list_extend(filetypes, opts.parser_filetypes[parser] or { parser })
  --       end
  --       return filetypes
  --     end
  --
  --     vim.api.nvim_create_autocmd("FileType", {
  --       pattern = get_parser_filetypes(),
  --       callback = function(ev)
  --         if not opts.highlights.disable(ev.buf) then
  --           vim.treesitter.start()
  --           -- pcall(vim.treesitter.start)
  --
  --           vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  --         end
  --
  --         -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  --       end,
  --     })
  --   end,
  -- },
  -- {
  --   "nvim-treesitter/nvim-treesitter-textobjects",
  --   branch = "main",
  --   event = { "BufReadPre", "BufNewFile" },
  --   opts = {
  --     move = {
  --       set_jumps = true,
  --     },
  --     select = {
  --       lookahead = true,
  --       selection_modes = function(opts)
  --         if opts.query_string:match("@parameter.*") then
  --           return "v"
  --         end
  --         return "V"
  --       end,
  --     },
  --   },
  --   config = function(_, opts)
  --     require("nvim-treesitter-textobjects").setup(opts)
  --
  --     local keymaps = {
  --       goto_next_start = {
  --         ["]g"] = "@class.outer",
  --         ["]f"] = "@function.outer",
  --         ["]a"] = "@parameter.inner",
  --         ["]l"] = "@loop.outer",
  --         ["];"] = "@conditional.outer",
  --         -- ["]/"] = "@comment.*",
  --         ["]/"] = "@comment.outer",
  --       },
  --       goto_next_end = {
  --         ["]G"] = "@class.outer",
  --         ["]F"] = "@function.outer",
  --         ["]A"] = "@parameter.outer",
  --         ["]L"] = "@loop.outer",
  --         ["]:"] = "@conditional.outer",
  --         -- ["]?"] = "@comment.*",
  --         ["]?"] = "@comment.outer",
  --       },
  --       goto_previous_start = {
  --         ["[g"] = "@class.outer",
  --         ["[f"] = "@function.outer",
  --         ["[a"] = "@parameter.inner",
  --         ["[l"] = "@loop.outer",
  --         ["[;"] = "@conditional.outer",
  --         -- ["[/"] = "@comment.*",
  --         ["[/"] = "@comment.outer",
  --       },
  --       goto_previous_end = {
  --         ["[G"] = "@class.outer",
  --         ["[F"] = "@function.outer",
  --         ["[A"] = "@parameter.outer",
  --         ["[L"] = "@loop.outer",
  --         ["[:"] = "@conditional.outer",
  --         -- ["[?"] = "@comment.*",
  --         ["[?"] = "@comment.outer",
  --       },
  --       select = {
  --         ["ag"] = "@class.outer",
  --         ["ig"] = "@class.inner",
  --         ["af"] = "@function.outer",
  --         ["if"] = "@function.inner",
  --         ["aa"] = "@parameter.outer",
  --         ["ia"] = "@parameter.inner",
  --         ["al"] = "@loop.outer",
  --         ["il"] = "@loop.inner",
  --         ["a;"] = "@conditional.outer",
  --         ["i;"] = "@conditional.inner",
  --         -- ["a/"] = "@comment.*",
  --         ["a/"] = "@comment.outer",
  --       },
  --       swap_next = {
  --         ["<M-CR><M-g>"] = "@class.outer",
  --         ["<M-CR><M-f>"] = "@function.outer",
  --         ["<M-CR><M-CR>"] = "@parameter.inner",
  --         ["<M-CR><M-l>"] = "@loop.outer",
  --         ["<M-CR><M-;>"] = "@conditional.outer",
  --       },
  --       swap_previous = {
  --         ["<M-BS><M-g>"] = "@class.outer",
  --         ["<M-BS><M-f>"] = "@function.outer",
  --         ["<M-BS><M-BS>"] = "@parameter.inner",
  --         ["<M-BS><M-l>"] = "@loop.outer",
  --         ["<M-BS><M-;>"] = "@conditional.outer",
  --       },
  --     }
  --
  --     ---@class MapOpts
  --     ---@field desc string?
  --     ---@field query_group string?
  --
  --     ---@param modes string|string[]
  --     ---@param func fun(query_strings: string|string[], query_group: string?)
  --     ---@param keys table<string, string>
  --     ---@param options table<string?, string?>
  --     ---@return nil
  --     local function map(modes, func, keys, options)
  --       for lhs, query_string in pairs(keys) do
  --         vim.keymap.set(modes, lhs, function()
  --           func(query_string, options.query_group or "textobjects")
  --         end, { desc = ("[textobjects]%s %s"):format(options.desc and " " .. options.desc or "", lhs) })
  --       end
  --     end
  --
  --     for map_group, map_keys in pairs(keymaps) do
  --       if string.match(map_group, "^goto") then
  --         local move = require("nvim-treesitter-textobjects.move")
  --         map({ "n", "x", "o" }, move[map_group], keymaps[map_group], { desc = map_group })
  --       elseif string.match(map_group, "^select") then
  --         local select_textobject = require("nvim-treesitter-textobjects.select").select_textobject
  --         map({ "x", "o" }, select_textobject, map_keys, { desc = map_group })
  --       elseif string.match(map_group, "^swap") then
  --         local swap = require("nvim-treesitter-textobjects.swap")
  --         map("n", swap[map_group], map_keys, { desc = map_group })
  --       end
  --     end
  --
  --     local repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
  --
  --     local function map_repeat_redraw(lhs, move_fn, cmd, desc)
  --       vim.keymap.set({ "n", "x", "o" }, lhs, function()
  --         move_fn()
  --         vim.defer_fn(function()
  --           vim.cmd("normal! " .. cmd)
  --         end, 10)
  --       end, { desc = desc })
  --     end
  --
  --     vim.keymap.set({ "n", "x", "o" }, ";", repeat_move.repeat_last_move_next)
  --     vim.keymap.set({ "n", "x", "o" }, ",", repeat_move.repeat_last_move_previous)
  --     -- vim.keymap.set({ "n", "x", "o" }, ";", repeat_move.repeat_last_move_next, { expr = true })
  --     -- vim.keymap.set({ "n", "x", "o" }, ",", repeat_move.repeat_last_move_previous, { expr = true })
  --     vim.keymap.set({ "n", "x", "o" }, "f", repeat_move.builtin_f_expr, { expr = true })
  --     vim.keymap.set({ "n", "x", "o" }, "F", repeat_move.builtin_F_expr, { expr = true })
  --     vim.keymap.set({ "n", "x", "o" }, "t", repeat_move.builtin_t_expr, { expr = true })
  --     vim.keymap.set({ "n", "x", "o" }, "T", repeat_move.builtin_T_expr, { expr = true })
  --
  --     map_repeat_redraw("<M-;>", repeat_move.repeat_last_move_next, "zz", "repeat_last_move_next() + redraw center")
  --     map_repeat_redraw(
  --       "<M-,>",
  --       repeat_move.repeat_last_move_previous,
  --       "zz",
  --       "repeat_last_move_previous() + redraw center"
  --     )
  --     map_repeat_redraw("<M-:>", repeat_move.repeat_last_move_next, "zt", "repeat_last_move_next() + redraw top")
  --     map_repeat_redraw(
  --       "<M-<>",
  --       repeat_move.repeat_last_move_previous,
  --       "zt",
  --       "repeat_last_move_previous() + redraw top"
  --     )
  --
  --     -- TODO: fix first ]`/[` move
  --     -- E5108: Error executing lua: vim/_editor.lua:0: nvim_exec2(), line 1: Vim(normal):E92: Buffer 0 not found
  --     -- stack traceback:
  --     --         [C]: in function 'nvim_exec2'
  --     --         vim/_editor.lua: in function 'cmd'
  --     --         /Users/dcho/.config/nvim/lua/plugins/treesitter.lua:183: in function 'forward_move_fn'
  --     --         ...ects/lua/nvim-treesitter/textobjects/repeatable_move.lua:79: in function <...ects/lua/nvim-treesitter/textobjects/repeatable_move.lua:77>
  --
  --     -- TODO: what is the replacement?
  --     local function map_repeat_moves(modes, next, prev, options)
  --       local next_move, prev_move = repeat_move.make_repeatable_move_pair(function()
  --         vim.cmd.normal({ next.cmd, bang = true })
  --       end, function()
  --         vim.cmd.normal({ prev.cmd, bang = true })
  --       end)
  --       vim.keymap.set(modes, next.cmd, next_move, vim.tbl_deep_extend("force", { desc = next.desc }, options or {}))
  --       vim.keymap.set(modes, prev.cmd, prev_move, vim.tbl_deep_extend("force", { desc = prev.desc }, options or {}))
  --     end
  --
  --     map_repeat_moves(
  --       { "n", "x", "o" },
  --       { cmd = "zj", desc = "Down next fold" },
  --       { cmd = "zk", desc = "Up next fold" },
  --       { silent = true }
  --     )
  --     map_repeat_moves(
  --       { "n", "x", "o" },
  --       { cmd = "]c", desc = "next change" },
  --       { cmd = "[c", desc = "previous change" }
  --     )
  --     map_repeat_moves(
  --       { "n", "x", "o" },
  --       { cmd = "]m", desc = "next method" },
  --       { cmd = "[m", desc = "previous method" },
  --       { silent = true }
  --     )
  --     map_repeat_moves(
  --       { "n", "x", "o" },
  --       { cmd = "]`", desc = "next lowercase mark" },
  --       { cmd = "[`", desc = "previous lowercase mark" },
  --       { silent = true }
  --     )
  --   end,
  -- },

  -- TODO: example
  -- -- This repeats the last query with always previous direction and to the start of the range.
  -- vim.keymap.set({ "n", "x", "o" }, "<home>", function()
  --   ts_repeat_move.repeat_last_move({ forward = false, start = true })
  -- end)
  --
  -- -- This repeats the last query with always next direction and to the end of the range.
  -- vim.keymap.set({ "n", "x", "o" }, "<end>", function()
  --   ts_repeat_move.repeat_last_move({ forward = true, start = false })
  -- end)

  -- for map_group in { "goto_next_start", "goto_next_end", "goto_previous_start", "goto_previous_end" } do
  --   map(
  --     { "n", "x", "o" },
  --     require("nvim-treesitter-textobjects.move")[map_group],
  --     keymaps[map_group],
  --     { desc = map_group }
  --   )
  -- end

  -- map(
  --   { "n", "x", "o" },
  --   require("nvim-treesitter-textobjects.move").goto_next_start,
  --   keys.goto_next_start,
  --   { desc = "Goto next start" }
  -- )

  -- for lhs, query_string in pairs(keymaps.goto_next_start) do
  --   vim.keymap.set({ "n", "x", "o" }, lhs, function()
  --     require("nvim-treesitter-textobjects.move").goto_next_start(query_string, "textobjects")
  --   end, { desc = "Goto next start " .. query_string })
  -- end
  --
  -- for lhs, query_string in pairs(keymaps.goto_next_end) do
  --   vim.keymap.set({ "n", "x", "o" }, lhs, function()
  --     require("nvim-treesitter-textobjects.move").goto_next_end(query_string, "textobjects")
  --   end, { desc = "Goto next end " .. query_string })
  -- end
  --
  -- for lhs, query_string in pairs(keymaps.goto_previous_start) do
  --   vim.keymap.set({ "n", "x", "o" }, lhs, function()
  --     require("nvim-treesitter-textobjects.move").goto_previous_start(query_string, "textobjects")
  --   end, { desc = "Goto previous end " .. query_string })
  -- end
  --
  -- for lhs, query_string in pairs(keymaps.goto_previous_end) do
  --   vim.keymap.set({ "n", "x", "o" }, lhs, function()
  --     require("nvim-treesitter-textobjects.move").goto_previous_end(query_string, "textobjects")
  --   end, { desc = "Goto previous end " .. query_string })
  -- end
  --
  -- for lhs, query_string in pairs(keymaps.select) do
  --   vim.keymap.set({ "x", "o" }, lhs, function()
  --     require("nvim-treesitter-textobjects.select").select_textobject(query_string, "textobjects")
  --   end, { desc = "Select textobject " .. query_string })
  -- end
  --
  -- for lhs, query_string in pairs(keymaps.swap_next) do
  --   vim.keymap.set("n", lhs, function()
  --     require("nvim-treesitter-textobjects.swap").swap_next(query_string, "textobjects")
  --   end, { desc = "Swap next " .. query_string })
  -- end
  --
  -- for lhs, query_string in pairs(keymaps.swap_previous) do
  --   vim.keymap.set("n", lhs, function()
  --     require("nvim-treesitter-textobjects.swap").swap_previous(query_string, "textobjects")
  --   end, { desc = "Swap previous " .. query_string })
  -- end

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
    "nvim-treesitter/nvim-treesitter-context",
    keys = {
      {
        "[x",
        function()
          require("treesitter-context").go_to_context(vim.v.count1)
        end,
        silent = true,
        desc = "[TSContext] [count] go to prev context",
      }
    },
    opts = {
      multiwindow = true,
      multiline_threshold = 1,
    },
    -- opts = {
    --   enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    --   multiwindow = false, -- Enable multiwindow support.
    --   max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    --   min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    --   line_numbers = true,
    --   multiline_threshold = 20, -- Maximum number of lines to show for a single context
    --   trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    --   mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
    --   -- Separator between context and content. Should be a single character string, like '-'.
    --   -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    --   separator = nil,
    --   zindex = 20, -- The Z-index of the context window
    --   on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    -- },
  },
  {
    "folke/flash.nvim",
    keys = {
      {
        "<Leader>/",
        function()
          require("flash").jump()
        end,
        mode = { "n", "x", "o" },
        desc = "[Flash] Jump (fuzzy)",
      },
      {
        "<Space>/",
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
