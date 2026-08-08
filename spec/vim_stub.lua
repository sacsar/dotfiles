-- Shared minimal `vim` stub so nvim-lua modules can be `require`d from
-- busted specs without a running Neovim. Extend the returned table in a
-- spec if a module reaches for a field not stubbed here.
-- vim.version is both callable (returns the running version) and a table
-- with comparison helpers like .lt — mirror that shape with a __call metatable.
local version = setmetatable({
  lt = function(a, b)
    for i = 1, 3 do
      if (a[i] or 0) ~= (b[i] or 0) then
        return (a[i] or 0) < (b[i] or 0)
      end
    end
    return false
  end,
}, {
  __call = function()
    return { 0, 11, 0 }
  end,
})

return {
  log = { levels = { TRACE = 0, DEBUG = 1, INFO = 2, WARN = 3, ERROR = 4 } },
  version = version,
  api = {
    nvim_create_autocmd = function() end,
    nvim_create_user_command = function() end,
  },
  lsp = {
    enable = function() end,
    buf = {
      definition = function() end,
      type_definition = function() end,
      workspace_symbol = function() end,
      format = function() end,
    },
    codelens = { run = function() end },
  },
}
