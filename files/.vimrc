set nocompatible

let mapleader=" "

"===============
" MISCELLANEOUS
"=============== 
" Goodbye netrwhist file!
let g:netrw_dirhistmax = 0
set noerrorbells
" Turn off modelines - security
set modelines=0
" Speed up scrolling in Vim
set ttyfast
" Encoding
set encoding=utf-8
" Fixes common backspace problems
set backspace=indent,eol,start


"============
" FORMATTING
"============
set formatoptions=tcqn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smartindent
set noshiftround
set nowrap
set noswapfile
" Use <F2> to toggle paste mode, fixes auto indentation and stuff
set pastetoggle=<F2>


"==============
" LINE NUMBERS 
"==============
:set number relativenumber
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END


"========
" SEARCH
"========
set hlsearch
set incsearch
set ignorecase
set smartcase


"============
" NAVIGATION
"============
set hidden
" Buffer navigation
map <Leader>n :bn<CR>
map <Leader>p :bp<CR>
map <Leader>d :bd<CR>
map <Leader>b :ls<CR>:b<Space>
" Window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


"=========
" PLUGINS
"=========
filetype off
filetype plugin indent on

" https://github.com/junegunn/vim-plug
" Will auto-download vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'rubixninja314/vim-mcfunction'
call plug#end()


"=======
" THEME
"=======
let g:solarized_termcolors=256
syntax enable
set background=dark
colorscheme solarized
:set t_ut=""


"============
" STATUS BAR
"============
set laststatus=2
set noshowmode
set showcmd
" Display the name of all the buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1

