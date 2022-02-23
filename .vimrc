call plug#begin()

Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-vinegar'

Plug 'vim-airline/vim-airline'

Plug 'ludovicchabant/vim-gutentags'

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
let g:ale_linters = { 'cs': ['OmniSharp']}
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
autocmd Filetype cpp let g:ale_cpp_cc_options = '-std=c++20 -Wall -Wextra'

set list listchars=tab:»·,trail:·

" C# configuration
autocmd Filetype cs inoremap <expr> <Tab> pumvisible() ? '<C-n>' :
            \ getline('.')[col('.')-2] =~# '[[:alnum:].-_#$]' ? '<C-x><C-o>' : '<Tab>'
autocmd Filetype cs nnoremap <C-o><C-u> :OmniSharpFindUsages<CR>
autocmd Filetype cs nnoremap <C-o><C-d> :OmniSharpGotoDefinition<CR>

" Java configuration
autocmd Filetype java inoremap sout System.println("")<esc>hi
autocmd Filetype java inoremap souf System.printf("")<esc>hi

" a.vim config
let g:alternateExtensions_cc = "hh"
let g:alternateExtensions_hh = "cc"


" per .git vim configs
" just `git config vim.settings "expandtab sw=4 sts=4"` in a git repository
" change syntax settings for this repository
let git_settings = system("git config --get vim.settings")
if strlen(git_settings)
	exe "set" git_settings
endif


" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
" ## added by OPAM user-setup for vim / ocp-indent ## 275d123c9d2d85d7b59c1a2ca6ac809c ## you can edit, but keep this line
if count(s:opam_available_tools,"ocp-indent") == 0
  source "/home/ethan/.opam/default/share/ocp-indent/vim/indent/ocaml.vim"
endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line
