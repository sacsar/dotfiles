if vim.fn.has("nvim-0.11") then
	vim.lsp.enable("ruff")
	vim.lsp.enable("clangd")
	vim.lsp.enable("clojure_lsp")
	vim.lsp.enable("pyright")
	vim.lsp.enable("lua_ls")
else
	local lspconfig = require("lspconfig")
	local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

	lspconfig.pyright.setup({
		capabilities = lsp_capabilities,
	})
	lspconfig.ruff.setup({})

	lspconfig.clangd.setup({
		capabilities = lsp_capabalities,
	})

	lspconfig.clojure_lsp.setup({
		capabilities = lsp_capabalities,
	})
end
