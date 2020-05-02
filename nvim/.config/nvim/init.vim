if &compatible
	set nocompatible
endif

syntax on
syntax enable

"""""""Plugins""""""

if exists('*minpac#init')
	"minpac is available
	call minpac#init()
	call minpac#add('k-takata/minpac', {'type': 'opt'})

	" managed plugins
	call minpac#add('vim-airline/vim-airline')
	call minpac#add('vim-airline/vim-airline-themes')
	call minpac#add('scrooloose/nerdtree')
	call minpac#add('lifepillar/vim-solarized8')
    call minpac#add('arcticicestudio/nord-vim')
    call minpac#add('tpope/vim-sensible')
    call minpac#add('airblade/vim-gitgutter')
    call minpac#add('nathanaelkane/vim-indent-guides')
    call minpac#add('frazrepo/vim-rainbow')
endif

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

" Define user commands for updating/cleaning the plugins.
" Each of them loads minpac, reloads .vimrc to register the
" information of plugins, then performs the task.
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()
