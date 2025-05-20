if vim.fn.has("nvim-0.11") == 0 then
  local lspconfig = require("lspconfig")
  local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()

  lspconfig.pyright.setup({
    capabilities = lsp_capabilities,
  })
  lspconfig.ruff.setup({})

  lspconfig.clangd.setup({
    capabilities = lsp_capabilities,
  })

  lspconfig.clojure_lsp.setup({
    capabilities = lsp_capabilities,
  })
else
  vim.lsp.enable({
    "pyright",
    "ruff",
    "clangd",
    "clojure_lsp",
    "lua_ls",
  })
end
