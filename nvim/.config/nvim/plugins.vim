"""" Appearance related plugins
Plug 'itchyny/lightline.vim'
Plug 'arcticicestudio/nord-vim'

let g:lightline = {
            \ 'colorscheme': 'nord',
            \}

Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

"Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'

""" Configure NERDTree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

"set C-m to toggle nerd tree
map <F6> :NERDTreeToggle<CR>
nnoremap <C-o> :NERDTreeToggle<CR>

let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.DS_STORE$', '$\.git']

" LaTeX
Plug 'lervag/vimtex'
if has('unix') " still not good enough because should be true on os x
    let g:vimtex_view_method = 'zathura' "NOTE: linux only
endif

" coc-nvim -- NeoVim only
if has('nvim')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif
