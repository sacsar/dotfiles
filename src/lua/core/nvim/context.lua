local M = {
  work = false,
  extra_plugins = {},
  extra_tools = {},
}

local ok, local_ctx = pcall(require, "context_local")
if ok then
  for k, v in pairs(local_ctx) do
    M[k] = v
  end
end

return M
