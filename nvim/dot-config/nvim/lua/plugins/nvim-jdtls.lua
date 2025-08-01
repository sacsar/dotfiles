return {
  "mfussenegger/nvim-jdtls",
  ft = { "java" },
  dependencies = {
    "mfussenegger/nvim-dap",
    "mason-org/mason-lspconfig.nvim",
  },
  config = function()
    local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" })
    local workspace_dir = vim.fn.fnamemodify(root_dir, ":h") -- make sure it's an absolute path
    local config = {
      cmd = { "jdtls", "-data", workspace_dir },
      init_options = {},
    }

    require("jdtls").start_or_attach(config)
  end,
}
