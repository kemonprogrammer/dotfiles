----  Plugins  ----
local Plug = vim.fn['plug#']
--local Fzf = vim.fn['fzf#']

vim.call('plug#begin', '~/.config/nvim/plugged')

-- surround.vim
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

-- colorschemes
Plug 'tomasiser/vim-code-dark'
Plug 'doums/darcula'

-- smooth scrolling
-- Plug 'psliwka/vim-smoothie'

-- comments
Plug 'tpope/vim-commentary'

-- statusline
Plug 'vim-airline/vim-airline'

-- Fuzzy finder
Plug ('junegunn/fzf', { ['do'] = vim.fn['fzf#install()'] })
Plug 'junegunn/fzf.vim'

-- Highlighting
Plug ('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

-- Auto-pairs 
-- Plug 'jiangmiao/auto-pairs' 
Plug 'Raimondi/delimitMate'

-- LSP
Plug 'neovim/nvim-lspconfig'

-- Completion manager
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
-- Plug 'ncm2/ncm2'
-- Plug 'roxma/nvim-yarp'

-- NOTE: you need to install completion sources to get completions. Check
-- our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
-- Plug 'ncm2/ncm2-bufword'
-- Plug 'ncm2/ncm2-path'

-- File explorer
Plug 'preservim/nerdtree'
-- Plug 'scrooloose/nerdtree-project-plugin'  -- line 45 throws an error
Plug 'ryanoasis/vim-devicons'

vim.call('plug#end')


----  Settings  ----
vim.opt.number = true
vim.opt.relativenumber = true  -- relative line numbers
vim.opt.mouse = 'a'  -- enable mouse
vim.opt.ignorecase = true  -- to enable smartcase
vim.opt.smartcase = true  -- case insensitive search in lowercase and sensitive otherwise
vim.opt.expandtab = true  -- fill tabs with spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
-- change to directory of currently opened file
--vim.opt.autochdir= true -- disabled, because nerdtree needs to display VCS Path
-- set sessionoptions-=blank  -- because nerdtree windows can't be saved with sessions
-- #TODO vim to lua


-- #TODO
-- ----  File Explorer  ----
-- --- NERDTree ---
-- 
-- -- Start NERDTree, unless a file or session is specified, eg. vim -S session_file.vim.
-- autocmd StdinReadPre * let s:std_in=1
-- autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | NERDTree | endif
-- 
-- -- Exit Vim if NERDTree is the only window remaining in the only tab.
-- -- autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
-- 
-- -- Close the tab if NERDTree is the only window remaining in it.
-- autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
-- 
-- -- If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
-- autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
--     \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

-- --- Mappings ---
function map(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, {noremap = true})
end

-- #TODO overload functions to optionally pass options {} as 3rd parameter
function nmap(shortcut, command)
    map('n', shortcut, command)
end



function imap(shortcut, command)
    map('i', shortcut, command)
end

function vmap(shortcut, command)
    map('v', shortcut, command)
end
-- Disable CTRL + c message
-- #TODO replace with set command
vim.api.nvim_set_keymap('n', '<C-c>', '<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-c>', '<Esc>', { noremap = true, silent = true })

-- CTRL + S to save
--nnoremap <silent> <C-S> :update<CR>
nmap('<C-S>', ':update<CR>')
--vnoremap <silent> <C-S> <ESC>:update<CR>gv
vmap('<C-S>', '<ESC>:update<CR>gv')
---- TODO: try neovims beta feature CTRL+S 
--inoremap <silent> <C-S> <C-O>:update<CR>
--imap('<C-s>', '<C-O>:update<CR>')

--
---- Leader shortcuts
--nnoremap <leader>ee :NERDTreeFocus<CR>
--nnoremap <leader>et :NERDTreeToggle<CR>
---- nmap <Leader>fzf :Files<CR>
--nmap <Leader>f :GFiles<CR>
--nmap <Leader>pc :PlugClean<CR>
--nmap <Leader>pi :PlugInstall<CR>
--nmap <Leader>pu :PlugUpdate<CR>
--nmap <Leader>so :source $MYVIMRC<CR>
--
---- Autocenter
--nnoremap G Gzz
nmap('G', 'Gzz')
--nnoremap g; g;zz
nmap('g;', 'g;zz')
--nnoremap g, g,zz
nmap('g,', 'g,zz')
--nnoremap n nzz
nmap('n', 'nzz')
--nnoremap N Nzz
nmap('N', 'Nzz')
--nnoremap { {zz
nmap('{', '{zz')
--nnoremap } }zz
nmap('}', '}zz')
---- nmap <C-U> <C-U>zz
nmap('<C-u>', '<C-u>zz')
---- nmap <C-D> <C-D>zz
nmap('<C-d>', '<C-d>zz')

--- etc
---- Open file under cursor in split window
--nnoremap <F8> :let mycurf=expand("<cfile>")<cr><c-w>p:execute("e ".mycurf)<cr>
nmap('<F8>', ':let mycurf=expand("<cfile>")<cr><c-w>p:execute("e ".mycurf)<cr>')

-- Staggering increment start by one,
-- because I only use it to convert 1. 1. ... into 1. 2. ...
--vnoremap g<C-a> g<C-a>gv<C-x><Esc>
vmap('g<C-a>', 'g<C-a>gv<C-x><Esc>')
vmap('g<C-x>', 'g<C-x>gv<C-a><Esc>')

---- Single insert commands
--
--
---- nmap <Enter> o<ESC>
--nmap('<CR>', 'o<Esc>')
---- nmap <A-Enter> O<ESC>
--nmap('<S-CR>', 'O<Esc>')
--
--
----  Try to jump to next method
---- :map [[ ?{<CR>w99[{
---- :map ][ /}<CR>b99]}
---- :map ]] j0[[%/{<CR>
---- :map [] k$][%?}<CR>


