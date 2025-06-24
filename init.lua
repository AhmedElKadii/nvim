-- leader map
vim.g.mapleader = " "
vim.opt.termguicolors = true

require("config.lazy")
require("config.options")
require("config.keybinds")
require("config.custom-functions")

vim.cmd("hi Normal guibg=none")
vim.cmd("hi NormalFloat guibg=none") -- Make floating windows transparent
vim.cmd("hi FloatBorder guibg=none") -- Make floating window borders transparent
vim.cmd("hi SignColumn guibg=none") -- For sign column transparency
vim.cmd("hi LineNr guibg=none") -- For line number transparency
vim.cmd("hi EndOfBuffer guibg=none") -- To hide '~' symbols
vim.cmd("hi NvimTreeNormal guibg=none") -- Make Nvim Tree background transparent
vim.cmd("hi NvimTreeEndOfBuffer guibg=none") -- Make end of buffer in Nvim Tree transparent
vim.cmd [[
  hi NvimTreeNormal guibg=#2B2F2F
  hi NvimTreeFolderIcon guifg=#D9A441
  hi NvimTreeFolderName guifg=#D9A441
  hi NvimTreeOpenedFolderName guifg=#D47558
  hi NvimTreeEmptyFolderName guifg=#C37A63
  hi NvimTreeIndentMarker guifg=#907060
  hi NvimTreeGitDirty guifg=#D47558
  hi NvimTreeGitIgnored guifg=#8C8C8C
  hi NvimTreeGitStaged guifg=#79A0B1
]]
vim.cmd [[
  hi! link @type.builtin.c Type
  hi! link Special Type
  hi! Type guifg=#C47F67
]]

-- vim.api.nvim_create_autocmd("BufWritePost", {
--   pattern = "~/.local/src/dwmblocks/config.h",
--   callback = function()
--     -- Change directory, build, install, then restart dwmblocks
--     local cmd = [[
--       cd ~/.local/src/dwmblocks/ &&
--       sudo make install &&
--       killall -q dwmblocks &&
--       setsid dwmblocks &
--     ]]
--     -- Run the shell commands asynchronously
--     vim.fn.jobstart(cmd, {detach = true})
--   end,
-- })

vim.cmd("colorscheme lushwal")
