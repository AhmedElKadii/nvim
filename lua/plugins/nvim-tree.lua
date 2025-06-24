return {
	"nvim-tree/nvim-tree.lua",
	config = function()
		require("nvim-tree").setup({
			sort = {
				sorter = "case_sensitive",
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = true,
			},
			git = {
				enable = false,
			},
		})
		vim.cmd("colorscheme lushwal")
	end
}
