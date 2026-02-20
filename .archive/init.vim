" --- Plugins ---

call plug#begin()

" surround.vim
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" colorschemes
Plug 'tomasiser/vim-code-dark'
Plug 'doums/darcula'

" smooth scrolling
" Plug 'psliwka/vim-smoothie'

" comments
Plug 'tpope/vim-commentary'

" statusline
"Plug 'vim-airline/vim-airline'  "seems to be broken on wsl

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Auto-pairs 
" Plug 'jiangmiao/auto-pairs' 
Plug 'Raimondi/delimitMate'

" LSP
Plug 'neovim/nvim-lspconfig'

" Completion manager
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
" Plug 'ncm2/ncm2'
" Plug 'roxma/nvim-yarp'

" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
" Plug 'ncm2/ncm2-bufword'
" Plug 'ncm2/ncm2-path'

" File explorer
Plug 'preservim/nerdtree'
" Plug 'scrooloose/nerdtree-project-plugin'  " line 45 throws an error
Plug 'ryanoasis/vim-devicons'

call plug#end()    



" --- Completion manager ---

" enable ncm2 for all buffers
" autocmd BufEnter * call ncm2#enable_for_buffer()

" etc.
" language en_US

" to enable fzf preview in powershell
" let $PATH = "C:\\Program Files\\Git\\usr\\bin;" . $PATH

" --- Settings ---

" set completeopt=noinsert,menuone,noselect  " IMPORTANT: :help Ncm2PopupOpen for more information
set number relativenumber  " relative line numbers
set mouse=a  " enable mouse
set ignorecase  " to enable smartcase
set smartcase  " case insensitive search in lowercase and sensitive otherwise
set expandtab  " fill tabs with spaces
set tabstop=2
set shiftwidth=2
" set autochdir  " change to directory of currently opened file
set sessionoptions-=blank  " because nerdtree windows can't be saved with sessions

" " --- Auto Commands ---
" function RedrawScreen()
"   <C-L>
" endfunction

" autocmd BufEnter * call RedrawScreen()


" --- File Explorer ---
" -- NERDTree --

" Start NERDTree, unless a file or session is specified, eg. vim -S session_file.vim.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | NERDTree | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
" autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif



" -- netrw --
let g:netrw_liststyle = 3  " tree-view
let g:netrw_winsize = 30  " standard width
let g:netrw_banner = 0  " hide help
" let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'  " hide dotfiles
let g:netrw_localcopydircmd = 'cp -r'  " enable recursive copy






" --- Mappings ---
" override default CTRL + L
" nnoremap <C-L> :nohl<CR>

" Disable CTRL + c message
nnoremap <C-c> <silent> <C-c>

" CTRL + S to save
nnoremap <silent> <C-S> :update<CR>
vnoremap <silent> <C-S> <ESC>:update<CR>gv
" TODO: try neovims beta feature CTRL+S 
inoremap <silent> <C-S> <C-O>:update<CR>

let mapleader=" "

" Leader shortcuts
nnoremap <leader>ee :NERDTreeFocus<CR>
nnoremap <leader>et :NERDTreeToggle<CR>
" nmap <Leader>fzf :Files<CR>
nmap <Leader>f :GFiles<CR>
nmap <Leader>pc :PlugClean<CR>
nmap <Leader>pi :PlugInstall<CR>
nmap <Leader>pu :PlugUpdate<CR>
nmap <Leader>so :source $MYVIMRC<CR>

" Autocenter
" nnoremap G Gzz
" nnoremap g; g;zz
" nnoremap g, g,zz
" nnoremap n nzz
" nnoremap N Nzz
" " scroll 10 lines up after centering, because I like to look at the center of
" " the screen
" nnoremap { {zz
" nnoremap } }zz
" nmap <C-U> <C-U>zz
" nmap <C-D> <C-D>zz

" Open file under cursor in split window
nnoremap <F8> :let mycurf=expand("<cfile>")<cr><c-w>p:execute("e ".mycurf)<cr>


" Single insert commands


" nmap <Enter> o<ESC>
" nmap <A-Enter> O<ESC>


"  Try to jump to next method
" :map [[ ?{<CR>w99[{
" :map ][ /}<CR>b99]}
" :map ]] j0[[%/{<CR>
" :map [] k$][%?}<CR>


" --- Color schemes ---
" vscode-like colorscheme
colorscheme codedark

" jetbrains-like colorscheme
"colorscheme darcula

" Treesitter enable highlight on each new buffer
" ??

" --- Functions ---

" Center screen after pressing enter while searching
function! CenterSearch()
	let cmdtype = getcmdtype()
	if cmdtype == '/' || cmdtype == '?'
		return "\<enter>zz"
	endif
	return "\<enter>"
endfunction

