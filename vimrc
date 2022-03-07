" set MYVIMRC path
let $MYVIMRC="~/.vimrc"

set nocompatible

" Enable the mouse
set mouse=a

" highlight while typing in search box
set incsearch

" highlight found searches
set hlsearch

" hybrid line numbers
set nu rnu

" Deactivate sound and flashing on error
set visualbell t_vb=

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
