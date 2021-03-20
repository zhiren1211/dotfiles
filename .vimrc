set title
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set ambiwidth=double
set tabstop=2
set expandtab
set shiftwidth=2
set autoread
set hidden
set showcmd
set visualbell
set showmatch
set laststatus=2
set wildmode=list:longest
set whichwrap=b,s,h,l,<,>,[,],~
source $VIMRUNTIME/macros/matchit.vim
nnoremap j gj
nnoremap k gk
syntax enable
set incsearch
set ignorecase
set wrapscan
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>
autocmd BufWritePre * :%s/\s\+$//ge
set wildmenu
set history=5000

set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%,space:_
hi NonText ctermfg=59
hi SpecialKey ctermfg=59
