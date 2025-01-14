return {
  {
    "lewis6991/gitsigns.nvim",
    event = "LspAttach",
    opts = {
      attach_to_untracked = true,
      signs_staged_enable = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 0,
      },
      current_line_blame_formatter = " <author> <author_time:%Y-%m-%d %H:%M %p> <summary> (<abbrev_sha>)",
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")
        local repeatable_move = require("nvim-treesitter.textobjects.repeatable_move")

        local map = function(mode, lhs, rhs, opts)
          opts = opts or {}
          opts.buffer = bufnr
          opts.desc = "[Gitsigns] " .. (opts.desc or "")
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        local next_hunk_repeat, prev_hunk_repeat = repeatable_move.make_repeatable_move_pair(function()
          gitsigns.nav_hunk("next")
        end, function()
          gitsigns.nav_hunk("prev")
        end)
        local next_hunk_stg_repeat, prev_hunk_stg_repeat = repeatable_move.make_repeatable_move_pair(function()
          gitsigns.nav_hunk("next", { target = "staged" })
        end, function()
          gitsigns.nav_hunk("prev", { target = "staged" })
        end)

        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            vim.schedule(next_hunk_repeat)
          end
          return "<Ignore>"
        end, { expr = true, desc = "nav_hunk('next')" })
        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            vim.schedule(prev_hunk_repeat)
          end
          return "<Ignore>"
        end, { expr = true, desc = "nav_hunk('prev')" })

        map("n", "]C", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            vim.schedule(next_hunk_stg_repeat)
          end
          return "<Ignore>"
        end, { expr = true, desc = "nav_hunk('next', { 'target' = 'staged' })" })
        map("n", "[C", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            vim.schedule(prev_hunk_stg_repeat)
          end
          return "<Ignore>"
        end, { expr = true, desc = "nav_hunk('prev', { 'target' = 'staged' })" })

        map("n", "<M-[>c", function()
          gitsigns.nav_hunk("first")
        end, { desc = [[nav_hunk("first")]] })
        map("n", "<M-]>c", function()
          gitsigns.nav_hunk("last")
        end, { desc = [[nav_hunk("last")]] })

        map("n", "<Space>s", gitsigns.stage_hunk, { desc = "stage_hunk" })
        map("v", "<Space>s", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "stage_hunk" })
        map("n", "<Space>z", gitsigns.reset_hunk, { desc = "reset_hunk" })
        map("v", "<Space>z", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "reset_hunk" })
        map("n", "<Space>u", gitsigns.undo_stage_hunk, { desc = "undo_stage_hunk" })
        map("n", "<Space>S", gitsigns.stage_buffer, { desc = "stage_buffer" })
        map("n", "<Leader>ss", gitsigns.stage_buffer, { desc = "stage_buffer" })
        map("n", "<Space>Z", gitsigns.reset_buffer, { desc = "reset_buffer" })
        map("n", "<Leader>hp", gitsigns.preview_hunk, { desc = "preview_hunk" })
        map("n", "<Leader>hr", gitsigns.refresh, { desc = "refresh" })
        map("n", "<Leader>SH", gitsigns.show, { desc = "show" })
        map("n", "<Leader>hq", gitsigns.setqflist, { desc = "setqflist" })
        map("n", "<Leader>hl", gitsigns.setloclist, { desc = "setloclist" })
        map("n", "<Leader>tb", gitsigns.toggle_current_line_blame, { desc = "toggle_current_line_blame" })
        map("n", "<Leader>td", gitsigns.toggle_deleted, { desc = "toggle_deleted" })
        map("n", "<Leader>tD", gitsigns.toggle_word_diff, { desc = "toggle_word_diff" })
        map("n", "<Leader>tl", gitsigns.toggle_linehl, { desc = "toggle_linehl" })
        map("n", "<Leader>tn", gitsigns.toggle_numhl, { desc = "toggle_numhl" })
        map("n", "<Leader>hd", gitsigns.diffthis, { desc = "diffthis" })
        map("n", "<Leader>hD", function()
          gitsigns.diffthis("~")
        end, { desc = [[diffthis("~")]] })
        map("n", "<Leader>hb", function()
          gitsigns.blame_line({ full = false })
        end, { desc = "blame_line { full = false }" })
        map("n", "<Leader>hB", function()
          gitsigns.blame_line({ full = true })
        end, { desc = "blame_line { full = true }" })
        map("n", "<Leader>hc", function()
          vim.cmd("Gitsigns")
        end, { desc = "Commands" })
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select_hunk" })
      end,
    },
  },
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git" },
    keys = {
      { "<C-g><C-g>", "<Cmd>Git<CR>", desc = "[Fugitive] :Git (:G)" },
      { "<C-g><C-v>", "<Cmd>vert Git<CR>", desc = "[Fugitive] :vert Git" },
      { "<C-g><C-t>", "<Cmd>tab Git<CR>", desc = "[Fugitive] :tab Git" },

      { "<C-g><C-s>", "<Cmd>Git status --short<CR>", desc = "[Fugitive] :Git status --short" },
      { "<C-g>ss", "<Cmd>vert Git status --short<CR>", desc = "[Fugitive] :vert Git status --short" },
      { "<C-g>st", "<Cmd>vert Git status<CR>", desc = "[Fugitive] :vert Git status" },
      { "<M-g>ss", "<Cmd>tab Git status --short<CR>", desc = "[Fugitive] :tab Git status --short" },
      { "<M-g>st", "<Cmd>tabGit status<CR>", desc = "[Fugitive] :tab Git status" },

      { "<C-g><C-d>", "<Cmd>Git diff<CR>", desc = "[Fugitive] :Git diff" },
      { "<C-g>dd", "<Cmd>vert Git diff<CR>", desc = "[Fugitive] :vert Git diff" },
      { "<C-g>ds", "<Cmd>vert Git diff --staged<CR>", desc = "[Fugitive] :vert Git diff --staged" },
      { "<C-g>ni", "<Cmd>vert Git diff --no-index ", desc = "[Fugitive] :vert Git diff --no-index ..." },
      { "<M-g>dd", "<Cmd>tab Git diff<CR>", desc = "[Fugitive] :tab Git diff" },
      { "<M-g>ds", "<Cmd>tab Git diff --staged<CR>", desc = "[Fugitive] :tab Git diff --staged" },
      { "<M-g>ni", "<Cmd>tab Git diff --no-index ", desc = "[Fugitive] :tab Git diff --no-index ..." },

      { "<C-g><C-l>", "<Cmd>Git log --oneline<CR>", mode = { "n", "x" }, desc = "[Fugitive] :Git log --oneline" },
      { "<C-g>lo", "<Cmd>vert Git log<CR>", mode = { "n", "x" }, desc = "[Fugitive] :vert Git log" },
      { "<C-g>lb", "<Cmd>vert Git log %<CR>", mode = { "n", "x" }, desc = "[Fugitive] :vert Git log %" },
      {
        "<C-g>ll",
        "<Cmd>vert Git log --oneline<CR>",
        mode = { "n", "x" },
        desc = "[Fugitive] :vert Git log --oneline",
      },
      { "<M-g>lo", "<Cmd>tab Git log<CR>", mode = { "n", "x" }, desc = "[Fugitive] :tab Git log" },
      { "<M-g>lb", "<Cmd>tab Git log %<CR>", mode = { "n", "x" }, desc = "[Fugitive] :tab Git log %" },
      { "<M-g>ll", "<Cmd>tab Git log --oneline<CR>", mode = { "n", "x" }, desc = "[Fugitive] :tab Git log --oneline" },

      {
        "<C-g><C-u>",
        "<Cmd>Git log --oneline --pretty='format:%h%d %s (%ar) %ad' --date='format:%Y-%m-%d %H:%M:%S' ...@{u}<CR>",
        mode = { "n", "x" },
        desc = "[Fugitive] :Git log --oneline ...@{u} (w/ dates)",
      },

      { "<C-g><C-c>", "<Cmd>Git commit<CR>", mode = { "n", "x" }, desc = "[Fugitive] :Git commit" },
      { "<C-g>cc", "<Cmd>vert Git commit<CR>", mode = { "n", "x" }, desc = "[Fugitive] :vert Git commit" },
      { "<C-g><C-a>", "<Cmd>Git commit --amend<CR>", mode = { "n", "x" }, desc = "[Fugitive] :Git commit --amend" },
      {
        "<C-g>cA",
        "<Cmd>vert Git commit --amend<CR>",
        mode = { "n", "x" },
        desc = "[Fugitive] :vert Git commit --amend",
      },
      { "<M-g>cc", "<Cmd>tab Git commit<CR>", mode = { "n", "x" }, desc = "[Fugitive] :tab Git commit" },
      {
        "<M-g>cA",
        "<Cmd>tab Git commit --amend<CR>",
        mode = { "n", "x" },
        desc = "[Fugitive] :tab Git commit --amend",
      },

      { "<C-g><C-h>", "<Cmd>Git show<CR>", desc = "[Fugitive] :Git show" },
      { "<C-g>sh", "<Cmd>vert Git show<CR>", desc = "[Fugitive] :vert Git show" },
      { "<M-g>sh", "<Cmd>tab Git show<CR>", desc = "[Fugitive] :tab Git show" },

      {
        "<C-g>!!",
        "<Cmd>Git commit --amend --no-edit --date=now<CR>",
        mode = { "n", "x" },
        desc = "[Fugitive] :Git commit --amend --no-edit --date=now",
      },
      {
        "<M-g>!!",
        "<Cmd>Git commit --all --amend --no-edit --date=now<CR>",
        mode = { "n", "x" },
        desc = "[Fugitive] :Git commit --amend --no-edit --date=now",
      },
      {
        "<C-g>!~",
        "<Cmd>Git commit --amend --no-edit<CR>",
        mode = { "n", "x" },
        desc = "[Fugitive] :Git commit --amend --no-edit",
      },
      {
        "<M-g>!~",
        "<Cmd>Git commit --all --amend --no-edit<CR>",
        mode = { "n", "x" },
        desc = "[Fugitive] :Git commit --amend --no-edit",
      },

      { "<C-g>bl", "<Cmd>Git blame<CR>", mode = { "n", "x" }, desc = "[Fugitive] :Git blame" },
      {
        "<C-g><C-w>",
        function()
          local win = vim.api.nvim_get_current_win()
          local val = ""
          if vim.api.nvim_get_option_value("winbar", { win = win }) == "" then
            val = "-"
          end
          vim.api.nvim_set_option_value("winbar", val, { win = win, scope = "local" })
        end,
        ft = "fugitiveblame",
        desc = "[Fugitive] toggle winbar",
      },

      { "<C-g>dv", "<Cmd>Gdiffsplit<CR>", desc = "[Fugitive] :Gdiffsplit" },
      { "<C-g>dt", "<Cmd>Git! difftool<CR>", desc = "[Fugitive] :Git! difftool" },
      { "<C-g>gr", "<Cmd>Ggrep ", desc = "[Fugitive] :Ggrep ..." },
      { "<C-g>cl", "<Cmd>Gclog!<CR>", mode = { "n", "x" }, desc = "[Fugitive] :Gclog!" },
      { "<C-g>cL", "<Cmd>Gclog! %<CR>", mode = { "n", "x" }, desc = "[Fugitive] :Gclog! %" },
    },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("UserFugitiveShiftBlame", { clear = true }),
        pattern = "fugitiveblame",
        callback = function()
          vim.api.nvim_set_option_value("winbar", "-", { win = vim.api.nvim_get_current_win(), scope = "local" })
        end,
      })
    end,
  },
  {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
    keys = {
      { "<Leader>dv", "<Cmd>DiffviewOpen<CR>", desc = "[Diffview] :DiffviewOpen" },
      { "<Leader>dV", ":DiffviewOpen ", desc = "[Diffview] :DiffviewOpen" },
      { "<Leader>dc", "<Cmd>DiffviewClose<CR>", desc = "[Diffview] :DiffviewClose" },
      { "<Leader>du", "<Cmd>DiffviewRefresh<CR>", desc = "[Diffview] :DiffviewRefresh" },
      { "<Leader>dh", ":DiffviewFileHistory %<CR>", mode = { "n", "v" }, desc = "[Diffview] :DiffviewFileHistory %" },
      { "<Leader>dH", "<Cmd>DiffviewFileHistory<CR>", desc = "[Diffview] :DiffviewFileHistory" },
    },
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
            { "n", "<Leader>we", actions.goto_file_edit, { desc = "Open the file in the previous tabpage" } },
            { "n", "<Leader>ws", actions.goto_file_split, { desc = "Open the file in a new split" } },
            { "n", "<Leader>wt", actions.goto_file_tab, { desc = "Open the file in a new tabpage" } },
          },
        },
      })
    end,
  },
}
