return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		-- add any options here
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	views = {
		hover = {
			border = { style = "double" },
		},
		popupmenu = {
			border = { style = "double" },
		},
		cmdline_popup = {
			border = { style = "double" },
		},
	},

	config = function()
		require("noice").setup({
			cmdline = {
				enable = true,
				view = "cmdline",
				opts = {
					min_width = 0,
					min_height = 0,
				},
			},
			routes = {
				{
					view = "cmdline",
					filter = {
						event = "msg_showmode",
					},
				},
			},
		})
	end,
}
