local tools = require("core.nvim.tools")

local M = {}

local function attach_organize_imports(client, bufnr)
  -- Set up OrganizeImports if supported
  if client.supports_method("textDocument/codeAction") then
    vim.api.nvim_buf_create_user_command(bufnr, "OrganizeImports", function()
      local params = vim.lsp.util.make_range_params()
      params.context = { only = { "source.organizeImports" } }

      local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000)
      if not result then
        return
      end

      for _, res in pairs(result) do
        for _, action in pairs(res.result or {}) do
          if action.edit or type(action.command) == "table" then
            if action.edit then
              vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
            end
            if type(action.command) == "table" then
              vim.lsp.buf.execute_command(action.command)
            end
          else
            vim.lsp.buf.execute_command(action)
          end
        end
      end
    end, { desc = "Organize imports using LSP" })
  end
end

if vim.version.lt(vim.version(), { 0, 11, 0 }) then
  local lspconfig = require("lspconfig")
  local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()

  for _, lsp in ipairs(tools.enabled_lsps) do
    lspconfig[lsp].setup({ capabilities = lsp_capabilities })
  end
else
  -- Calls to vim.lsp.config(...) here take precedence over lsp/*.lua in the merge
  -- See https://neovim.io/doc/user/lsp.html#lsp-config-merge
  vim.lsp.enable(tools.enabled_lsps)
  vim.api.nvim_create_user_command("LspInfo", function()
    vim.cmd("checkhealth vim.lsp")
  end, { desc = "Show LSP status (via checkhealth)" })
end

-- LSP keymaps not covered by nvim 0.11+ built-in defaults.
-- Built-ins already provide: K, grr (refs), gri (impl), grn (rename),
-- gra (code action), gO (doc symbol), i_<C-s> (signature help).
M.attach_keymaps = {
  { mode = "n", lhs = "gd", rhs = vim.lsp.buf.definition, desc = "Go to definition" },
  { mode = "n", lhs = "gD", rhs = vim.lsp.buf.type_definition, desc = "Go to type definition" },
  { mode = "n", lhs = "gws", rhs = vim.lsp.buf.workspace_symbol, desc = "Workspace symbols" },
  { mode = "n", lhs = "<leader>cL", rhs = vim.lsp.codelens.run, desc = "Run code lens" },
}

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    for _, entry in ipairs(M.attach_keymaps) do
      vim.keymap.set(entry.mode, entry.lhs, entry.rhs, { buffer = args.buf, desc = entry.desc })
    end
  end,
})

M.attach_organize_imports = attach_organize_imports
return M
