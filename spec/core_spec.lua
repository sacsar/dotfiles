local inspect = require("inspect")

describe("core.nvim", function()
  it("loads without error and returns a table", function()
    local ok, mod = pcall(require, "core.nvim")

    assert.is_true(ok)
    assert.is_table(mod)
  end)
end)

describe("util.Set", function()
  local util = require("core.nvim.util")

  it("", function()
    local util = require("core.nvim.util")
    local s = util.Set:new()
    assert.is_table(s)
    assert.are.equal(0, #s)
    s:add(1)
    local t = s:totable()
    assert.are.same({ 1 }, t)
  end)
end)
