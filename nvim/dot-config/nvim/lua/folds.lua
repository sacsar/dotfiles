vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.lsp.foldexpr()"
vim.opt.foldtext = "v:lua.vim.lsp.foldtext()" --v:lua.vim.treesitter.foldtext()"
vim.opt.foldlevel = 99 -- don't fold by default
-- vim.opt.foldlevel = 1 -- level of fold that should be open/closed when buffer created
-- vim.opt.foldnestmax = ...
