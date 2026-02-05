let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'tomasiser/vim-code-dark'

call plug#end()



" set MYVIMRC path
let $MYVIMRC="~/.vimrc"

" --- Basic editing configurations ---
set nocompatible  " omitting this option and loading this vimrc with -u will load vim in vi mode
set mouse=a " Enable the mouse
set incsearch " highlight while typing in search box
set hlsearch " highlight found searches
set nu rnu " hybrid line numbers
set visualbell t_vb= " Deactivate sound and flashing on error
set ttymouse=xterm2 " To change window size with the mouse
set showcmd  " show currently typed command

" for VimTex?
filetype plugin indent on
syntax enable

let g:vimtex_view_method = 'zathura'

" --- Mappings --- 

" sane Y, more like C and D
nnoremap Y y$

" CTRL+l to unhighlight search matches
nnoremap <silent> <C-l> :nohl<CR><C-l>

nnoremap <silent> <C-S> :update<CR>

" Leader mappings
nnoremap <leader>pi :PlugInstall<CR>
nnoremap <leader>pc :PlugClean<CR>
nnoremap <leader>so :source $MYVIMRC<CR>

" Colorschemes
colorscheme codedark

" try cursor
" Not possible in WSL vim
" let &t_SI.="\e[5 q"
" let &t_SR.="\e[4 q"
" let &t_EI.="\e41 q"

" local config
if filereadable($HOME . "/.vimrc.local")
	source ~/.vimrc.local
endif

let NERDTreeShowHidden=1
