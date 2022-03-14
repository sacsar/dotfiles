if &compatible
	set nocompatible
endif

syntax on
syntax enable

if !has("nvim")
	set visualbell t_vb=
endif


"""""""Plugins""""""
if executable('git') && !empty(glob("~/.config/nvim/autoload/plug.vim"))
	call plug#begin()
	source $HOME/.config/nvim/plugins.vim
	call plug#end()
else
	autocmd VimEnter * echom "Install vim-plug with :InstallVimPlug and plugins with :PlugInstall"
endif

" True Color suppord if it's avaliable in the terminal
if has("termguicolors")
	set termguicolors
endif

""" Appearance
set background=dark
colorscheme nord

"use stuff from vim.wikia.com example vimrc
filetype indent plugin on
set wildmenu                      " Use tab to complete stuff in vim menu
set showcmd                       " show partial commands in the last line of screen
set ignorecase                    " case insensitive search except for capital letters
set smartcase
set backspace=indent,eol,start    " allow backspacing over characters
set autoindent                    " Auto-indent new lines if no filetype
set ruler                         " Show row and column ruler information
set noerrorbells

set wrap                          " Only use a soft wrap, not a hard one
set linebreak                     " Break lines at word (requires Wrap lines)
set nolist
set showbreak=\\\\                 " Wrap-broken line prefix
set textwidth=0                   " Line wrap (number of cols)
set wrapmargin=0

set number                        " Show line numbers
set showmatch                     " Highlight matching brace
set undolevels=1000               " Number of undo levels
set nohlsearch
set splitbelow
set splitright

" tabs and indents
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab  " expand tabs to spaces

" https://stackoverflow.com/a/48390668/424173
" allow toggling between local and default mode
function TabToggle()
  if &expandtab
    set shiftwidth=8
    set softtabstop=0
    set noexpandtab
  else
    set shiftwidth=4
    set softtabstop=4
    set expandtab
  endif
endfunction
nmap <F9> mz:execute TabToggle()<CR>'z
command! TabToggle call TabToggle()

""" Toggle line numbers
function NumberToggle()
	if &number
		setlocal nonumber
	else
		setlocal number
	endif
endfunction
command! NumberToggle call NumberToggle()

""" Strip trailing  whitespace
" http://vimcasts.org/episodes/tidying-whitespace/
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>
command! TrimWhitespace call <SID>StripTrailingWhitespaces()

command! FullPath echo expand('%:p')


""" indent guides
" enable by default
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" Define filetype for polybar config
autocmd BufRead,BufNewFile ~/.config/polybar/* set syntax=dosini

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif


command! ReloadVimrc source $MYVIMRC
command! EditVimrc :edit $MYVIMRC

" Finally, load secretive stuff not under version control
if !empty(glob("~/.config/nvim_local.vim"))
    source ~/.config/nvim_local.vim
    command! EditNvimLocal :edit ~/.config/nvim_local.vim
endif

function! InstallVimPlug()
    if empty(glob("~/.config/nvim/autoload/plug.vim"))
        if executable('curl')
            let plugpath = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
            silent exec "!curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs " . plugpath
            redraw!
            echom "Now restart the editor"
        else
            echom "Install curl"
        endif
    else
        echom "vim-plug installed!"
    endif
endfunction
command! InstallVimPlug call InstallVimPlug()
