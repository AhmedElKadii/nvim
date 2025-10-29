return {
  "nvim-lualine/lualine.nvim",
  dependencies = { 
    "nvim-tree/nvim-web-devicons",
    "oncomouse/lushwal.nvim",
  },
  config = function()
    -- Hide the default mode text (-- INSERT --, -- VISUAL --, etc.)
    vim.opt.showmode = false
    
    require("lualine").setup({
      options = {
        theme = 'auto',
        component_separators = '',
        section_separators = '',
      },
      sections = {
        lualine_a = {
          {
            'mode',
            color = { fg = 'white', bg = 'none', gui = 'bold' },
          }
        },
        lualine_b = {
          {
            'branch',
            color = { fg = 'white', bg = 'none' },
          }
        },
        lualine_c = {
          {
            'filename',
            color = { fg = 'white', bg = 'none' },
          }
        },
        lualine_x = {},
        lualine_y = {
          {
            'progress',
            color = { fg = 'white', bg = 'none' },
          }
        },
        lualine_z = {
          {
            'location',
            color = { fg = 'white', bg = 'none' },
          }
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            'filename',
            color = { fg = 'white', bg = 'none' },
          }
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
          {
            'location',
            color = { fg = 'white', bg = 'none' },
          }
        },
      },
    })
    
    -- Only clear the base StatusLine backgrounds, leave lualine sections alone
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.cmd([[
          highlight! StatusLine guibg=NONE ctermbg=NONE
          highlight! StatusLineNC guibg=NONE ctermbg=NONE
        ]])
      end,
    })
    
    vim.cmd([[
      highlight! StatusLine guibg=NONE ctermbg=NONE
      highlight! StatusLineNC guibg=NONE ctermbg=NONE
    ]])
  end,
}
