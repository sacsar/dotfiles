local opt = vim.opt

opt.wildmenu = true
opt.showcmd = true
opt.ignorecase = true
opt.smartcase = true
opt.backspace = "indent,eol,start"
opt.autoindent = true
opt.ruler = true
opt.errorbells = false

opt.wrap = true
opt.linebreak = true
opt.list = false -- set nolist -- no hidden characeters
opt.showbreak = "\\\\"
opt.textwidth = 0
opt.wrapmargin = 0

opt.number = true
opt.showmatch = true
opt.undolevels = 1000
opt.hlsearch = false
opt.splitbelow = true
opt.splitright = true

-- tabs and indents
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

-- indent guides
vim.g.indent_guides_enable_on_vim_startup = 1
vim.g.indent_guides_start_level = 2
vim.g.indent_guides_guide_size = 1

if vim.fn.has("termguicolors") then
    opt.termguicolors = true
end

opt.signcolumn = "yes"
-- completion
vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }

