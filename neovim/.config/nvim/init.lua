-- Stop jumping left gutter from warnings
vim.opt.signcolumn = "yes"

-- Auto suggestions command mode
vim.opt.wildmenu = true
vim.opt.wildoptions = "pum"

-- Needs to be done before plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

----  Plugins  ----
local Plug = vim.fn['plug#']
--local Fzf = vim.fn['fzf#']

-- vim.call('plug#begin', '~/.config/nvim/plugged')
vim.call('plug#begin')

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
-- Plug 'vim-airline/vim-airline'

-- Fuzzy finder
Plug ('junegunn/fzf', { ['do'] = './install --all' })
Plug 'junegunn/fzf.vim'

-- Highlighting
Plug ('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

-- Auto-pairs
-- Plug 'jiangmiao/auto-pairs'
Plug 'Raimondi/delimitMate'

-- Git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

-- Latex
Plug 'lervag/vimtex'
Plug 'nvim-telescope/telescope-bibtex.nvim'

-- LSP
Plug 'mason-org/mason.nvim'
Plug 'neovim/nvim-lspconfig'

-- Completion manager
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'L3MON4D3/LuaSnip'        -- Snippet engine (required for most cmp setups)

Plug 'gelguy/wilder.nvim'
-- Plug 'ncm2/ncm2'
-- Plug 'roxma/nvim-yarp'

-- NOTE: you need to install completion sources to get completions. Check
-- our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
-- Plug 'ncm2/ncm2-bufword'
-- Plug 'ncm2/ncm2-path'

Plug 'nvim-lua/plenary.nvim'
Plug ('nvim-telescope/telescope.nvim', { tag = '0.1.x' })
Plug ('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })

-- File explorer
Plug 'preservim/nerdtree'
-- Plug 'scrooloose/nerdtree-project-plugin'  -- line 45 throws an error
Plug 'ryanoasis/vim-devicons'

-- etc
Plug 'ThePrimeagen/vim-be-good'

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


---- Leader shortcuts
--nnoremap <leader>ee :NERDTreeFocus<CR>
--nnoremap <leader>et :NERDTreeToggle<CR>
---- nmap <Leader>fzf :Files<CR>
--nmap <Leader>f :GFiles<CR>

vim.keymap.set('n', '<leader>pc', '<cmd>PlugClean<CR>', { desc = 'Plug Clean' })
vim.keymap.set('n', '<leader>pi', '<cmd>PlugInstall<CR>', { desc = 'Plug Install' })
vim.keymap.set('n', '<leader>pu', '<cmd>PlugUpdate<CR>', { desc = 'Plug Update' })
vim.keymap.set('n', '<leader>so', function()
  vim.cmd('source ' .. vim.env.MYVIMRC)
  print("Sourced")
end, { desc = 'Source init.lua' })


---- Autocenter
----nnoremap G Gzz
--nmap('G', 'Gzz')
----nnoremap g; g;zz
--nmap('g;', 'g;zz')
----nnoremap g, g,zz
--nmap('g,', 'g,zz')
----nnoremap n nzz
--nmap('n', 'nzz')
----nnoremap N Nzz
--nmap('N', 'Nzz')
----nnoremap { {zz
--nmap('{', '{zz')
----nnoremap } }zz
--nmap('}', '}zz')
------ nmap <C-U> <C-U>zz
--nmap('<C-u>', '<C-u>zz')
------ nmap <C-D> <C-D>zz
--nmap('<C-d>', '<C-d>zz')

--- etc
---- Open file under cursor in split window
--nnoremap <F8> :let mycurf=expand("<cfile>")<cr><c-w>p:execute("e ".mycurf)<cr>
nmap('<F8>', ':let mycurf=expand("<cfile>")<cr><c-w>p:execute("e ".mycurf)<cr>')

-- Staggering increment start by one,
-- because I only use it to convert 1. 1. ... into 1. 2. ...
--vnoremap g<C-a> g<C-a>gv<C-x><Esc>
-- vmap('g<C-a>', 'g<C-a>gv<C-x><Esc>')
-- vmap('g<C-x>', 'g<C-x>gv<C-a><Esc>')

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


-- --- Color schemes ---
-- vscode-like colorscheme
--colorscheme codedark
--vim.g.colorscheme = 'codedark'
vim.opt.termguicolors = true
vim.cmd([[
colorscheme codedark
]])

-- jetbrains-like colorscheme
--colorscheme darcula



-- Treesitter enable highlight on each new buffer
-- ??
vim.g.NERDTreeShowHidden = 1

-- Check if we are running in WSL
local is_wsl = (function()
    local handle = io.popen("uname -r")
    if handle then
        local result = handle:read("*a")
        handle:close()
        return result:lower():find("microsoft") ~= nil
    end
    return false
end)()

-- Telescope
local builtin = require('telescope.builtin')

-- The "Standard" Neovim style (highly recommended)
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find file' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Search text in files' })


