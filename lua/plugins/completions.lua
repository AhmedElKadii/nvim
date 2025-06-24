return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				sorting = {
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						cmp.config.compare.kind,  -- Prioritize by completion kind
						-- Other comparators...
					}
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				window = {
					completion = cmp.config.window.bordered({
						border = "double",
						winhighlight = "Normal:None,FloatBorder:None,CursorLine:PmenuSel,Search:None",
					}),
					documentation = cmp.config.window.bordered({
						border = "double",
						winhighlight = "Normal:None,FloatBorder:None,CursorLine:PmenuSel,Search:None",
					}),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-e>"] = cmp.mapping.complete(),
					["<C-d>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- For luasnip users.
					{ name = "lua-latex-symbols", option = { cache = true } },
				}, {
					{ name = "buffer" },
				}),
			})

			-- Make nvim-cmp's completion and documentation windows transparent
			vim.cmd("hi PMenu guibg=none") -- Make the completion window transparent
			vim.cmd("hi PmenuSel guibg=none") -- Make the selected item in the completion window transparent
			vim.cmd("hi PmenuSbar guibg=none") -- Transparent scrollbar background
			vim.cmd("hi PmenuThumb guibg=none") -- Transparent scrollbar thumb

			vim.cmd("hi NormalFloat guibg=none") -- Transparent background for floating windows (documentation)
			vim.cmd("hi FloatBorder guibg=none") -- Transparent borders for floating windows
		end,
	},
}
