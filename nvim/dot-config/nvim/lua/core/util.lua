local M = {}

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

function M.Set:new(s)
  s = s or {}
  setmetatable(s, self)
  self.__index = self
  return s
end

function M.Set:add(e)
  M.Set[e] = true
end

return M