-- Latex

if is_wsl then
    -- SumatraPDF path (WSL path to the Windows .exe)
    local sumatra_path = '/mnt/c/Users/MichaelLuu/AppData/Local/SumatraPDF/SumatraPDF.exe'

    vim.g.vimtex_view_general_viewer = sumatra_path
    vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
end


-- Auto-compile on save (Vimtex does this by default with latexmk)
vim.g.vimtex_compiler_method = 'latexmk'

-- Latex LSP
vim.lsp.enable('texlab')

vim.lsp.config['texlab'] = {
  settings = {
    texlab = {
      completion = {
        matcher = "prefix",
        -- Allow vimtex to handle completions if you prefer
        vimtex = { enabled = true }
      }
    }
  }
}


-- LSP

require("mason").setup()
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config['lua-language-server'] = {
  cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/lua-language-server") },
  filetypes = { "lua" },
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = {
        globals = { 'vim' }, -- Fix the "Undefined global 'vim'" warning
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
}

vim.lsp.enable('lua-language-server')


-- Completion manager

local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})


-- Completion for command line
local wilder = require('wilder')
wilder.setup({modes = {':'}})

wilder.set_option('renderer', wilder.popupmenu_renderer(
  -- wilder.popupmenu_border_theme({
  --   -- 'highlighter' apply colors to the matched text
  --   highlighter = wilder.basic_highlighter(),

  --   -- Set the highlights for the menu colors
  --   highlights = {
  --     border = 'Normal', -- border color
  --   },

  --   -- can be 'single', 'double', 'rounded' or 'solid'
  --   border = '',

  --   max_height = '20%',

  --   -- min_width = '100%',

  --   -- Use the default prompt (usually at the bottom)
  --   reverse = false,
  -- })
))


-- Git

-- Fugitive
-- Open the Fugitive status window
vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>")
vim.keymap.set("n", "<leader>gd", "<cmd>Gvdiffsplit<CR>")
vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<CR>")
vim.keymap.set("n", "<leader>gp", "<cmd>Git push<CR>")
vim.keymap.set("n", "<leader>gl", "<cmd>Git pull<CR>")
vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<CR>")
vim.keymap.set("n", "<leader>gr", "<cmd>Gread<CR>")
vim.keymap.set("n", "<leader>gw", "<cmd>Gwrite<CR>")

-- Git signs
require('gitsigns').setup{
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end)

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end)

    -- Actions
    map('n', '<leader>hs', gitsigns.stage_hunk)
    map('n', '<leader>hr', gitsigns.reset_hunk)

    map('v', '<leader>hs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('v', '<leader>hr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('n', '<leader>hS', gitsigns.stage_buffer)
    map('n', '<leader>hR', gitsigns.reset_buffer)
    map('n', '<leader>hp', gitsigns.preview_hunk)
    map('n', '<leader>hi', gitsigns.preview_hunk_inline)

    map('n', '<leader>hb', function()
      gitsigns.blame_line({ full = true })
    end)

    map('n', '<leader>hd', gitsigns.diffthis)

    map('n', '<leader>hD', function()
      gitsigns.diffthis('~')
    end)

    map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
    map('n', '<leader>hq', gitsigns.setqflist)

    -- Toggles
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
    map('n', '<leader>tw', gitsigns.toggle_word_diff)

    -- Text object
    map({'o', 'x'}, 'ih', gitsigns.select_hunk)
  end
}
