local map = vim.keymap.set
local unmap = vim.keymap.del

-- telescope
local builtin = require("telescope.builtin")
map('n', '<leader>ff', builtin.find_files, {})
map('n', '<leader>f', builtin.live_grep, {})

-- hop
map('n', 'f', ':HopWord<CR>', {})

-- open
map('n', '<leader>op', ':!open %<CR>', { noremap = true, silent = true })

-- open in finder
map('n', '<leader>rv', ':!open $(dirname %)<CR>', { noremap = true, silent = true })

-- spyder binds
map("n", "<leader>r", ":IronSend<CR>")
map("v", "<leader>r", ":IronSendVisual<CR>")

-- error popup
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show Error Message" })

-- compile
map('n', '<F3>', ':lua Compile()<CR>', { noremap = true, silent = true })
-- compile and run
map('n', '<F5>', ':lua CompileAndRun()<CR>', { noremap = true, silent = true })
-- Open compiler
map('n', '<F6>', "<cmd>CompilerOpen<cr>", { noremap = true, silent = true })

-- Redo last selected option
map('n', '<S-F6>',
     "<cmd>CompilerStop<cr>" -- (Optional, to dispose all tasks before redo)
  .. "<cmd>CompilerRedo<cr>",
 { noremap = true, silent = true })

-- Toggle compiler results
map('n', '<S-F7>', "<cmd>CompilerToggleResults<cr>", { noremap = true, silent = true })

-- arduino
map('n', '<leader>au', ':!arduino-cli compile --upload<CR>', { noremap = true, silent = true })
map('n', '<leader>sm', ':term screen /dev/ttyUSB0 9600<CR>', { noremap = true, silent = true })

-- codesnap
map('x', '<C-s>', ':CodeSnap<CR>', {})
map('x', '<C-S-s>', ':CodeSnapSave<CR>', {})

-- minty
-- map('n', '<C-c>', ':Huefy<CR>', {})

-- color picker
map("n", "<C-c>", "<cmd>CccPick<cr>", {})
map("n", "<C-S-c>", "<cmd>CccConvert<cr>", {})

-- debugging
map('n', '<F1>', function() require('dap').toggle_breakpoint() end)
map('n', '<F2>', function() require('dap').continue() end)

-- zathura
map('n', '<leader>z', ':!zathura <C-r>=expand("%:p:r") .. ".pdf"<CR> &<CR>', { noremap = true, silent = true })

-- line moving
map('n', '<C-S-k>', 'VxkP', {})
map('n', '<C-S-j>', 'Vxp', {})
map('v', '<C-S-k>', 'xkP<Esc>', {})
map('v', '<C-S-j>', 'xp<Esc>', {})

-- window management
-- switching
map('n', '<C-h>', '<C-W>h', {})
map('n', '<C-j>', '<C-W>j', {})
map('n', '<C-k>', '<C-W>k', {})
map('n', '<C-l>', '<C-W>l', {})

map('n', '<C-x>', ':q<CR>', {})

-- buffer management
map('n', '--', ':bd<CR>', {})
map('n', '++', ':tabe<CR>', {})
-- switching
map('n', 'H', ':bprev<CR>', {})
map('n', 'L', ':bnext<CR>', {})
-- splitting
map('n', '|', ':vsplit<CR>', {})
map('n', '_', ':split<CR>', { noremap = true, silent = true })

-- todo
map('n', '<leader>ft', ':Trouble todo<CR>', {})

-- oil
map('n', '<C-o>', ':Oil<CR>', {})

-- chatgpt
-- map('n', '<leader>cc', ':ChatGPT<CR>', {}) -- don't have an api key yet

-- toggle copilot
map('n', '<leader>tc', ':lua ToggleCopilot()<CR>', { noremap = true, silent = true })

-- neotree
-- map('n', '<leader>e', ':Neotree toggle<CR>', {})

-- telescope file browser
-- map('n', '<leader>e', ':Telescope file_browser<CR>', {})

-- nvim tree
map('n', '<leader>e', ':NvimTreeToggle<CR>', {})

-- dap
-- In lua/config/debugger-keybinds.lua
local dap = require("dap")
local dapui = require("dapui")

-- Core debugging
map("n", "<F6>", function() dap.continue() end, { desc = "Debug: Continue" })
map("n", "<F10>", function() dap.step_over() end, { desc = "Debug: Step Over" })
map("n", "<F11>", function() dap.step_into() end, { desc = "Debug: Step Into" })
map("n", "<F12>", function() dap.step_out() end, { desc = "Debug: Step Out" })

-- Breakpoints
map("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint" })
map("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = "Debug: Set Conditional Breakpoint" })
map("n", "<leader>dl", function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = "Debug: Set Log Point" })

-- UI control
vim.keymap.set("n", "<leader>dr", function() dap.repl.open() end, { desc = "Debug: Open REPL" })
vim.keymap.set("n", "<leader>du", function() dapui.toggle() end, { desc = "Debug: Toggle UI" })

-- diagnostics improvements
vim.keymap.set('n', '<C-e>', function()
  vim.diagnostic.open_float({ scope = 'line', border = 'rounded' })
end, { desc = 'Show diagnostics in floating window' })

vim.keymap.set('n', '<C-S-e>', function()
  vim.diagnostic.open_float({ scope = 'buffer', border = 'rounded' })
end, { desc = 'Show all buffer diagnostics in floating window' })

-- Telescope integration
vim.keymap.set("n", "<leader>dtc", function() require('telescope').extensions.dap.commands{} end, { desc = "Debug: Commands" })
vim.keymap.set("n", "<leader>dtb", function() require('telescope').extensions.dap.list_breakpoints{} end, { desc = "Debug: List Breakpoints" })
vim.keymap.set("n", "<leader>dtv", function() require('telescope').extensions.dap.variables{} end, { desc = "Debug: Variables" })
vim.keymap.set("n", "<leader>dtf", function() require('telescope').extensions.dap.frames{} end, { desc = "Debug: Frames" })

-- neotree diagnostics
map('n', '<leader>nd', ':Neotree diagnostics reveal bottom<CR>', {})

-- terminal
map('n', '<C-t>', ':below 10split | terminal<CR>clear<CR>', {noremap = true, silent = true})
vim.cmd('autocmd TermOpen * startinsert')

-- Allow window navigation from terminal mode (like normal buffers)
vim.api.nvim_set_keymap('t', '<C-h>', '<C-\\><C-n><C-w>h', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<C-j>', '<C-\\><C-n><C-w>j', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<C-k>', '<C-\\><C-n><C-w>k', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<C-l>', '<C-\\><C-n><C-w>l', {noremap = true, silent = true})

-- Optional: Easy way to exit terminal mode
vim.api.nvim_set_keymap('t', '<C-x>', 'exit<CR>', {noremap = true, silent = true})

vim.cmd('autocmd BufWinEnter,WinEnter term://* startinsert')

-- lsp
map('n', 'K', vim.lsp.buf.hover, {})
map('n', '<leader>gd', vim.lsp.buf.definition, {})
map('n', '<leader>ca', vim.lsp.buf.code_action, {})
map('n', '<leader>gr', vim.lsp.buf.references, {})
map('n', '<leader>F', vim.lsp.buf.format, {})

-- custom functions
map('n', '<leader>n', ':DetermineFileType ', { noremap = true, silent = true })

-- quality of life
map('n', '>', '<C-a>', {})
map('n', '<', '<C-x>', {})
map('n', ';', ':', {})
map("n", "q", "q", { noremap = true })
