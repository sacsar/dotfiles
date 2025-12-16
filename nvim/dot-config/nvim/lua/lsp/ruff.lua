vim.lsp.config("ruff", {
  on_attach = require("core.nvim.lsp").attach_organize_imports,
})
