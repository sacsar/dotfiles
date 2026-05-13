return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bufdelete = { enabled = true },
    gh = {},
    indent = { enabled = true },
    lazygit = { enabled = true },
    picker = { enabled = true },
    scratch = { enabled = true },
  },
  keys = {
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
  },
}
