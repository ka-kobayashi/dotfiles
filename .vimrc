set nocompatible

"display 
set number
set ruler
set cmdheight=2
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set statusline+=\ [%{strftime('%H:%M')}]  " 時間
set title
set linespace=0
set wildmenu
set showcmd



"syntax color
syntax on
"colorscheme ron
colorscheme desert
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
"map cdfile :cd<Space>%:h<cr>

" encoding
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif

set foldmethod=marker

"http://blog.veryposi.info/programing/php/php-ctags-vim/
autocmd BufRead,BufNewFile *.php set tags+=~/.tags.php
"set tags+=~/.tags
map <silent><PageUp> <C-T> 
"map <silent><C-[> <C-T> 
map <silent><PageDown> <C-]>
map <silent><Home> :tags<cr>
map <silent><End> :ts<cr>

"phpファイル保存と同時に文法チェック
"augroup phpsyntaxcheck
"autocmd!
"autocmd BufWrite *.php w !php -l
"augroup END

command! -nargs=0 CdCurrent cd %:p:h

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle'))
endif
NeoBundle 'airblade/vim-gitgutter'
map <silent><F12> :GitGutterLineHighlightsToggle<cr>
map <silent><F10> <Plug>GitGutterNextHunk
map <silent><F11> <Plug>GitGutterPrevHunk


"http://qiita.com/alpaca_taichou/items/ab2ad83ddbaf2f6ce7fb
NeoBundle 'Shougo/vimproc', { 'build' : { 'mac' : 'make -f make_mac.mak', 'unix' : 'make -f make_unix.mak', }, }
NeoBundle 'tpope/vim-rails', { 'autoload' : {'filetypes' : ['haml', 'ruby', 'eruby'] }}
NeoBundle 'alpaca-tc/vim-endwise.git', { 'autoload' : { 'insert' : 1, }}
NeoBundle 'edsono/vim-matchit', { 'autoload' : { 'filetypes': 'ruby', 'mappings' : ['nx', '%'] }}
NeoBundleLazy 'alpaca-tc/alpaca_tags', {
      \ 'rev' : 'development',
      \ 'depends': ['Shougo/vimproc', 'Shougo/unite.vim'],
      \ 'autoload' : {
      \   'commands' : ['Tags', 'TagsUpdate', 'TagsSet', 'TagsBundle', 'TagsCleanCache'],
      \   'unite_sources' : ['tags']
      \ }}

" NERDTree: Ctrl-e で Toggle. ▼の文字化け対策
NeoBundle 'scrooloose/nerdtree'
nnoremap <silent><C-e> :NERDTreeToggle<CR>
if &termencoding !=# 'utf-8'
  let g:NERDTreeDirArrows=1
endif


" ,, でコメントの切り替え
NeoBundle 'scrooloose/nerdcommenter'
let NERDSpaceDelims = 1
nmap ,, <Plug>NERDCommenterToggle
vmap ,, <Plug>NERDCommenterToggle


" コマンドモード時にemacs風の移動
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>

" ~/.ctagsにctagsの設定ファイルを設置します。現在無い人は、このディレクトリ内の.ctagsをコピーしてください。
" 適切なlanguageは`ctags --list-maps=all`で見つけてください。人によりますので。
let g:alpaca_tags_config = { '_' : '-R --sort=yes --languages=-js,html,css', 'ruby': '--languages=+Ruby'}
augroup AlpacaTags
  autocmd!
  if exists(':Tags')
    autocmd BufWritePost * TagsUpdate ruby
    autocmd BufWritePost Gemfile TagsBundle
    autocmd BufEnter * TagsSet
  endif
augroup END
nnoremap <expr>tt  ':Unite tags -horizontal -buffer-name=tags -input='.expand("<cword>").'<CR>'

filetype plugin on
filetype indent on

