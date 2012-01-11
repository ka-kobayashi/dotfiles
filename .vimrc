set nocompatible

"display 
set number
set ruler
set cmdheight=2
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
"set statusline+=\ %{strftime('%c')}  " 時間
set statusline+=\ [%{strftime('%H:%M')}]  " 時間
set title
set linespace=0
set wildmenu
set showcmd

"syntax color
syntax on
colorscheme ron
highlight LineNr ctermfg=darkgrey
filetype on
filetype indent on
filetype plugin on
set showmode
set showmatch


"search
set ignorecase
set smartcase
set wrapscan
set nohlsearch
set incsearch


"edit
set autoindent
set cindent
set showmatch
set backspace=indent,eol,start
set clipboard=unnamed
set pastetoggle=<F12>
set guioptions+=a

" tab
set tabstop=2
set expandtab
set smarttab
set shiftwidth=2
set shiftround
set nowrap


" buffer
map <silent><right> :bn<cr>
map <silent><left> :bp<cr>

" encoding
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif

set foldmethod=marker
