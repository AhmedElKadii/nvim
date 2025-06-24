return {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local null_ls = require("null-ls")
        null_ls.notify = function() end
		null_ls.setup({
			notify_format = "",
			log_level = 'off',
            diagnostics_format = "",
			diagnostics_on_open = false,
			diagnostics_on_save = false,
			sources = {
				null_ls.builtins.diagnostics.tidy,
				null_ls.builtins.diagnostics.stylelint,
				null_ls.builtins.formatting.prettier,
			},
			on_attach = function(client, bufnr)
				if client.server_capabilities.diagnosticProvider then
					vim.api.nvim_exec_autocmds("BufWritePost", { buffer = bufnr })
				end
			end,
		})

		-- weird diagnostics muting
		vim.api.nvim_create_autocmd("LspProgress", {
		  callback = function()
			return true
		  end
		})

		vim.opt.ruler = false
		vim.opt.laststatus = 3
		vim.lsp.handlers["$/progress"] = function() end
	end
}
