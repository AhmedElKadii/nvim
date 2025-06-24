-- In your plugins file (e.g., lua/plugins/debugging.lua)
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-telescope/telescope-dap.nvim"
    },
    config = function()
      local dap = require("dap")
      
      -- C/C++ Debugger (lldb-vscode)
      dap.adapters.lldb = {
        type = "executable",
        command = "/usr/bin/lldb-vscode", -- Adjust path based on your system
        name = "lldb"
      }
      
      -- Odin debugger (using LLDB as backend since Odin uses LLVM)
      dap.adapters.odin = {
        type = "executable",
        command = "/usr/bin/lldb-vscode", -- Same as C debugger
        name = "odin"
      }
      
      -- C configurations
      dap.configurations.c = {
        {
          name = "Launch",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
          runInTerminal = false,
          env = function()
            local variables = {}
            for k, v in pairs(vim.fn.environ()) do
              table.insert(variables, string.format("%s=%s", k, v))
            end
            return variables
          end,
        },
        {
          name = "Attach to process",
          type = "lldb",
          request = "attach",
          pid = require("dap.utils").pick_process,
          args = {},
          cwd = "${workspaceFolder}",
        }
      }
      
      -- Odin configurations
      dap.configurations.odin = {
        {
          name = "Launch Odin Program",
          type = "odin",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
          runInTerminal = false,
        }
      }
      
      -- Load virtual text plugin
      require("nvim-dap-virtual-text").setup()
      
      -- Telescope integration
      require('telescope').load_extension('dap')
      
      -- Load options and keybinds
      require("config.debugger-options")
      require("config.debugger-keybinds")
    end
  },
}
