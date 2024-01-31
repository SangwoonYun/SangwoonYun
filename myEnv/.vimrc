set nu
set ts=4
set shiftwidth=4
set laststatus=2
set statusline=\ %<%l:%v\ [%P]%=%a\ %h%m%r\ %F\
set hlsearch
set showmatch
set smartindent
set tabstop=4
set expandtab
set autoindent
set cindent
set mouse=a

" Syntax Highlighting
if has("syntax")
    syntax on
endif

" Last Cursor
au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g`\"" |
\ endif

" EXCEPTION
filetype plugin indent on
autocmd FileType Makefile noexpandtab
