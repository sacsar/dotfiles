-- disabling netrw at the suggestion of nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Configure lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")
-- load our configs
require("settings")
require("folds")
require("mappings")
require("lsp")

-- TODO: Move this somewhere more sensible.
vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_fallback = true, range = range })
end, { range = true })

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

vim.cmd([[
    " terminal mode stuff
augroup neovim_terminal
        " get us back into a normal mode where we can change windows
   :tnoremap <Esc> <C-\><C-n>
        " see https://stackoverflow.com/a/63909865
   autocmd!
        " Enter Terminal-mode (insert) automatically
   autocmd TermOpen * startinsert
        " Disables number lines on terminal buffer
   autocmd TermOpen * :set nonumber norelativenumber
        " allows you to use Ctrl-c on terminal window
   autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
augroup END
]])
