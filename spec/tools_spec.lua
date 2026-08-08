local util = require("core.nvim.util")
-- tools.lua's log.lua dependency reaches for logging.console when `vim` is
-- absent, which isn't installed outside a running Neovim. Stub just enough
-- of `vim` so requiring the module doesn't need it.
_G.vim = require("spec.vim_stub")

local tools = require("core.nvim.tools")

describe("build_mason_tool", function()
  it("returns nil for nil input", function()
    assert.is_nil(tools.build_mason_tool(nil))
  end)

  it("converts a bare string into an installable tool", function()
    -- e.g. M.tools.lua.formatters = "stylua"
    assert.are.same({ name = "stylua", install = true }, tools.build_mason_tool("stylua"))
  end)

  it("handles a table with name only", function()
    assert.are.same({ name = "stylua", install = true }, tools.build_mason_tool({ name = "stylua" }))
  end)

  it("defaults install to true when the field is nil", function()
    -- e.g. M.tools.typescriptreact.lsp = { { name = "ts_ls" }, { name = "tailwindcss" } }
    assert.are.same({ name = "ts_ls", install = true }, tools.build_mason_tool({ name = "ts_ls" }))
  end)

  it("honors install = true explicitly", function()
    assert.are.same({ name = "ruff", install = true }, tools.build_mason_tool({ name = "ruff", install = true }))
  end)

  it("honors install = false", function()
    -- e.g. M.tools.scala.lsp = { { name = "metals", install = false } }
    assert.are.same({ name = "metals", install = false }, tools.build_mason_tool({ name = "metals", install = false }))
  end)
end)

local ALLOWED_TOOL_KEYS = { name = true, install = true, conform_formatters = true }

local function has_only_allowed_keys(v)
  for k, _ in pairs(v) do
    if not ALLOWED_TOOL_KEYS[k] then
      return false
    end
  end
  return true
end

local function is_valid_tool_list(x)
  if x == nil or type(x) == "string" then
    return true
  elseif util.isarray(x) then
    for _, v in pairs(x) do
      if v.name == nil then
        return false
      end
      if v.install ~= nil and type(v.install) ~= "boolean" then
        return false
      end
      if not has_only_allowed_keys(v) then
        return false
      end
    end
    return true
  end
  return false
end

describe("is_valid_tool_list", function()
  it("rejects a Tool table with an unknown key", function()
    -- simulates a typo like `instal = false` instead of `install = false`
    assert.is_false(is_valid_tool_list({ { name = "metals", instal = false } }))
  end)

  it("still accepts a Tool table with only allowed keys", function()
    assert.is_true(is_valid_tool_list({ { name = "ruff", conform_formatters = { "ruff_fix" } } }))
  end)
end)

describe("M.tools shape", function()
  local function is_valid_field(x)
    if x == nil or type(x) == "string" then
      return true
    end
    return is_valid_tool_list(x)
  end

  for ft, val in pairs(tools.tools) do
    it(ft .. " has a valid formatters/lsp shape", function()
      assert.is_true(is_valid_field(val.formatters))
      assert.is_true(is_valid_field(val.lsp))
    end)
  end
end)
