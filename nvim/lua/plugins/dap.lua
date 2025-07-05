return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-dap-virtual-text",
      "nvim-dap-python",
      { "leoluz/nvim-dap-go", lazy = true },
    },
    keys = {
      {
        "<Leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "[DAP] toggle breakpoint",
      },
      {
        "<Leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("[DAP] Condition: "))
        end,
        desc = "[DAP] toggle breakpoint (condition)",
      },
      {
        "<Leader>DB",
        function()
          require("dap").clear_breakpoints()
        end,
        desc = "[DAP] clear breakpoints",
      },
      {
        "<Leader>de",
        function()
          require("dap").eval()
        end,
        desc = "[DAP] eval",
      },
      {
        "<Leader>dE",
        function()
          require("dap").eval(vim.fn.input("[DAP] Expression: "))
        end,
        desc = "[DAP] eval (expression)",
      },
      {
        "<Leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "[DAP] toggle REPL",
      },
      {
        "<Leader>dx",
        function()
          require("dap").terminate()
        end,
        desc = "[DAP] terminate",
      },
      {
        "<F6>",
        function()
          require("dap").restart()
        end,
        desc = "[DAP] restart",
      },
      {
        "<F7>",
        function()
          require("dap").step_back()
        end,
        desc = "[DAP] step back",
      },
      {
        "<F8>",
        function()
          require("dap").step_out()
        end,
        desc = "[DAP] step out",
      },
      {
        "<F9>",
        function()
          require("dap").step_into()
        end,
        desc = "[DAP] step into",
      },
      {
        "<F10>",
        function()
          require("dap").continue()
        end,
        desc = "[DAP] continue",
      },
      {
        "<F11>",
        function()
          require("dap").step_over()
        end,
        desc = "[DAP] step over",
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DiagnosticHint", linehl = "", numhl = "" })
      vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = " ", texthl = "DiagnosticInfo", linehl = "", numhl = "" }
      )

      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      { "nvim-neotest/nvim-nio", lazy = true },
    },
    lazy = true,
    opts = {
      layouts = {
        {
          elements = {
            "repl",
            "scopes",
            "console",
          },
          position = "bottom",
          size = 20,
        },
        {
          elements = {
            "breakpoints",
            "stacks",
            "watches",
          },
          position = "left",
          size = 40,
        },
      },
    },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = true,
    opts = {
      highlight_new_as_changed = true,
    },
  },
  {
    "nvim-telescope/telescope-dap.nvim",
    lazy = true,
    keys = {
      {
        "<Leader>dl",
        function()
          require("telescope").extensions.dap.list_breakpoints()
        end,
        desc = "dap.list_breakpoints",
      },
      {
        "<Leader>dpC",
        function()
          require("telescope").extensions.dap.configurations()
        end,
        desc = "dap.configurations",
      },
      {
        "<Leader>dpc",
        function()
          require("telescope").extensions.dap.commands()
        end,
        desc = "dap.commands",
      },
      {
        "<Leader>dpv",
        function()
          require("telescope").extensions.dap.variables()
        end,
        desc = "dap.variables",
      },
      {
        "<Leader>dpf",
        function()
          require("telescope").extensions.dap.frames()
        end,
        desc = "dap.frames",
      },
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    lazy = true,
    keys = {
      {
        "<Leader>dtm",
        function()
          require("dap-python").test_method()
        end,
        desc = "[DAP Python] test method",
      },
      {
        "<Leader>ptc",
        function()
          require("dap-python").test_class()
        end,
        desc = "[DAP Python] test class",
      },
      {
        "<Leader>ps <ESC>",
        function()
          require("dap-python").debug_selection()
        end,
        desc = "[DAP Python] debug selection",
      },
    },
    config = function()
      local dap = require("dap")
      local dap_python = require("dap-python")

      dap_python.setup("~/.local/share/virtualenvs/nvim-debugpy/bin/python")
      dap_python.test_runner = "pytest"

      local module_fmt = function()
        local module = vim.fn.expand("%:~:.")
        module = string.gsub(module, "/", ".")
        module = string.gsub(module, ".py$", "")
        return module
      end

      local configs = {
        {
          name = "Launch: Module",
          type = "python",
          request = "launch",
          redirectOutput = true,
          -- python = vim.fn.expand("~/.pyenv/shims/python"),
          python = vim.fn.exepath("~/.pyenv/shims/python"),
          module = module_fmt,
        },
        {
          name = "Launch: Module (args)",
          type = "python",
          request = "launch",
          redirectOutput = true,
          -- python = vim.fn.expand("~/.pyenv/shims/python"),
          python = vim.fn.exepath("~/.pyenv/shims/python"),
          module = module_fmt,
          args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " +")
          end,
        },
        {
          name = "Docker: Attach",
          type = "python",
          request = "attach",
          mode = "remote",
          connect = {
            port = 5678,
          },
          cwd = vim.fn.getcwd(),
          pathMappings = {
            {
              localRoot = vim.fn.getcwd(),
              remoteRoot = vim.fn.getcwd(),
            },
          },
          redirectOutput = true,
        },
      }

      for _, config in pairs(configs) do
        table.insert(dap.configurations.python, config)
      end
    end,
  },
}
