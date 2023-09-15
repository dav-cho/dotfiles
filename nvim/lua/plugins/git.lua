return {
  {
    "lewis6991/gitsigns.nvim",
    event = "LspAttach",
    opts = {
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 0,
        ignore_whitespace = true,
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local repeatable_move = require("nvim-treesitter.textobjects.repeatable_move")

        local map = function(mode, lhs, rhs, opts)
          opts = opts or {}
          opts.buffer = bufnr
          opts.silent = true
          opts.desc = "[Gitsigns] " .. (opts.desc or "")
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        local next_hunk_repeat, prev_hunk_repeat = repeatable_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)

        map("n", "]c", function()
          if vim.wo.diff then return "]c" end
          vim.schedule(next_hunk_repeat)
          return "<Ignore>"
        end, { expr = true, desc = "Next hunk" })
        map("n", "[c", function()
          if vim.wo.diff then return "[c" end
          vim.schedule(prev_hunk_repeat)
          return "<Ignore>"
        end, { expr = true, desc = "Prev hunk" })
        map("n", "<Space>s", gs.stage_hunk, { desc = "stage_hunk" })
        map("v", "<Space>s", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
          { desc = "stage_hunk" })
        map("n", "<Space>S", gs.stage_buffer, { desc = "stage_buffer" })
        map("n", "<Space>z", gs.reset_hunk, { desc = "reset_hunk" })
        map("v", "<Space>z", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
          { desc = "reset_hunk" })
        map("n", "<Space>Z", gs.reset_buffer, { desc = "reset_buffer" })
        map({ "n", "v" }, "<Space>u", gs.undo_stage_hunk, { desc = "undo_stage_hunk" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "preview_hunk" })
        map("n", "<leader>hq", gs.setqflist, { desc = "setqflist" })
        map("n", "<leader>hl", gs.setloclist, { desc = "setloclist" })
        map("n", "<leader>hb", function() gs.blame_line({ full = false }) end, { desc = "blame_line { full = false }" })
        map("n", "<leader>hB", function() gs.blame_line({ full = true }) end, { desc = "blame_line { full = true }" })
        map("n", "<leader>hd", gs.diffthis, { desc = "diffthis" })
        map("n", "<leader>hD", function() gs.diffthis("~") end, { desc = [[diffthis("~")]] })
        map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "toggle_current_line_blame" })
        map("n", "<leader>td", gs.toggle_deleted, { desc = "toggle_deleted" })
        map("n", "<leader>tD", gs.toggle_word_diff, { desc = "toggle_word_diff" })
        map("n", "<leader>tl", gs.toggle_linehl, { desc = "toggle_linehl" })
        map("n", "<leader>tn", gs.toggle_numhl, { desc = "toggle_numhl" })
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select_hunk" })
        map("n", "<leader>SH", gs.show, { desc = "show" })
        map("n", "<leader>hc", function() vim.cmd("Gitsigns") end, { desc = "Commands" })
      end,
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
    keys = function()
      local keymaps = {
        { "<leader>dv", "<Cmd>DiffviewOpen<CR>" },
        { "<leader>dV", ":DiffviewOpen " },
        { "<leader>dc", "<Cmd>DiffviewClose<CR>" },
        { "<leader>du", "<Cmd>DiffviewRefresh<CR>" },
        { "<leader>dh", ":DiffviewFileHistory %<CR>",  mode = { "n", "v" } },
        { "<leader>dH", "<Cmd>DiffviewFileHistory<CR>" },
      }

      for _, keymap in pairs(keymaps) do
        keymap.desc = keymap.desc or keymap[2]
        keymap.desc = string.gsub(keymap.desc, "<Cmd>", "")
        keymap.desc = string.gsub(keymap.desc, "<CR>", "")
        keymap.desc = "[Diffview] " .. (keymap.desc or keymap[2])
      end

      return keymaps
    end,
    opts = function(_, opts)
      local actions = require("diffview.actions")

      return vim.tbl_deep_extend("force", opts, {
        enhanced_diff_hl = true,
        view = {
          default = {
            winbar_info = true,
          },
        },
        file_panel = {
          win_config = {
            position = "bottom",
            height = 16,
          },
        },
        file_history_panel = {
          win_config = {
            position = "bottom",
            height = 16,
          },
        },
        default_args = {
          DiffviewOpen = { "--imply-local" },
        },
        keymaps = {
          view = {
            { "n", "<leader>we", actions.goto_file_edit,  { desc = "Open the file in the previous tabpage" } },
            { "n", "<leader>ws", actions.goto_file_split, { desc = "Open the file in a new split" } },
            { "n", "<leader>wt", actions.goto_file_tab,   { desc = "Open the file in a new tabpage" } },
          },
        },
      })
    end,
  }
}
