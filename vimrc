" omitting this option and loading this vimrc with -u will load vim in vi mode
set nocompatible 

" set MYVIMRC path
let $MYVIMRC="~/.vimrc"

" --- Basic editing configurations ---
set mouse=a " Enable the mouse
set incsearch " highlight while typing in search box
set hlsearch " highlight found searches
set nu rnu " hybrid line numbers
set visualbell t_vb= " Deactivate sound and flashing on error
set ttymouse=xterm2 " To change window size with the mouse

" for VimTex?
filetype plugin indent on
syntax enable

let g:vimtex_view_method = 'zathura'

" --- Mappings --- 

" sane Y, more like C and D
nnoremap Y y$

" CTRL+l to unhighlight search matches
nnoremap <silent> <C-l> :nohl<CR><C-l>

" WSL yank to clipboard support
let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
	augroup WSLYank
		autocmd!
		autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
	augroup END
endif

" local config
if filereadable($HOME . "/.vimrc.local")
	source ~/.vimrc.local
endif
