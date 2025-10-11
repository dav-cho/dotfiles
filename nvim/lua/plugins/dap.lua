return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-dap-virtual-text",
      "nvim-dap-python",
      { "leoluz/nvim-dap-go", lazy = true },
      "js-dap",
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

  -- WIP

  {
    "js-dap",
    virtual = true,
    lazy = true,
    config = function()
      local dap = require("dap")
      dap.set_log_level("TRACE")

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        -- host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.expand("$HOME/.local/share/nvim/dap/js-debug/src/dapDebugServer.js"),
            "${port}",
          },
        },
      }
      dap.adapters["node"] = dap.adapters["pwa-node"]
      -- dap.adapters["pwa-chrome"] = dap.adapters["pwa-node"]

      -- require("dap.ext.vscode").json_decode = require("json5").parse
      -- require("dap.ext.vscode").load_launchjs(nil, {
      --   ["pwa-node"] = { "javascript", "typescript" },
      --   ["node"] = { "javascript", "typescript" },
      --   ["chrome"] = { "javascript", "typescript" },
      -- })
    end,
  },

  -- dap.adapters["pwa-node"] = {
  --   type = "server",
  --   host = "localhost",
  --   port = "${port}",
  --   executable = {
  --     command = "node",
  --     -- 💀 Make sure to update this path to point to your installation
  --     args = { "$HOME/.local/share/nvim/dap/js-debug/src/dapDebugServer.js", "${port}" },
  --   },
  -- }
  --
  -- dap.configurations["javascript"] = {
  --   {
  --     type = "pwa-node",
  --     request = "launch",
  --     name = "Launch file",
  --     program = "${file}",
  --     cwd = "${workspaceFolder}",
  --   },
  -- }
  --
  -- --------------------------------------------------
  --
  -- -- Use both for JS/TS files
  -- dap.configurations["javascript"] = {
  --   -- Attach to Node inside Docker (port-forwarded)
  --   {
  --     type = "pwa-node",
  --     request = "attach",
  --     name = "Typhon: attach (docker)",
  --     address = "localhost", -- adjust if your port-forward maps elsewhere
  --     port = 5858, -- must match your container's --inspect port
  --     restart = true,
  --     localRoot = "${workspaceFolder}",
  --     remoteRoot = "/app",
  --     sourceMaps = true,
  --   },
  --
  --   -- Run a single Mocha test with ts-node
  --   {
  --     type = "pwa-node",
  --     request = "launch",
  --     name = "Typhon: single unit test",
  --     program = "${workspaceFolder}/node_modules/mocha/bin/_mocha",
  --     args = {
  --       "--require",
  --       "ts-node/register",
  --       "--extension",
  --       "ts,js",
  --       "--ui",
  --       "bdd",
  --       "--timeout",
  --       "999999",
  --       "${workspaceFolder}/test/unit/businesslogic/ruleExplainability/portfolioEvaluations/formatters.spec.ts",
  --     },
  --     cwd = "${workspaceFolder}",
  --     env = {
  --       ALLOY_ENVIRONMENT = "test",
  --       ALLOY_VERSION = "test",
  --       NODE_ENV = "local",
  --       TZ = "UTC",
  --       TS_NODE_TRANSPILE_ONLY = "true",
  --       TS_NODE_FILES = "true",
  --     },
  --     -- VS Code-only fields are harmless if present; js-debug ignores unknowns in nvim-dap
  --     console = "integratedTerminal",
  --     outputCapture = "std",
  --     sourceMaps = true,
  --   },
  -- }
  --
  -- dap.configurations.typescript = dap.configurations.javascript
  --
  -- --------------------------------------------------

  -- {
  --   "js-dap",
  --   -- dependencies = { "mfussenegger/nvim-dap" },
  --   virtual = true,
  --   lazy = true,
  --   config = function()
  --     local dap = require("dap")
  --
  --     require("dap.ext.vscode").load_launchjs(nil, {
  --       ["pwa-node"] = { "javascript", "typescript" },
  --       ["node"] = { "javascript", "typescript" },
  --       ["chrome"] = { "javascript", "typescript" },
  --     })
  --
  --     -- require("dap").adapters["pwa-node"] = {
  --     dap.adapters["pwa-node"] = {
  --       type = "server",
  --       host = "localhost",
  --       port = "${port}",
  --       executable = {
  --         command = "node",
  --         -- 💀 Make sure to update this path to point to your installation
  --         -- args = { "$HOME/.local/share/nvim/dap/js-debug/src/dapDebugServer.js", "${port}" },
  --       },
  --     }
  --
  --     -- -- require("dap").configurations.javascript = {
  --     -- dap.configurations.javascript = {
  --     --   {
  --     --     type = "pwa-node",
  --     --     request = "launch",
  --     --     name = "Launch file",
  --     --     program = "${file}",
  --     --     cwd = "${workspaceFolder}",
  --     --   },
  --     -- }
  --
  --     -- Use both for JS/TS files
  --     -- dap.configurations["javascript"] = {
  --     --   -- Attach to Node inside Docker (port-forwarded)
  --     --   {
  --     --     type = "pwa-node",
  --     --     request = "attach",
  --     --     name = "Typhon: attach (docker)",
  --     --     address = "localhost", -- adjust if your port-forward maps elsewhere
  --     --     port = 5858, -- must match your container's --inspect port
  --     --     restart = true,
  --     --     localRoot = "${workspaceFolder}",
  --     --     remoteRoot = "/app",
  --     --     sourceMaps = true,
  --     --     executable = {
  --     --       command = "node",
  --     --       -- 💀 Make sure to update this path to point to your installation
  --     --       args = { "/path/to/js-debug/src/dapDebugServer.js", "${port}" },
  --     --     },
  --     --   },
  --     --
  --     --   -- Run a single Mocha test with ts-node
  --     --   {
  --     --     type = "pwa-node",
  --     --     request = "launch",
  --     --     name = "Typhon: single unit test",
  --     --     program = "${workspaceFolder}/node_modules/mocha/bin/_mocha",
  --     --     args = {
  --     --       "--require",
  --     --       "ts-node/register",
  --     --       "--extension",
  --     --       "ts,js",
  --     --       "--ui",
  --     --       "bdd",
  --     --       "--timeout",
  --     --       "999999",
  --     --       "${workspaceFolder}/test/unit/businesslogic/ruleExplainability/portfolioEvaluations/formatters.spec.ts",
  --     --     },
  --     --     cwd = "${workspaceFolder}",
  --     --     env = {
  --     --       ALLOY_ENVIRONMENT = "test",
  --     --       ALLOY_VERSION = "test",
  --     --       NODE_ENV = "local",
  --     --       TZ = "UTC",
  --     --       TS_NODE_TRANSPILE_ONLY = "true",
  --     --       TS_NODE_FILES = "true",
  --     --     },
  --     --     -- VS Code-only fields are harmless if present; js-debug ignores unknowns in nvim-dap
  --     --     console = "integratedTerminal",
  --     --     outputCapture = "std",
  --     --     sourceMaps = true,
  --     --   },
  --     -- }
  --
  --     -- dap.configurations.typescript = dap.configurations.javascript
  --
  --     dap.adapters["node"] = dap.adapters["pwa-node"]
  --     dap.adapters["pwa-chrome"] = dap.adapters["pwa-node"]
  --
  --     --------------------------------------------------
  --   end,
  -- },
  --
  -- {
  --   "mfussenegger/nvim-dap-python",
  --   lazy = true,
  --   keys = {
  --     {
  --       "<Leader>dtm",
  --       function()
  --         require("dap-python").test_method()
  --       end,
  --       desc = "[DAP Python] test method",
  --     },
  --     {
  --       "<Leader>ptc",
  --       function()
  --         require("dap-python").test_class()
  --       end,
  --       desc = "[DAP Python] test class",
  --     },
  --     {
  --       "<Leader>ps <ESC>",
  --       function()
  --         require("dap-python").debug_selection()
  --       end,
  --       desc = "[DAP Python] debug selection",
  --     },
  --   },
  --   config = function()
  --     local dap = require("dap")
  --     local dap_python = require("dap-python")
  --
  --     dap_python.setup("~/.local/share/virtualenvs/nvim-debugpy/bin/python")
  --     dap_python.test_runner = "pytest"
  --
  --     local module_fmt = function()
  --       local module = vim.fn.expand("%:~:.")
  --       module = string.gsub(module, "/", ".")
  --       module = string.gsub(module, ".py$", "")
  --       return module
  --     end
  --
  --     local configs = {
  --       {
  --         name = "Launch: Module",
  --         type = "python",
  --         request = "launch",
  --         redirectOutput = true,
  --         -- python = vim.fn.expand("~/.pyenv/shims/python"),
  --         python = vim.fn.exepath("~/.pyenv/shims/python"),
  --         module = module_fmt,
  --       },
  --       {
  --         name = "Launch: Module (args)",
  --         type = "python",
  --         request = "launch",
  --         redirectOutput = true,
  --         -- python = vim.fn.expand("~/.pyenv/shims/python"),
  --         python = vim.fn.exepath("~/.pyenv/shims/python"),
  --         module = module_fmt,
  --         args = function()
  --           local args_string = vim.fn.input("Arguments: ")
  --           return vim.split(args_string, " +")
  --         end,
  --       },
  --       {
  --         name = "Docker: Attach",
  --         type = "python",
  --         request = "attach",
  --         mode = "remote",
  --         connect = {
  --           port = 5678,
  --         },
  --         cwd = vim.fn.getcwd(),
  --         pathMappings = {
  --           {
  --             localRoot = vim.fn.getcwd(),
  --             remoteRoot = vim.fn.getcwd(),
  --           },
  --         },
  --         redirectOutput = true,
  --       },
  --     }
  --
  --     for _, config in pairs(configs) do
  --       table.insert(dap.configurations.python, config)
  --     end
  --   end,
  -- },

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
