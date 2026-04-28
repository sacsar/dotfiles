return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bufdelete = { enabled = true },
    indent = { enabled = true },
    lazygit = { enabled = true },
    scratch = { enabled = true },
  },
}
