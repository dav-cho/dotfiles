return {
  {
    dir = "dav.themes",
    name = "dav.themes",
    virtual = true,
    dependencies = { "telescope.nvim" },
    keys = function()
      local themes = {
        ["catppuccin"] = "catppuccin",
        ["codedark"] = "vim-code-dark",
        ["darkplus"] = "darkplus.nvim",
        ["everforest"] = "everforest",
        ["kanagawa"] = "kanagawa.nvim",
        ["material"] = "material.nvim",
        ["moonfly"] = "moonfly",
        ["onedark"] = "onedark.nvim",
        ["onenord"] = "onenord.nvim",
        ["rose-pine"] = "rose-pine",
        ["tokyonight"] = "tokyonight.nvim",
        ["zenbones"] = "zenbones.nvim",
      }

      local function set_theme(theme)
        if package.loaded[theme] then
          vim.cmd("colorscheme " .. theme)
          return
        end
        require("lazy").load({ plugins = { themes[theme] } })
      end

      return {
        {
          "<Leader>th",
          function()
            local choices = {}
            for theme, _ in pairs(themes) do
              table.insert(choices, theme)
            end
            table.sort(choices)
            vim.ui.select(choices, { prompt = "Select Theme:" }, function(choice)
              if choice and themes[choice] then
                set_theme(themes[choice])
              end
            end)
          end,
          desc = "[Custom] Set theme",
        },
        {
          "<Leader>ty",
          function()
            set_theme("tokyonight")
          end,
          desc = "[Theme] Tokyonight",
        },
        {
          "<Leader>on",
          function()
            set_theme("onenord")
          end,
          desc = "[Theme] onenord",
        },
      }
    end,
  },

  -- WIP
  {
    dir = "dav.scratch",
    name = "dav.scratch",
    virtual = true,
    lazy = true,
    keys = {
      {
        "<Leader><Leader>",
        -- "<M-Bar>",
        -- "<M-Bslash>",
        function()
          require("dav.scratch").toggle()
        end,
        desc = "[dav.scratch] toggle",
      },
      -- {
      --   -- "<Leader><Leader>",
      --   "<Space><Leader>",
      --   -- "<Leader><Space>",
      --   -- "<Leader>xx",
      --   -- "<C-s>",
      --   -- "<Space>j",
      --   -- "<Space>u",
      --   -- "<Space>y",
      --   -- "<Space>x",
      --   function()
      --     require("dav.scratch").toggle()
      --   end,
      --   desc = "[dav.scratch] toggle",
      -- },
    },

    -- -- local dir_data = vim.fn.stdpath("data") .. "/scratch"
    -- local data_dir = vim.fn.stdpath("data") .. "/scratch"
    -- local cache_dir = vim.fn.stdpath("cache") .. "/scratch"

    -- ---@param name string
    -- ---@return number
    -- local function create_buf(name)
    --   local buf = vim.api.nvim_create_buf(false, true)
    --   return buf
    -- end
    config = function()
      local M = {}

      M.current = {
        name = "default",
        buf = nil,
        win = nil,
      }

      ---@return number
      local function create_buf()
        local buf = vim.api.nvim_create_buf(false, true)
        return buf
      end

      local function get_buf()
        return M.current.buf or create_buf()
      end

      ---@param buf number
      ---@return number
      local function open_win(buf)
        local height = math.floor(vim.o.lines * 0.8)
        local width = math.floor(vim.o.columns * (vim.o.columns > 160 and 0.6 or 0.8))
        local win = vim.api.nvim_open_win(buf, true, {
          relative = "editor",
          width = width,
          height = height,
          -- row = math.floor((vim.o.lines - height) / 2),
          row = math.floor((vim.o.lines - height) / 2) - 1,
          col = math.floor((vim.o.columns - width) / 2),
          border = "single",
        })
        return win
      end

      M.open = function()
        local buf = get_buf()
        local win = open_win(buf)
        -- if vim.api.nvim_buf_is_valid(buf) then
        --   M.current.buf = buf
        -- end

        -- vim.notify(string.format("buf: %s, win: %s", buf, win))
        -- vim.notify(
        --   string.format(
        --     "buftype: %s\nbufhidden: %s\nswapfile: %s",
        --     vim.api.nvim_buf_get_option(buf, "buftype"),
        --     vim.api.nvim_buf_get_option(buf, "bufhidden"),
        --     vim.api.nvim_buf_get_option(buf, "swapfile")
        --   )
        -- )

        M.current.buf = buf
        M.current.win = win

        vim.keymap.set("n", "q", function()
          vim.api.nvim_win_close(win, false)
        end, { buffer = buf })
        vim.keymap.set("n", "<Esc>", function()
          vim.api.nvim_win_close(win, false)
        end, { buffer = buf })
      end

      M.close = function()
        if vim.api.nvim_get_current_win() == M.current.win then
          vim.api.nvim_win_close(M.current.win, false)
        end
      end

      -- M.toggle = function()
      --   -- return M.current.win and M.close() or M.open()
      --   if M.current.win then
      --     M.close()
      --   else
      --     M.open()
      --   end
      -- end

      M.toggle = function()
        local win = M.current.win
        if win and vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_close(win, false)
        else
          M.open()
        end
      end

      package.loaded["dav.scratch"] = M
    end,
  },
  -- return M
  -- require("lazy").load({ plugins = { "dav.scratch" } })
  -- --TODO: chat gpt
  -- local M = {}
  -- setmetatable(M, {
  --   __index = function(t, key)
  --     if key == "buf" then
  --       if not rawget(t, "buf") or not vim.api.nvim_buf_is_valid(t.buf) then
  --         t.buf = vim.api.nvim_create_buf(false, true)
  --         vim.bo[t.buf].buftype = "nofile"
  --         vim.bo[t.buf].bufhidden = "hide"
  --         vim.bo[t.buf].swapfile = false
  --       end
  --       return t.buf
  --     elseif key == "win" then
  --       return rawget(t, "win")  -- Only return if already set
  --     end
  --   end
  -- })
  --
  -- ---@param buf number
  -- ---@return number
  -- local function open_win(buf)
  --   local height = math.floor(vim.o.lines * 0.8)
  --   local width = math.floor(vim.o.columns * (vim.o.columns > 160 and 0.5 or 0.8))
  --
  --   M.win = vim.api.nvim_open_win(buf, true, {
  --     relative = "editor",
  --     width = width,
  --     height = height,
  --     row = math.floor((vim.o.lines - height) / 2),
  --     col = math.floor((vim.o.columns - width) / 2),
  --     border = "single",
  --   })
  --   vim.api.nvim_win_set_option(M.win, "winblend", 10)
  --
  --   -- Close window with 'q'
  --   vim.keymap.set("n", "q", function()
  --     M.toggle()
  --   end, { buffer = buf })
  -- end
  --
  -- function M.toggle()
  --   if M.win and vim.api.nvim_win_is_valid(M.win) then
  --     vim.api.nvim_win_close(M.win, true)
  --     M.win = nil
  --   else
  --     open_win(M.buf) -- `M.buf` now auto-initializes!
  --   end
  -- end
  --
  -- return M

  -- WIP
  {
    dir = "dav.comment",
    name = "dav.comment",
    virtual = true,
    lazy = true,
    -- event = "VeryLazy",
    keys = {
      -- {
      --   "<leader>\\",
      --   function()
      --     require("dav.comment").foo()
      --   end,
      -- },
      -- {
      --   "<leader><leader>",
      --   "O-- TODO<Esc>",
      -- },
    },
    config = function()
      local M = {}

      M.comments = {
        lua = "--",
        python = "#",
      }

      M.foo = function()
        vim.notify("hello from foo")
      end

      M.insert_todo_above = function(_)
        -- require("Comment.api").insert.linewise.above({
        require("Comment.api").comment.linewise({
          -- pre_hook = function()
          --   vim.api.nvim_input("OTODO")
          --   -- vim.api.nvim_put({ "TODO" }, "c", true, true)
          -- end,
          post_hook = function()
            -- vim.api.nvim_put({ " TODO" }, "c", true, true)
            -- vim.api.nvim_input(" TODO<Esc>")
            vim.api.nvim_input("<Esc>")
          end,
        })
      end

      M.locked = function(cb)
        return function(motion)
          return vim.api.nvim_command(
            ('lockmarks lua require("dav.comment").%s(%s)'):format(cb, motion and ("%q"):format(motion))
          )
        end
      end

      package.loaded["dav.comment"] = M
    end,
  },

  -- vim.cmd("stopinsert")

  -- {
  --   dir = "dav.comment",
  --   name = "dav.comment",
  --   virtual = true,
  --   -- lazy = true,
  --   event = "VeryLazy",
  --   keys = {
  --     {
  --       "<leader>\\",
  --       function()
  --         require("dav.comment").foo()
  --       end,
  --     },
  --   },
  --   config = function()
  --     local M = {}
  --
  --     M.foo = function()
  --       vim.notify("hello from foo")
  --     end
  --
  --     -- M.insert_todo_above = function(motion)
  --     --   vim.schedule(function()
  --     --     vim.notify("hello from insert_todo_above" .. ("(motion: %s)"):format(motion))
  --     --   end)
  --     --   vim.api.nvim_input("gcOTODO<Esc>")
  --     -- end
  --
  --     M.insert_todo_above = function(type)
  --       local api = require("Comment.api") -- Use Comment.nvim API
  --       if type == "line" then
  --         api.insert.linewise.above()
  --         vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1] - 1, 0 })
  --         vim.api.nvim_put({ " TODO" }, "c", false, true)
  --       end
  --     end
  --
  --     M.locked = function(cb)
  --       return function(motion)
  --         -- vim.schedule(function()
  --         --   vim.notify(
  --         --     "hello from locked"
  --         --       .. "\n"
  --         --       .. ("lockmarks lua require('dav.comment').%s(%s)"):format(cb, motion and ("%q"):format(motion))
  --         --   )
  --         -- end)
  --         return vim.api.nvim_command(
  --           ("lockmarks lua require('dav.comment').%s(%s)"):format(cb, motion and ("%q"):format(motion))
  --         )
  --       end
  --     end
  --
  --     M.call = function(cb, op)
  --       return function()
  --         -- vim.schedule(function()
  --         --   vim.notify("hello from call" .. "\n" .. ("v:lua.require('dav.comment').locked('%s')"):format(cb))
  --         -- end)
  --         vim.api.nvim_set_option("operatorfunc", ("v:lua.require('dav.comment').locked('%s')"):format(cb))
  --         return op
  --       end
  --     end
  --
  --     vim.keymap.set(
  --       "n",
  --       "<leader><leader>",
  --       M.call("insert_todo_above", "g@$"),
  --       { expr = true, desc = "[Comment] TODO above" }
  --     )
  --
  --     package.loaded["dav.comment"] = M
  --   end,
  -- },

  -- TODO: hlslens own impl
  -- {
  --   name = "dav.search-count",
  --   virtual = true,
  --   config = function()
  --
  --     -- -- plugin:
  --     -- local ns = vim.api.nvim_create_namespace("searchcount")
  --     --
  --     -- local function clear()
  --     --   vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
  --     -- end
  --     --
  --     -- local function show()
  --     --   local sc = vim.fn.searchcount({ recompute = 1, maxcount = 9999 })
  --     --   if sc.total == 0 then
  --     --     clear()
  --     --     return
  --     --   end
  --     --
  --     --   clear()
  --     --
  --     --   local row = vim.api.nvim_win_get_cursor(0)[1] - 1
  --     --   vim.api.nvim_buf_set_extmark(0, ns, row, -1, {
  --     --     virt_text = {
  --     --       { string.format(" [%d/%d]", sc.current, sc.total), "Comment" },
  --     --     },
  --     --     virt_text_pos = "eol",
  --     --   })
  --     -- end
  --     --
  --     -- return {
  --     --   show = show,
  --     --   clear = clear,
  --     -- }
  --
  --     -- -- usage:
  --     -- local sc = require("searchcount_virt")
  --     --
  --     -- vim.api.nvim_create_autocmd({ "CursorMoved", "CmdlineLeave" }, {
  --     --   callback = function()
  --     --     if vim.v.hlsearch == 1 then
  --     --       sc.show()
  --     --     else
  --     --       sc.clear()
  --     --     end
  --     --   end,
  --     -- })
  --
  --     --
  --   end,
  -- },
}
