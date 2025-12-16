-- thank you chat gpt
-- lua/core/log.lua
local M = {}

local levels = vim.log.levels

-- Render any object safely
local function render(obj)
  if obj == nil then
    return ""
  end
  if type(obj) == "string" then
    return obj
  end
  return vim.inspect(obj)
end

-- Extract "myfile.lua:123" from debug info
local function src()
  local info = debug.getinfo(3, "Sl") -- 3 = caller stack level
  if not info then
    return ""
  end

  local file = info.short_src or "?"
  local line = info.currentline or 0
  return string.format("[%s:%s]", file, line)
end

local function write(level_name, ...)
  local args = { ... }

  -- First argument may be a category tag
  local category = ""
  if type(args[1]) == "string" and args[1]:match("^%[.+%]$") then
    category = args[1] .. " "
    table.remove(args, 1)
  end

  local msg = table.concat(vim.tbl_map(render, args), " ")
  local level = levels[string.upper(level_name)] or levels.ERROR

  vim.notify(category .. msg, level)
end

M.trace = function(...)
  write("trace", src(), ...)
end
M.debug = function(...)
  write("debug", src(), ...)
end
M.info = function(...)
  write("info", src(), ...)
end
M.warn = function(...)
  write("warn", src(), ...)
end
M.error = function(...)
  write("error", ...)
end

return M
