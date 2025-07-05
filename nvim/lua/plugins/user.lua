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
  {
    dir = "dav.scratch",
    name = "dav.scratch",
    virtual = true,
    lazy = true,
    keys = {
      {
        "<Leader><Leader>",
        function()
          require("dav.scratch").toggle()
        end,
        desc = "[dav.scratch] toggle",
      },
    },
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
          row = math.floor((vim.o.lines - height) / 2) - 1,
          col = math.floor((vim.o.columns - width) / 2),
          border = "single",
        })
        return win
      end

      M.open = function()
        local buf = get_buf()
        local win = open_win(buf)

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
}
