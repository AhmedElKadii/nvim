return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},

	require("neo-tree").setup({
		sources = {
			"filesystem",
			"buffers",
			"git_status",
			"diagnostics",
		},
		diagnostics = {
			auto_preview = {
				enabled = false,
				preview_config = {},
				event = "neo_tree_buffer_enter",
			},
			bind_to_cwd = true,
			diag_sort_function = "severity",
			follow_current_file = {
				enabled = true,
				always_focus_file = false,
				expand_followed = true,
				leave_dirs_open = false,
				leave_files_open = false,
			},
			group_dirs_and_files = true,
			group_empty_dirs = true,
			show_unloaded = true,
			refresh = {
				delay = 100,
				event = "vim_diagnostic_changed",
				max_items = 10000,
			},
		},
	})
}
