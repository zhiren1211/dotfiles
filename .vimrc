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
inoremap <> <><LEFT>
inoremap { {}<LEFT>
inoremap [ []
inoremap ( ()
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
nnoremap <silent><C-n> :NERDTreeToggle<CR>

augroup MyXML
    autocmd!
    autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
    autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
    autocmd Filetype eruby inoremap <buffer> </ </<C-x><C-o>
augroup END>>>>>>>>>>>>>>>

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
        echo "install NeoBundle..."
        call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
    endif
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'scrooloose/nerdtree'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%,space:_
hi NonText ctermfg=59
hi SpecialKey ctermfg=59
set list
