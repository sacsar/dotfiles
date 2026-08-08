local map = vim.keymap.set

-- Diagnostics — jumps use built-in [d / ]d (nvim 0.10+).
-- Quickfix / loclist live under <leader>q* (moved off <leader>a* which sidekick
-- owns, and <leader>d which collides with the dap/metals debug namespace).
map("n", "<leader>qa", vim.diagnostic.setqflist, { desc = "Workspace diagnostics → qflist" })
map("n", "<leader>qe", function()
  vim.diagnostic.setqflist({ severity = "E" })
end, { desc = "Workspace errors → qflist" })
map("n", "<leader>qw", function()
  vim.diagnostic.setqflist({ severity = "W" })
end, { desc = "Workspace warnings → qflist" })
map("n", "<leader>qd", vim.diagnostic.setloclist, { desc = "Buffer diagnostics → loclist" })

map({ "n", "v" }, "<ScrollWheelUp>", "<C-y>")
map({ "n", "v" }, "<ScrollWheelDown>", "<C-e>")
-- Insert mode: <C-y>/<C-e> are completion shortcuts, so use <Cmd> to run
-- the normal-mode scroll commands without leaving insert mode.
map("i", "<ScrollWheelUp>", "<Cmd>normal! <C-y><CR>")
map("i", "<ScrollWheelDown>", "<Cmd>normal! <C-e><CR>")
-- Cursor doesn't follow scroll. Keep this here with the mouse behaviour
vim.opt.scrolloff = 0

-- blink.cmp's Tab fallback re-feeds <Tab> without noremap, causing an infinite
-- mapping loop with sidekick.nvim's expr <Tab> mapping. A global noremap wins
-- over both and simply inserts a tab (expanded to spaces via expandtab).
map("i", "<Tab>", "<Tab>", { noremap = true })
