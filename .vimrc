call plug#begin()

Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-vinegar'

Plug 'vim-airline/vim-airline'

Plug 'dense-analysis/ale'

Plug 'OmniSharp/omnisharp-vim'

Plug 'csliu/a.vim'

call plug#end()


filetype indent plugin on
set omnifunc=ale#completion#OmniFunc

set completeopt=longest,menuone,popuphidden
set completepopup=highlight:NONE

highlight Pmenu ctermbg=gray
highlight PmenuSel ctermbg=lightblue

let maplocalleader = "\\"
let mapleader = ","
set encoding=utf-8 fileencodings=
syntax on

inoremap ( ()<Esc>i
inoremap { {}<Esc>i
inoremap {<CR> {<CR>}<Esc>O
inoremap [ []<Esc>i
inoremap " ""<Esc>i
inoremap ' ''<Esc>i
noremap - ddp
noremap _ ddkP
inoremap <c-u> <esc>lvwUa
nnoremap <c-U> v$U<esc>
nnoremap <leader>ev :vs $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ss :A<cr>

set cc=80
set number
set relativenumber
set cinoptions+=:0
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=8
set smarttab
set smartindent
set textwidth=80
set backspace=eol,start,indent
set clipboard=unnamedplus
set belloff=all

iabbrev lsit list
iabbrev tset test

" ALE configuration
let g:ale_linters = { 'cs': ['OmniSharp'], 'cpp': ['clangd']}
let g:ale_completion_enabled = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 0
let g:ale_fix_on_save = 1
let g:ale_fixers = {'cpp' : ['clang-format']}

" Make configuration
autocmd Filetype make setlocal noexpandtab

" C++ shortcut
autocmd Filetype cpp iabbrev cout std::cout
autocmd Filetype cpp iabbrev cin std::cin
autocmd Filetype cpp iabbrev cerr std::cerr
autocmd Filetype cpp iabbrev clog std::clog

set list listchars=tab:»·,trail:·

" C# configuration
autocmd Filetype cs inoremap <expr> <Tab> pumvisible() ? '<C-n>' :
            \ getline('.')[col('.')-2] =~# '[[:alnum:].-_#$]' ? '<C-x><C-o>' : '<Tab>'
autocmd Filetype cs nnoremap <C-o><C-u> :OmniSharpFindUsages<CR>
autocmd Filetype cs nnoremap <C-o><C-d> :OmniSharpGotoDefinition<CR>

" a.vim config
let g:alternateExtensions_cc = "hh"
let g:alternateExtensions_hh = "cc"
let g:alternateExtensions_hxx = "hh"


" per .git vim configs
" just `git config vim.settings "expandtab sw=4 sts=4"` in a git repository
" change syntax settings for this repository
let git_settings = system("git config --get vim.settings")
if strlen(git_settings)
	exe "set" git_settings
endif
