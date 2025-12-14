local tools = require("core.tools")
local log = require("core.log")

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

if vim.fn.has("nvim-0.11") == 0 then
  local lspconfig = require("lspconfig")
  local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()

  for _, lsp in ipairs(tools.enabled_lsps) do
    lspconfig[lsp].setup({ capabilities = lsp_capabilities })
  end
else
  -- Calls to vim.lsp.config(...) here take precedence over lsp/*.lua in the merge
  -- See https://neovim.io/doc/user/lsp.html#lsp-config-merge
  log.info("Enabling: ", tools.enabled_lsps)
  vim.lsp.enable(tools.enabled_lsps)
end

M.attach_organize_imports = attach_organize_imports
return M
