local tools = require("core.tools")

return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = tools.ensure_installed,
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        },
      },
      -- make sure we have the default lsp-configs
      { "neovim/nvim-lspconfig" },
    },
    event = { "VeryLazy", "BufReadPre", "BufNewFile" },
  },
}
