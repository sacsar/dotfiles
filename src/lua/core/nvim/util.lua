local M = {}

local log = require("core.nvim.log")

function M.map(t, f)
  if t == nil then
    return nil
  end
  if type(t) ~= "table" then
    return { f(t) }
  end
  local out = {}
  for k, v in pairs(t) do
    out[k] = f(v)
  end
  return out
end

M.Set = {}
M.Set.__index = M.Set

function M.Set:new(items)
  s = {}
  for _, v in pairs(items or {}) do
    s[v] = true
  end
  return setmetatable(s, M.Set)
end

function M.Set:add(e)
  M.Set[e] = true
end

function M.Set:totable()
  log.debug(self)
  out = {}
  for k, _ in pairs(self) do
    log.debug("Inserting into output table: ", k)
    table.insert(out, k)
  end
  log.debug("output table: ", out)
  return out
end

return M
