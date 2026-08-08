-- lsp.lua's log/tools dependency chain reaches for `vim` at require-time,
-- so stub just enough to load outside Neovim.
_G.vim = require("spec.vim_stub")

local lsp = require("core.nvim.lsp")

local ALLOWED_KEYMAP_KEYS = { mode = true, lhs = true, rhs = true, desc = true }

local function has_only_allowed_keys(entry)
  for k, _ in pairs(entry) do
    if not ALLOWED_KEYMAP_KEYS[k] then
      return false
    end
  end
  return true
end

local function is_valid_keymap(entry)
  return type(entry.mode) == "string"
    and type(entry.lhs) == "string"
    and type(entry.rhs) == "function"
    and type(entry.desc) == "string"
    and has_only_allowed_keys(entry)
end

describe("lsp.attach_keymaps", function()
  it("is a list of valid keymap entries", function()
    for _, entry in ipairs(lsp.attach_keymaps) do
      assert.is_true(is_valid_keymap(entry))
    end
  end)

  it("has no duplicate mode+lhs pairs", function()
    local seen = {}
    for _, entry in ipairs(lsp.attach_keymaps) do
      local key = entry.mode .. entry.lhs
      assert.is_nil(seen[key])
      seen[key] = true
    end
  end)

  it("does not bind <leader>f — conform.lua owns formatting", function()
    for _, entry in ipairs(lsp.attach_keymaps) do
      assert.are_not.equal("<leader>f", entry.lhs)
    end
  end)
end)
