local M = {
  cmd = { "java-lsp" },
  filetypes = { "java" },
  root_markers = { "gradlew", ".git" },
}

-- disable formatting
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client.name == "java_lsp" then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end
  end,
})

return M
