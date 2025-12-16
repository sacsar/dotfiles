describe("core.nvim", function()
  it("loads without error and returns a table", function()
    local ok, mod = pcall(require, "core.nvim")

    assert.is_true(ok)
    assert.is_table(mod)
  end)
end)
