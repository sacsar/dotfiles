return {
  "mfussenegger/nvim-dap",
  lazy = true,
  dependencies = {},
  -- Copied from LazyVim/lua/lazyvim/plugins/extras/dap/core.lua and
  -- modified.
  keys = {
    {
      "<leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Toggle Breakpoint",
    },

    {
      "<leader>dc",
      function()
        require("dap").continue()
      end,
      desc = "Continue",
    },

    {
      "<leader>dC",
      function()
        require("dap").run_to_cursor()
      end,
      desc = "Run to Cursor",
    },

    {
      "<leader>dT",
      function()
        require("dap").terminate()
      end,
      desc = "Terminate",
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    ---@type MasonNvimDapSettings
    opts = {
      -- This line is essential to making automatic installation work
      -- :exploding-brain
      handlers = {},
      automatic_installation = false,
      -- DAP servers: these will be installed by mason-tool-installer.nvim
      -- for consistency.
      ensure_installed = {
        "java-debug-adapter",
      },
    },
    dependencies = {
      "mfussenegger/nvim-dap",
      "mason-org/mason.nvim",
    },
  },
}
