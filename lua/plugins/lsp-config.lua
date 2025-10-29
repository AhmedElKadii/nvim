return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					-- Existing servers
					"lua_ls",
					"clangd",
					"markdown_oxide",
					"basedpyright",
					"hydra_lsp",
					"ols",
					"html",
					"cssls",
					"omnisharp",
					"eslint",
					"emmet_ls",
					"tailwindcss",
					"astro",
					"svelte",
					"prismals"
				},
			})
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("typescript-tools").setup({
				capabilities = capabilities,
				-- No need to set on_attach here - your existing LSP keymaps will work automatically
				-- Only add TypeScript-specific commands that aren't part of standard LSP
				on_attach = function(client, bufnr)
					local opts = { buffer = bufnr, silent = true }
					-- Only TypeScript-specific commands (not available via standard LSP)
					vim.keymap.set("n", "<leader>to", ":TSToolsOrganizeImports<CR>", opts)
					vim.keymap.set("n", "<leader>tr", ":TSToolsRemoveUnusedImports<CR>", opts)
					vim.keymap.set("n", "<leader>ta", ":TSToolsAddMissingImports<CR>", opts)
					vim.keymap.set("n", "<leader>tf", ":TSToolsFixAll<CR>", opts)
				end,
				settings = {
					separate_diagnostic_server = true,
					publish_diagnostic_on = "insert_leave",
					expose_as_code_action = { "fix_all", "add_missing_imports", "remove_unused" },
					tsserver_max_memory = 4096,
					complete_function_calls = false,
					include_completions_with_insert_text = true,
					code_lens = "off",
					disable_member_code_lens = true,
					jsx_close_tag = {
						enable = true,
						filetypes = { "javascriptreact", "typescriptreact" },
					}
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			lspconfig.ols.setup({
				capabilities = capabilities,
				init_options = {
					checker_args = "-strict-style",
					collections = {
						{ name = "shared", path = vim.fn.expand('$HOME/odin-lib') }
					},
				},
			})

			-- Existing configurations
			lspconfig.lua_ls.setup({ capabilities = capabilities })
			lspconfig.omnisharp.setup({
				capabilities = capabilities,
				root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj", ".git"),
				enable_roslyn_analyzers = true,
				organize_imports_on_format = true,
				enable_import_completion = true,
				handlers = {
					["textDocument/definition"] = require("omnisharp_extended").handler,
				},
			})
			lspconfig.gdscript.setup({ capabilities = capabilities })
			lspconfig.clangd.setup({
				capabilities = capabilities,
				cmd = { "clangd" },
				filetypes = { "c", "cpp", "arduino", "ino" },
				root_dir = lspconfig.util.root_pattern("*.ino", "arduino-cli.yaml"),
			})
			lspconfig.basedpyright.setup({ capabilities = capabilities })
			lspconfig.html.setup({ capabilities = capabilities })
			lspconfig.jsonls.setup({ capabilities = capabilities })

			-- REMOVED: lspconfig.ts_ls.setup({ capabilities = capabilities })
			-- This is now handled by typescript-tools.nvim

			lspconfig.markdown_oxide.setup({ capabilities = capabilities })
			lspconfig.hydra_lsp.setup({ capabilities = capabilities })

			-- Additional web development configurations
			lspconfig.cssls.setup({ capabilities = capabilities })
			lspconfig.eslint.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
			})
			lspconfig.emmet_ls.setup({
				capabilities = capabilities,
				filetypes = {
					"html", "typescriptreact", "javascriptreact", "css", "sass", 
					"scss", "less", "vue", "astro", "svelte"
				},
			})
			lspconfig.tailwindcss.setup({ capabilities = capabilities })
			lspconfig.volar.setup({
				capabilities = capabilities,
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			})
			lspconfig.astro.setup({ capabilities = capabilities })
			lspconfig.svelte.setup({ capabilities = capabilities })
			lspconfig.prismals.setup({ capabilities = capabilities })
		end,
	},
}
