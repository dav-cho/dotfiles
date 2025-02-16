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
    dir = "dav.comment",
    name = "dav.comment",
    virtual = true,
    -- lazy = true,
    event = "VeryLazy",
    keys = {
      -- {
      --   "<leader>\\",
      --   function()
      --     require("dav.comment").foo()
      --   end,
      -- },
      {
        "<leader><leader>",
        "O-- TODO<Esc>",
      },
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
}
