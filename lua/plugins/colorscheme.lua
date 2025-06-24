return {
	{
		"ellisonleao/gruvbox.nvim",
		-- priority = 1000,
		opts = {
			styles = {
				float = "transparent",
			},
		},
		config = function()
			require("gruvbox").setup({
				overrides = {
					-- Customize specific highlights
					NormalFloat = { bg = "NONE" },
					FloatBorder = { bg = "NONE" },
					Pmenu = { bg = "NONE" },
					PmenuSel = { bg = "#3c3836" }, -- Match Gruvbox background
					-- Add more highlight groups as needed
				},
			})
		end,
	},
	{
		"savq/melange-nvim",
	},
	{
		"folke/tokyonight.nvim",
		opts = {
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
	},
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("everforest").setup({
				transparent_background_level = 2, -- Set this to 1 or 2 for more control over transparency
				on_highlights = function(hl, palette)
					-- Customize diagnostic highlights
					hl.DiagnosticError = { fg = palette.red, bg = palette.none, sp = palette.red }
					hl.DiagnosticWarn = { fg = palette.yellow, bg = palette.none, sp = palette.yellow }
					hl.DiagnosticInfo = { fg = palette.blue, bg = palette.none, sp = palette.blue }
					hl.DiagnosticHint = { fg = palette.green, bg = palette.none, sp = palette.green }
				end,
			})

			-- Set background to 'none' for transparency
			vim.cmd("hi Normal guibg=none")
			vim.cmd("hi NormalFloat guibg=none") -- Make floating windows transparent
			vim.cmd("hi FloatBorder guibg=none") -- Make floating window borders transparent
			vim.cmd("hi SignColumn guibg=none") -- For sign column transparency
			vim.cmd("hi LineNr guibg=none") -- For line number transparency
			vim.cmd("hi EndOfBuffer guibg=none") -- To hide '~' symbols
		end,
	},
	{
		"ntk148v/komau.vim",
	},
	{
		"jaredgorski/fogbell.vim",
	},
	{
		"zenbones-theme/zenbones.nvim",
		dependencies = "rktjmp/lush.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.zenbones_darken_comments = 45
			vim.g.zenbones_compat = 1
		end
	},
}
