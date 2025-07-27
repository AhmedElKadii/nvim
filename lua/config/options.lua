-- disable mouse
vim.cmd("set mouse=")
-- indent settings
vim.cmd("set noexpandtab") -- Keep tabs instead of spaces

vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "html", "css", "javascript", "typescript", "jsx", "tsx", "yaml", "yml" },
    callback = function()
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "cs", "c", "cpp" },
    callback = function()
        vim.opt.tabstop = 4
        vim.opt.shiftwidth = 4
    end,
})

-- side numbers
vim.cmd("set nocursorline")

-- true colour
vim.o.termguicolors = true
vim.opt.termguicolors = true

-- clipboard
vim.cmd("set clipboard^=unnamedplus")

-- define empty signs for diagnostics to hide the letters in the gutter
vim.fn.sign_define("DiagnosticSignError", { text = "", numhl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", numhl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", numhl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", numhl = "DiagnosticSignHint" })

-- diagnostics improvements
vim.diagnostic.config({
  virtual_text = true,  -- Enable inline diagnostics
  signs = true,         -- Show signs in the sign column
  underline = true,     -- Underline the text with an error
  update_in_insert = false,
  severity_sort = true,
})

-- Apply the same style to LSP hover and signature help
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = "double"
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = "double"
  }
)

-- Make the diagnostic float window transparent to match your completion window
vim.cmd("hi DiagnosticFloat guibg=none")
vim.cmd("hi DiagnosticFloatBorder guibg=none")

-- fundo
vim.o.undofile = true

-- dap
-- In lua/config/debugger-options.lua
local dap = require("dap")
local dapui = require("dapui")

-- Set up UI
dapui.setup({
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.25 },
        { id = "breakpoints", size = 0.25 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.25 },
      },
      position = "left",
      size = 40
    },
    {
      elements = {
        { id = "repl", size = 0.5 },
        { id = "console", size = 0.5 },
      },
      position = "bottom",
      size = 10
    },
  },
})

-- Virtual text options
require("nvim-dap-virtual-text").setup({
  enabled = true,
  enabled_commands = true,
  highlight_changed_variables = true,
  highlight_new_as_changed = false,
  show_stop_reason = true,
  commented = false,
  virt_text_pos = 'eol',
  all_frames = false,
  virt_lines = false,
  virt_text_win_col = nil
})

-- Automatically open/close DAP UI
dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

-- quality of life
vim.cmd("set showtabline=0")
vim.cmd("set scrolloff=3")

-- vim specifics
vim.cmd("set encoding=UTF-8")
vim.env.DOTNET_ROOT = '/usr/local/share/dotnet'

-- disable treesitter for latex
vim.api.nvim_create_autocmd({ "FIleType" }, { pattern = "tex" , group = optional_group, command = "TSBufDisable highlight" })

-- set coceal level
vim.cmd("set conceallevel=2")

-- lsp logging
require('vim.lsp.log').set_level(vim.lsp.log_levels.OFF)
