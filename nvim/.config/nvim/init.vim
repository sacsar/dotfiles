if &compatible
	set nocompatible
endif

syntax on
syntax enable

"""""""Plugins""""""

call plug#begin(stdpath('data').'/plugged')
source $HOME/.config/nvim/plugins.vim
call plug#end()

""" Appearance
set background=dark
colorscheme nord

" True Color suppord if it's avaliable in the terminal
if has("termguicolors")
	set termguicolors
endif

" tabs and indents
set expandtab
set tabstop=4
set shiftwidth=4

""" NERDTree
"set C-n to toggle nerd tree
map <C-n> :NERDTreeToggle<CR>

""" indent guides
" enable by default
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" Define filetype for polybar config
autocmd BufRead,BufNewFile ~/.config/polybar/* set syntax=dosini
