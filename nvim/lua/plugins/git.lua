return {
  {
    "lewis6991/gitsigns.nvim",
    event = "LspAttach",
    opts = {
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 0,
      },
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local repeatable_move = require("nvim-treesitter.textobjects.repeatable_move")

        local map = function(mode, lhs, rhs, opts)
          opts = opts or {}
          opts.buffer = bufnr
          opts.silent = true
          opts.desc = "[Gitsigns] " .. (opts.desc or "")
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        local next_hunk_repeat, prev_hunk_repeat = repeatable_move.make_repeatable_move_pair(function()
          gs.nav_hunk("next")
        end, function()
          gs.nav_hunk("prev")
        end)

        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          end
          vim.schedule(next_hunk_repeat)
          return "<Ignore>"
        end, { expr = true, desc = "Next hunk" })
        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          end
          vim.schedule(prev_hunk_repeat)
          return "<Ignore>"
        end, { expr = true, desc = "Prev hunk" })
        map("n", "<Space>s", gs.stage_hunk, { desc = "stage_hunk" })
        map("v", "<Space>s", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "stage_hunk" })
        map("n", "<Space>S", gs.stage_buffer, { desc = "stage_buffer" })
        map("n", "<Space>z", gs.reset_hunk, { desc = "reset_hunk" })
        map("v", "<Space>z", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "reset_hunk" })
        map("n", "<Space>Z", gs.reset_buffer, { desc = "reset_buffer" })
        map({ "n", "v" }, "<Space>u", gs.undo_stage_hunk, { desc = "undo_stage_hunk" })
        map("n", "<Leader>hp", gs.preview_hunk, { desc = "preview_hunk" })
        map("n", "<Leader>hq", gs.setqflist, { desc = "setqflist" })
        map("n", "<Leader>hl", gs.setloclist, { desc = "setloclist" })
        map("n", "<Leader>hb", function()
          gs.blame_line({ full = false })
        end, { desc = "blame_line { full = false }" })
        map("n", "<Leader>hB", function()
          gs.blame_line({ full = true })
        end, { desc = "blame_line { full = true }" })
        map("n", "<Leader>hd", gs.diffthis, { desc = "diffthis" })
        map("n", "<Leader>hD", function()
          gs.diffthis("~")
        end, { desc = [[diffthis("~")]] })
        map("n", "<Leader>tb", gs.toggle_current_line_blame, { desc = "toggle_current_line_blame" })
        map("n", "<Leader>td", gs.toggle_deleted, { desc = "toggle_deleted" })
        map("n", "<Leader>tD", gs.toggle_word_diff, { desc = "toggle_word_diff" })
        map("n", "<Leader>tl", gs.toggle_linehl, { desc = "toggle_linehl" })
        map("n", "<Leader>tn", gs.toggle_numhl, { desc = "toggle_numhl" })
        map("n", "<Leader>SH", gs.show, { desc = "show" })
        map("n", "<Leader>hc", function()
          vim.cmd("Gitsigns")
        end, { desc = "Commands" })
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select_hunk" })
      end,
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
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git" },
    keys = {
      { "<C-g><C-g>", "<Cmd>Git<CR>", desc = "[Fugitive] :Git (:G)" },
      { "<C-g><C-d>", "<Cmd>tab Git diff<CR>", desc = "[Fugitive] :tab Git diff" },
      { "<C-g>b", ":Git blame<CR>", mode = { "n", "x" }, desc = "[Fugitive] :Git blame" },
      { "<C-g>g", ":Ggrep ", desc = "[Fugitive] :Ggrep ..." },
      { "<C-g>l", "<Cmd>Git log %<CR>", desc = "[Fugitive] :Git log %" },
      { "<C-g>L", ":Git log<CR>", mode = { "n", "x" }, desc = "[Fugitive] :Git log" },
      { "<C-g>cl", ":Gclog! %<CR>", mode = { "n", "x" }, desc = "[Fugitive] :Gclog! %" },
      { "<C-g>cL", ":Gclog!<CR>", mode = { "n", "x" }, desc = "[Fugitive] :Gclog!" },
      { "<C-g>ds", "<Cmd>Gdiffsplit<CR>", desc = "[Fugitive] :Gdiffsplit" },
      { "<C-g>dt", "<Cmd>Git! difftool<CR>", desc = "[Fugitive] :Git! difftool" },
      { "<C-g>ni", ":tab Git diff --no-index ", desc = "[Fugitive] :tab Git diff --no-index ..." },
    },
  },
}
