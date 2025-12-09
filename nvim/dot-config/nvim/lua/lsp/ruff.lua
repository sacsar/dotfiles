vim.lsp.config("ruff", {
  on_attach = require("core.lsp").attach_organize_imports,
})
