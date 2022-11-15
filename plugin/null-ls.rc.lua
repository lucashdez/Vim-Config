local status, null_ls = pcall(require, "null-ls")
if not status then
	return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

null_ls.setup({
	debug = true,
	sources = {
		null_ls.builtins.formatting.prettierd.with({
			extra_args = {
				"--tab-width=2",
			},
		}),
		null_ls.builtins.diagnostics.eslint_d.with({
			diagnostics_format = "[eslint] #{m}\n(#{c})",
		}),
		null_ls.builtins.diagnostics.fish,

		--PROPIOS
		--CODE ACTIONS
		null_ls.builtins.code_actions.ltrs,
		--LINTER
		null_ls.builtins.diagnostics.ltrs,
		null_ls.builtins.diagnostics.cpplint,
		--FORMAT
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.rustfmt.with({
			extra_args = { "--edition=2021" },
		}),
		null_ls.builtins.formatting.csharpier,
		--------------
	},

	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end,
})

vim.api.nvim_create_user_command("DisableLspFormatting", function()
	vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
end, { nargs = 0 })
