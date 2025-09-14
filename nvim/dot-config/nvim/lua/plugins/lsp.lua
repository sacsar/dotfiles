return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
      "jdtls",
      "pyright",
      "ruff",
    },
  },
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
    { "neovim/nvim-lspconfig" },
  },
  event = { "VeryLazy", "BufReadPre", "BufNewFile" },
}
