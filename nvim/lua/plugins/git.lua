return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    opts = {
      attach_to_untracked = true,
      trouble = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 0,
      },
      current_line_blame_formatter = " <author> <author_time:%Y-%m-%d %I:%M %p> <abbrev_sha> <summary>",
      -- TODO
      -- diff_opts = {
      --   linematch = 1,
      -- },
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")
        -- TODO: treesitter main
        local repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

        local map = function(mode, lhs, rhs, opts)
          opts = opts or {}
          opts.buffer = bufnr
          opts.desc = "[Gitsigns] " .. (opts.desc or "")
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- TODO: treesitter main
        local function make_nav_repeats(opts, cb)
          local nav_next, nav_prev = repeat_move.make_repeatable_move_pair(function()
            ---@diagnostic disable-next-line: param-type-mismatch
            gitsigns.nav_hunk("next", opts or {}, cb)
          end, function()
            ---@diagnostic disable-next-line: param-type-mismatch
            gitsigns.nav_hunk("prev", opts or {}, cb)
          end)
          return {
            next = nav_next,
            prev = nav_prev,
          }
        end

        local function map_repeat(lhs, diff_cmd, cb, desc)
          map("n", lhs, function()
            if vim.wo.diff then
              vim.cmd.normal({ diff_cmd, bang = true })
            else
              vim.schedule(cb)
            end
            return "<Ignore>"
          end, { expr = true, desc = desc })
        end

        local nav_all = make_nav_repeats({ target = "all" })
        map_repeat("]h", "]c", nav_all.next, "nav_hunk('next', { target = 'all' })")
        map_repeat("[h", "[c", nav_all.prev, "nav_hunk('prev', { target = 'all' })")

        local nav_unstaged = make_nav_repeats({ target = "unstaged" })
        map_repeat("]c", "]c", nav_unstaged.next, "nav_hunk('next', { target = 'unstaged' })")
        map_repeat("[c", "[c", nav_unstaged.prev, "nav_hunk('prev', { target = 'unstaged' })")

        local nav_staged = make_nav_repeats({ target = "staged" })
        map_repeat("]v", "]c", nav_staged.next, "nav_hunk('next', { target = 'staged' })")
        map_repeat("[v", "[c", nav_staged.prev, "nav_hunk('prev', { target = 'staged' })")

        local nav_all_preview = make_nav_repeats({ target = "all" }, gitsigns.preview_hunk_inline)
        map_repeat("]H", "]c", nav_all_preview.next, "nav_hunk next all, preview_hunk_inline")
        map_repeat("[H", "[c", nav_all_preview.prev, "nav_hunk prev all, preview_hunk_inline")

        local nav_unstaged_preview = make_nav_repeats({ target = "unstaged" }, gitsigns.preview_hunk_inline)
        map_repeat("]C", "]c", nav_unstaged_preview.next, "nav_hunk next unstaged, preview_hunk_inline")
        map_repeat("[C", "[c", nav_unstaged_preview.prev, "nav_hunk prev unstaged, preview_hunk_inline")

        local nav_staged_preview = make_nav_repeats({ target = "staged" }, gitsigns.preview_hunk_inline)
        map_repeat("]V", "]c", nav_staged_preview.next, "nav_hunk next staged, preview_hunk_inline")
        map_repeat("[V", "[c", nav_staged_preview.prev, "nav_hunk prev staged, preview_hunk_inline")

        map("n", "[<M-h>", function()
          gitsigns.nav_hunk("first", { target = "all" })
        end, { desc = [[nav_hunk("first")]] })
        map("n", "]<M-h>", function()
          gitsigns.nav_hunk("last", { target = "all" })
        end, { desc = [[nav_hunk("last")]] })

        map("n", "<Space>s", gitsigns.stage_hunk, { desc = "stage_hunk" })
        map("v", "<Space>s", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "stage_hunk" })
        map("n", "<Space>z", gitsigns.reset_hunk, { desc = "reset_hunk" })
        map("v", "<Space>z", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "reset_hunk" })

        map("n", "<Space>S", gitsigns.stage_buffer, { desc = "stage_buffer" })
        map("n", "<Space>Z", gitsigns.reset_buffer, { desc = "reset_buffer" })
        map("n", "<Leader>hp", gitsigns.preview_hunk_inline, { desc = "preview_hunk_inline" })
        map("n", "<M-h>", gitsigns.preview_hunk_inline, { desc = "preview_hunk_inline" })
        -- map("n", "<Leader>ph", gitsigns.preview_hunk, { desc = "preview_hunk" })
        map("n", "<Leader>hr", gitsigns.refresh, { desc = "refresh" })
        map("n", "<Leader>SH", gitsigns.show, { desc = "show" })
        map("n", "<M-b>", gitsigns.blame, { desc = "blame" })
        -- map("n", "<Leader>bl", gitsigns.blame, { desc = "blame" })
        map("n", "<Leader>hq", function()
          gitsigns.setqflist("all")
        end, { desc = "setqflist('all')" })
        map("n", "<Leader>hl", gitsigns.setloclist, { desc = "setloclist" })
        map("n", "<Leader>tb", gitsigns.toggle_current_line_blame, { desc = "toggle_current_line_blame" })
        -- map("n", "<Leader>td", gitsigns.toggle_deleted, { desc = "toggle_deleted" }) -- TODO
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
    keys = function()
      local FloatWrapper = {}

      FloatWrapper.get_ctx = function()
        return {
          win = vim.api.nvim_get_current_win(),
          buf = vim.api.nvim_get_current_buf(),
          tab = vim.api.nvim_get_current_tabpage(),
        }
      end

      FloatWrapper.get_win_opts = function()
        local height = math.floor(vim.o.lines * 0.8)
        local width = math.floor(vim.o.columns * 0.9)
        return {
          relative = "editor",
          width = width,
          height = height,
          row = math.floor((vim.o.lines - height) / 2) - 1,
          col = math.floor((vim.o.columns - width) / 2),
          border = "single",
        }
      end

      function FloatWrapper:wrap(cmd)
        local function _wrapped()
          local ctx = self.get_ctx()
          vim.cmd("tab Git " .. (cmd or ""))
          local fug = self.get_ctx()
          if fug.tab == ctx.tab or fug.win == ctx.win or fug.buf == ctx.buf then
            return
          end
          vim.api.nvim_set_current_tabpage(ctx.tab)
          vim.api.nvim_open_win(fug.buf, true, self.get_win_opts())
          vim.api.nvim_win_close(fug.win, false)
        end
        return _wrapped
      end

      local fw = FloatWrapper
      local date_format = "format:%Y-%m-%d %H:%M:%S"
      local pretty_format = "format:%C(auto)%h %s %C(dim blue)(%ar) %an"

      return {
        { "<C-g><C-g>", fw:wrap(), desc = "[Fugitive] :Git (:G)" },
        { "<Leader>gg", vim.cmd.Git, desc = "[Fugitive] :Git (:G)" },
        { "<M-G>", vim.cmd.Git, desc = "[Fugitive] :Git (:G)" },
        -- { "<M-g><M-g>", vim.cmd.Git, desc = "[Fugitive] :Git (:G)" },
        { "<Leader>gU", "<Cmd>Git restore --staged .<CR>", desc = "[Fugitive] unstage all" },
        -- { "<Leader>gu", "<Cmd>Git restore --staged .<CR>", desc = "[Fugitive] unstage all" },
        -- { "<Space><M-s>", "<Cmd>Git restore --staged .<CR>", desc = "[Fugitive] unstage all" },
        { "<Space><M-s>", "<Cmd>Git restore --staged %<CR>", desc = "[Fugitive] unstage all" },
        { "<C-g><C-s>", "<Cmd>Git status --short<CR>", desc = "[Fugitive] :Git status --short" },
        { "<C-g>st", fw:wrap("Git status"), desc = "[Fugitive] :Git status" },
        { "<C-g><C-d>", fw:wrap("diff"), desc = "[Fugitive] :Git diff" },
        -- TODO
        {
          "<C-g><C-l>",
          -- fw:wrap("log --oneline"),
          fw:wrap("log --pretty='format:%C(auto)%h %s %C(dim blue)(%ar) %an %ae' --date='format:%Y-%m-%d %H:%M:%S'"),
          -- fw:wrap("log --pretty='format:%C(auto)%h %s %C(dim blue)(%ar) %an %ae' --date='format:%Y-%m-%d %H:%M:%S' --color='always'"),
          -- fw:wrap("log --oneline"),
          -- fw:wrap(("log --pretty='%s' --date='%s'").format(date_format, pretty_format)),
          mode = { "n", "x" },
          desc = "[Fugitive] :Git log (oneline, custom format, relative date)",
        },
        {
          "<C-g><C-k>",
          -- fw:wrap("log --oneline"),
          -- fw:wrap("log origin/HEAD...HEAD --pretty='format:%C(auto)%h %s %C(dim blue)(%ar) %an' --date='format:%Y-%m-%d %H:%M:%S'"),
          -- fw:wrap(("log origin/HEAD..HEAD --pretty='%s' --date='%s'"):format(date_format, pretty_format)),
          fw:wrap("log  origin/HEAD..HEAD --pretty='format:%C(auto)%h %s %C(dim blue)(%ar) %an %ae' --date='format:%Y-%m-%d %H:%M:%S'"),
          -- fw:wrap(
          --   "log --pretty='format:%h %s (%ar) %an %ae' --date='format:%Y-%m-%d %H:%M:%S' --color=always origin/HEAD..HEAD"
          -- ),
          mode = { "n", "x" },
          desc = "[Fugitive] :Git log origin/HEAD...HEAD (oneline, custom format, relative date)",
        },
        { "<C-g>lo", fw:wrap("log"), mode = { "n", "x" }, desc = "[Fugitive] :Git log" },
        { "<C-g>lb", fw:wrap("log %"), mode = { "n", "x" }, desc = "[Fugitive] :Git log %" },
        {
          -- "<C-g>1",
          "<C-g>-",
          fw:wrap("log -1 -p --stat"),
          mode = { "n", "x" },
          desc = "[Fugitive] :Git log -1 -p --stat",
        },
        {
          "<C-g><C-u>",
          fw:wrap("log --oneline --pretty='format:%h%d %s (%ar) %ad' --date='format:%Y-%m-%d %H:%M:%S' ...@{u}"),
          mode = { "n", "x" },
          desc = "[Fugitive] :Git log --oneline ...@{u} (w/ dates)",
        },
        { "<C-g><C-h>", fw:wrap("show"), desc = "[Fugitive] :Git show" },
        { "<C-g><C-c>", fw:wrap("commit"), mode = { "n", "x" }, desc = "[Fugitive] :Git commit" },
        {
          "<C-g><C-a>",
          fw:wrap("commit --amend"),
          mode = { "n", "x" },
          desc = "[Fugitive] :Git commit --amend",
        },
        {
          "<M-g>cA",
          "<Cmd>tab Git commit --amend<CR>",
          mode = { "n", "x" },
          desc = "[Fugitive] :tab Git commit --amend",
        },
        {
          "<M-1><M-1>",
          "<Cmd>Git commit --amend --no-edit --date=now<CR>",
          mode = { "n", "x" },
          desc = "[Fugitive] :Git commit --amend --no-edit --date=now",
        },
        {
          "<M-!><M-!>",
          "<Cmd>Git commit --all --amend --no-edit --date=now<CR>",
          mode = { "n", "x" },
          desc = "[Fugitive] :Git commit --all --amend --no-edit --date=now<CR>",
        },
        {
          "<C-g>!!",
          "<Cmd>Git commit --amend --no-edit<CR>",
          mode = { "n", "x" },
          desc = "[Fugitive] :Git commit --amend --no-edit",
        },
        -- -- TODO
        -- {
        --   "<M-=><M-=>",
        --   "<Cmd>Git commit --amend --no-edit<CR>",
        --   mode = { "n", "x" },
        --   desc = "[Fugitive] :Git commit --amend --no-edit",
        -- },
        {
          "<M-g>!!",
          "<Cmd>Git commit --all --amend --no-edit<CR>",
          mode = { "n", "x" },
          desc = "[Fugitive] :Git commit --all --amend --no-edit",
        },
        { "<C-g><C-b>", "<Cmd>Git blame<CR>", mode = { "n", "x" }, desc = "[Fugitive] :Git blame" },
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

        -- WIP
        -- {
        --   "<C-g><C-w>",
        --   function()
        --     -- TODO
        --     -- gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'
        --   end,
        --   "[Fugitive] Git WIP",
        -- },
        -- {
        --   "<M-g><M-w>",
        --   function()
        --     -- TODO
        --     -- gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q "\--wip--" && git reset HEAD~1'
        --   end,
        --   "[Fugitive] Git UnWIP",
        -- },

        { "<C-g>dm", fw:wrap("diff origin/HEAD...HEAD"), desc = "[Fugitive] :Git diff origin/HEAD...HEAD" },
        { "<C-g>dv", "<Cmd>Gdiffsplit<CR>", desc = "[Fugitive] :Gdiffsplit" },
        { "<C-g>dt", "<Cmd>Git! difftool<CR>", desc = "[Fugitive] :Git! difftool" },

        { "<C-g>gr", "<Cmd>Ggrep ", desc = "[Fugitive] :Ggrep ..." },
        { "<C-g>cl", "<Cmd>Gclog!<CR>", mode = { "n", "x" }, desc = "[Fugitive] :Gclog!" },
        { "<C-g>cL", "<Cmd>Gclog! %<CR>", mode = { "n", "x" }, desc = "[Fugitive] :Gclog! %" },
      }
    end,
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("UserFugitiveShiftBlame", { clear = true }),
        pattern = "fugitiveblame",
        callback = function()
          vim.api.nvim_set_option_value("winbar", "-", { win = vim.api.nvim_get_current_win(), scope = "local" })
        end,
      })

      -- -- Put this somewhere in your config (after colorscheme is set).
      -- local aug = vim.api.nvim_create_augroup("FugitiveLogPrettyColors", { clear = true })
      --
      -- vim.api.nvim_create_autocmd({ "FileType" }, {
      --   group = aug,
      --   pattern = { "git", "fugitive" }, -- Fugitive output is often ft=git; safe to include both
      --   callback = function(ev)
      --     -- Only target Fugitive buffers (avoid coloring real .git/* files)
      --     local name = vim.api.nvim_buf_get_name(ev.buf)
      --     if not name:match("^fugitive://") then
      --       return
      --     end
      --
      --     -- Clear in case we re-enter
      --     vim.cmd("silent! syntax clear FugitivePrettyLog")
      --
      --     -- Your format:
      --     -- %h %s (%ar) %an %ae
      --
      --     -- commit hash at start of line
      --     vim.cmd([[syntax match FugitivePrettyLogHash /^\x\{7,40}\>/ containedin=ALL]])
      --
      --     -- "(2 days ago)" bit
      --     vim.cmd([[syntax match FugitivePrettyLogRelDate /(\zs[^)]\+\ze)/ containedin=ALL]])
      --
      --     -- email (best-effort)
      --     -- vim.cmd([[syntax match FugitivePrettyLogEmail /\v<[^[:space:]]+@[^[:space:]]+>/ containedin=ALL]])
      --     vim.cmd("syntax match FugitivePrettyLogEmail /\\v<[^[:space:]]+@[^[:space:]]+>/ containedin=ALL")
      --
      --     -- author name: after ") " and before " <email>" (rough but works well)
      --     vim.cmd([[syntax match FugitivePrettyLogAuthor /\v\)\s\zs.{-}\ze\s<[^>]+>/ containedin=ALL]])
      --
      --     -- Link to existing theme groups so it looks “native”
      --     vim.cmd([[highlight default link FugitivePrettyLogHash Identifier]])
      --     vim.cmd([[highlight default link FugitivePrettyLogRelDate Comment]])
      --     vim.cmd([[highlight default link FugitivePrettyLogAuthor Type]])
      --     vim.cmd([[highlight default link FugitivePrettyLogEmail String]])
      --   end,
      -- })
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
      { "<Leader>dH", "<Cmd>DiffviewFileHistory<CR>", desc = "[Diffview] :DiffviewFileHistory" },
      {
        "<Leader>dh",
        "<Cmd>DiffviewFileHistory %<CR>",
        mode = { "n", "v" },
        desc = "[Diffview] :DiffviewFileHistory %",
      },
      {
        "<Leader>dm",
        "<Cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<CR>",
        desc = "[Diffview] :DiffviewOpen origin/HEAD...HEAD --imply-local",
      },
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
