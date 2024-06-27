return {
  {
    "lewis6991/gitsigns.nvim",
    event = "LspAttach",
    opts = {
      -- attach_to_untracked = true,
      -- signs_staged_enable = false,
      -- _refresh_staged_on_update = true,
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

        map("n", "<M-]>c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            vim.schedule(next_hunk_stg_repeat)
          end
          return "<Ignore>"
        end, { expr = true, desc = "nav_hunk('next', { 'target' = 'staged' })" })
        map("n", "<M-[>C", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            vim.schedule(prev_hunk_stg_repeat)
          end
          return "<Ignore>"
        end, { expr = true, desc = "nav_hunk('prev', { 'target' = 'staged' })" })

        map("n", "[C", function()
          gitsigns.nav_hunk("first")
        end, { desc = [[nav_hunk("first")]] })
        map("n", "]C", function()
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
      { "<C-g><C-d>", "<Cmd>tab Git diff<CR>", desc = "[Fugitive] :tab Git diff" },
      { "<C-g>b", ":Git blame<CR>", mode = { "n", "x" }, desc = "[Fugitive] :Git blame" },
      { "<C-g>g", ":Ggrep ", desc = "[Fugitive] :Ggrep ..." },
      { "<C-g>l", ":Git log<CR>", mode = { "n", "x" }, desc = "[Fugitive] :Git log" },
      { "<C-g>L", "<Cmd>Git log %<CR>", desc = "[Fugitive] :Git log %" },
      { "<C-g>cl", ":Gclog!<CR>", mode = { "n", "x" }, desc = "[Fugitive] :Gclog!" },
      { "<C-g>cL", ":Gclog! %<CR>", mode = { "n", "x" }, desc = "[Fugitive] :Gclog! %" },
      { "<C-g>cc", ":Git commit<CR>", mode = { "n", "x" }, desc = "[Fugitive] :Git commit" },
      { "<C-g>ca", ":Git commit --amend<CR>", mode = { "n", "x" }, desc = "[Fugitive] :Git commit --amend" },
      {
        "<C-g>!!",
        ":Git commit --amend --no-edit<CR>",
        mode = { "n", "x" },
        desc = "[Fugitive] :Git commit --amend --no-edit",
      },
      {
        "<M-g>!!",
        ":Git commit --all --amend --no-edit<CR>",
        mode = { "n", "x" },
        desc = "[Fugitive] :Git commit --amend --no-edit",
      },
      { "<C-g>ni", ":tab Git diff --no-index ", desc = "[Fugitive] :tab Git diff --no-index ..." },
      { "<C-g>ds", "<Cmd>Gdiffsplit<CR>", desc = "[Fugitive] :Gdiffsplit" },
      { "<C-g>dt", "<Cmd>Git! difftool<CR>", desc = "[Fugitive] :Git! difftool" },
    },
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