cnoremap <silent> <expr> <enter> CenterSearch()

" make cursor blink
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
			\,a:blinkon100
			\,sm:block-blinkwait175-blinkoff150-blinkon175


function! s:small_terminal() abort
  new
  wincmd J
  call nvim_win_set_height(0, 12)
  set winfixheight
  term
endfunction

" ANKI: Make a small terminal at the bottom of the screen.
nnoremap <leader>st :call <SID>small_terminal()<CR>

" LUA CONFIGS ------------------------------------------------------------

"lua << EOF
"-- Enable LSP
"require'lspconfig'.tsserver.setup{}
"-- Mappings.
"-- See `:help vim.diagnostic.*` for documentation on any of the below functions
"local opts = { noremap=true, silent=true }
"vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
"vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
"vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
"vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
"
"-- Use an on_attach function to only map the following keys
"-- after the language server attaches to the current buffer
"local on_attach = function(client, bufnr)
"  -- Enable completion triggered by <c-x><c-o>
"  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
"
"  -- Mappings.
"  -- See `:help vim.lsp.*` for documentation on any of the below functions
"  local bufopts = { noremap=true, silent=true, buffer=bufnr }
"  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
"  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
"  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
"  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
"  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
"  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
"  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
"  vim.keymap.set('n', '<space>wl', function()
"    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
"  end, bufopts)
"  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
"  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
"  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
"  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
"  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
"end
"
"local lsp_flags = {
"  -- This is the default in Nvim 0.7+
"  debounce_text_changes = 150,
"}
"
"require('lspconfig')['pyright'].setup{
"    on_attach = on_attach,
"    flags = lsp_flags,
"}
"
"-- Set up lspconfig.
"local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
"
"require('lspconfig')['tsserver'].setup{
"    on_attach = on_attach,
"    flags = lsp_flags,
"    capabilities = capabilities,
"}
"require('lspconfig')['rust_analyzer'].setup{
"    on_attach = on_attach,
"    flags = lsp_flags,
"    -- Server-specific settings...
"    settings = {
"      ["rust-analyzer"] = {}
"    }
"}
"
"-- Autocomplete with cmp
"-- Set up nvim-cmp.
"local cmp = require'cmp'
"
"cmp.setup({
"  snippet = {
"    -- REQUIRED - you must specify a snippet engine
"    expand = function(args)
"      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
"      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
"      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
"      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
"    end,
"  },
"  window = {
"    -- completion = cmp.config.window.bordered(),
"    -- documentation = cmp.config.window.bordered(),
"  },
"  mapping = cmp.mapping.preset.insert({
"    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
"    ['<C-f>'] = cmp.mapping.scroll_docs(4),
"    ['<C-Space>'] = cmp.mapping.complete(),
"    ['<C-e>'] = cmp.mapping.abort(),
"    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
"  }),
"  sources = cmp.config.sources({
"    { name = 'nvim_lsp' },
"    { name = 'vsnip' }, -- For vsnip users.
"    -- { name = 'luasnip' }, -- For luasnip users.
"    -- { name = 'ultisnips' }, -- For ultisnips users.
"    -- { name = 'snippy' }, -- For snippy users.
"  }, {
"    { name = 'buffer' },
"  })
"})
"
"-- Set configuration for specific filetype.
"cmp.setup.filetype('gitcommit', {
"  sources = cmp.config.sources({
"    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
"  }, {
"    { name = 'buffer' },
"  })
"})
"
"-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
"cmp.setup.cmdline('/', {
"  mapping = cmp.mapping.preset.cmdline(),
"  sources = {
"    { name = 'buffer' }
"  }
"})
"
"-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
"cmp.setup.cmdline(':', {
"  mapping = cmp.mapping.preset.cmdline(),
"  sources = cmp.config.sources({
"    { name = 'path' }
"  }, {
"    { name = 'cmdline' }
"  })
"})
"
"
"
"
"-- Enable treesitter
"require'nvim-treesitter.configs'.setup {
"  -- A list of parser names, or "all"
"  ensure_installed = { "javascript" },
"
"  -- Install parsers synchronously (only applied to `ensure_installed`)
"  sync_install = false,
"
"  -- Automatically install missing parsers when entering buffer
"  auto_install = false,
"
"  -- List of parsers to ignore installing (for "all")
"  --ignore_install = { "javascript" },
"
"  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
"  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
"
"  highlight = {
"    -- `false` will disable the whole extension
"    enable = true,
"
"    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
"    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
"    -- the name of the parser)
"    -- list of language that will be disabled
"    --disable = { "c", "rust" },
"
"    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
"    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
"    -- Using this option may slow down your editor, and you may see some duplicate highlights.
"    -- Instead of true it can also be a list of languages
"    additional_vim_regex_highlighting = false,
"  },
"}
"EOF
"
