" make CTRL + S also source vimrc in .vim files
nmap <buffer> <C-S> :update<CR>:source $MYVIMRC<CR>
vmap <silent> <C-S> <C-[>:update<CR>:source $MYVIMRC<CR>gv
