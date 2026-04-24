return {
  "mfussenegger/nvim-jdtls",
  ft = { "java" },
  dependencies = {
    "mfussenegger/nvim-dap",
    "mason-org/mason-lspconfig.nvim",
  },
  enabled = false,
  config = function()
    local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" })
    local workspace_dir = vim.fn.fnamemodify(root_dir, ":p") -- make sure it's an absolute path
    local data_dir = workspace_dir .. "/.jdtls"
    local config = {
      cmd = { "jdtls", "-data", data_dir },
      init_options = {},
      settings = {
        java = {
          format = { enabled = false },
        },
      },
    }

    require("jdtls").start_or_attach(config)
  end,
}
