return {
  "Vigemus/iron.nvim",
  config = function()
    local iron = require("iron.core")

    iron.setup({
      config = {
        -- Define REPLs
        repl_definition = {
          python = {
            -- Ensure `ipython` is properly detected
            command = { "ipython", "--no-autoindent" }
          }
        },
        -- How to open REPL (you can change 'vsplit' to 'horizontal split' if you prefer)
        repl_open_cmd = "vsplit",
      },
      -- Keymaps for sending text to REPL
      keymaps = {
        send_motion = "<leader>sc",
        visual_send = "<leader>sc",
        send_file = "<leader>sf",
        send_line = "<leader>sl",
        send_until_cursor = "<leader>su",
        send_mark = "<leader>sm",
        mark_motion = "<leader>mc",
        mark_visual = "<leader>mc",
        remove_mark = "<leader>md",
        cr = "<leader>s<CR>",
        interrupt = "<leader>s<Space>",
        exit = "<leader>sq",
        clear = "<leader>cl",
      },
      -- Enable REPL persistence
      highlight = { italic = true }
    })
  end
}
