return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local colors = require("lualine.utils.utils").extract_highlight_colors('Normal', 'bg')  -- Get the background color from your theme
    require("lualine").setup({
      options = {
        theme = {
          normal = {
            a = { bg = colors, fg = "#ebdbb2", gui = 'bold' },  -- Set text color and bold effect for mode
            b = { bg = colors, fg = "#ebdbb2" },  -- Git branch color
            c = { bg = 'NONE', fg = "#ebdbb2" },  -- Make the center section transparent
          },
          inactive = {
            a = { bg = 'NONE', fg = "#ebdbb2" },
            b = { bg = 'NONE', fg = "#ebdbb2" },
            c = { bg = 'NONE', fg = "#ebdbb2" },
          },
        },
        component_separators = '',
        section_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'filename' },
        lualine_x = {},
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
      },
    })
  end,
}
