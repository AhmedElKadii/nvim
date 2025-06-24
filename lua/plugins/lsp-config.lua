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
				cmd = { "OmniSharp" },
				root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj"),
				enable_roslyn_analyzers = true,
				organize_imports_on_format = true,
				enable_import_completion = true,
				handlers = {
					["textDocument/definition"] = require('omnisharp_extended').handler,
				}
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
            lspconfig.ts_ls.setup({ capabilities = capabilities })
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
