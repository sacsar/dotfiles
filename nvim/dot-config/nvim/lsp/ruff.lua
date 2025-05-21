vim.lsp.config("ruff", {
  on_attach = require("lsp").attach_organize_imports,
})
