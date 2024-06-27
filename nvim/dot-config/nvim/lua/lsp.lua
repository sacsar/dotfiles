local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.pyright.setup({
    capabilities = lsp_capabilities
})
lspconfig.ruff.setup{}
