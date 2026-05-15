local map = vim.keymap.set

-- LSP keymaps not covered by nvim 0.11+ built-in defaults.
-- Built-ins already provide: K, grr (refs), gri (impl), grn (rename),
-- gra (code action), gO (doc symbol), i_<C-s> (signature help).
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf }
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gD", vim.lsp.buf.type_definition, opts)
    map("n", "gws", vim.lsp.buf.workspace_symbol, opts)
    map("n", "<leader>cL", vim.lsp.codelens.run, opts)
    map("n", "<leader>f", vim.lsp.buf.format, opts)
    -- metals-specific
    map("n", "<leader>ws", function()
      require("metals").hover_worksheet()
    end, opts)
  end,
})

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

map({ "n", "i", "v" }, "<ScrollWheelUp>", "<C-y>")
map({ "n", "i", "v" }, "<ScrollWheelDown>", "<C-e>")
-- Cursor doesn't follow scroll. Keep this here with the mouse behaviour
vim.opt.scrolloff = 0
