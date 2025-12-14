-- lua/core/tools.lua
local M = {}

local log = require("core.log")
local util = require("core.util")

---@alias MasonTool {[1]: string, [2]: boolean}

---@class Tool
---@field name string
---@field install? boolean

---@class Formatter : Tool
---@field name string
---@field install? boolean
---@field conform_formatters? string[]

---@class Lsp : Tool
---@field name string
---@field install? boolean

---@class FileTypeTools
---@field formatters? string|Formatter[]
---@field lsp? string|Lsp[]

---@type table<string, FileTypeTools>
M.tools = {
  lua = { formatters = "stylua", lsp = "lua_ls" },
  python = {
    formatters = { { name = "ruff", conform_formatters = { "ruff_fix", "ruff_organize_imports", "ruff_format" } } },
    lsp = "ruff",
  },
  javascript = { formatters = "prettierd" },
  scala = { formatters = { { name = "scalafmt", install = false } }, lsp = { { name = "metals", install = false } } },
  sh = { formatters = "shfmt" },
  bash = { formatters = "shfmt" },
  clojure = { lsp = "clojure_lsp" },
  c = { lsp = "clangd" },
  cpp = { lsp = "clangd" },
  rust = { lsp = "rust_analyzer" },
}

--- Convert a Formatter or Lsp to a MasonTool
---@param x string|Tool|nil
---@return MasonTool?
local function build_mason_tool(x)
  if x == nil then
    return nil
  elseif type(x) == "string" then
    return { x, true }
  elseif type(x) == "table" then
    -- if it's not a table, we have a real problem
    local tools = {}
    for _, item in ipairs(x) do
      if item.install == nil or item.install then
        tools.insert({ x.name, true })
      end
    end
    return tools
  end
end

---@type string[]
M.ensure_installed = {}

local mason_tools = util.Set:new()

for _, val in pairs(M.tools) do
  for _, f in ipairs(util.map(val.formatters, build_mason_tool) or {}) do
    if f.install then
      mason_tools:add(f.name)
    end
  end
  local mason_lsp = util.map(val.lsp, build_mason_tool)
  for _, l in ipairs(mason_lsp or {}) do
    if l.install then
      mason_tools:add(l.name)
    end
  end
end

for k, _ in pairs(mason_tools) do
  table.insert(M.ensure_installed, k)
end

-- build the formatters_by_ft option for conform
M.formatters_by_ft = {}
---@type string[]
M.enabled_lsps = {}

local lsp_set = util.Set:new()

for ft, val in pairs(M.tools) do
  log.debug("Processing tools for ", ft)
  if val.formatters ~= nil then
    if type(val.formatters) == "string" then
      M.formatters_by_ft[ft] = { val.formatters }
    elseif type(val.formatters) == "table" then
      M.formatters_by_ft[ft] = {}
      for _, formatter in ipairs(val.formatters) do
        if formatter.conform_formatters ~= nil then
          for _, cf in ipairs(formatter.conform_formatters) do
            table.insert(M.formatters_by_ft[ft], cf)
          end
        else -- it didn't have any specific conform... stuff
          table.insert(M.formatters_by_ft[ft], formatter.name)
        end
      end
    end
  end

  if val.lsp ~= nil then
    if type(val.lsp) == "string" then
      lsp_set:add(val.lsp)
    elseif type(val.lsp) == "table" then
      for _, lsp in ipairs(val.lsp) do
        lsp_set:add(lsp.name)
      end
    end
  else
    log.debug("val.lsp was nil for ", val)
  end

  log.debug("lsp_set = ", lsp_set)
end

for _, lsp in ipairs(lsp_set) do
  log.debug(lsp)
  table.insert(M.enabled_lsps, lsp)
end

return M
