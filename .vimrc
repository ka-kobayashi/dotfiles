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

filetype on
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


" バッファー切り替えを左右キーで。
map <silent><right> :bn<cr>
map <silent><left> :bp<cr>
"map cdfile :cd<Space>%:h<cr>

" encoding
set encoding=utf-8
"set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8
set fileencodings=utf-8
set foldmethod=marker

" タグジャンプを PageUP/Down, Home/End にアサイン。
"http://blog.veryposi.info/programing/php/php-ctags-vim/
map <silent><PageUp> <C-T> 
map <silent><PageDown> <C-]>
map <silent><Home> :tags<cr>
map <silent><End> :ts<cr>
" tagsジャンプの時に複数ある時は一覧表示                                        
nnoremap <C-]> g<C-]> 


"phpファイル保存と同時に文法チェック
" augroup phpsyntaxcheck
" autocmd!
"autocmd BufWrite *.php w !php -l
" augroup END

" PHP parser check (CTRL-L)
autocmd FileType php noremap <C-H> :!/usr/bin/php -l %<CR>


command! -nargs=0 CdCurrent cd %:p:h

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle'))
endif
NeoBundle 'airblade/vim-gitgutter'
map <silent><F12> :GitGutterLineHighlightsToggle<cr>
map <silent><F10> <Plug>GitGutterNextHunk
map <silent><F11> <Plug>GitGutterPrevHunk


" Ctrl-e で Toggle. ▼の文字化け対策 
NeoBundle 'scrooloose/nerdtree'
nnoremap <silent><C-e> :NERDTreeToggle<CR>
" if &termencoding !=# 'utf-8'
  " let g:NERDTreeDirArrows=0
" endif


" ,, でコメントの切り替え
NeoBundle 'scrooloose/nerdcommenter'
let NERDSpaceDelims = 1
nmap ,, <Plug>NERDCommenterToggle
vmap ,, <Plug>NERDCommenterToggle


" インデントに着色
NeoBundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#262626 ctermbg=0
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3c3c3c ctermbg=233
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#262626 ctermbg=234
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3c3c3c ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#262626 ctermbg=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3c3c3c ctermbg=8
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 4


syntax enable
set background=dark
" colorscheme desert
" highlight LineNr ctermfg=darkgrey

"" solarized color
NeoBundle 'altercation/vim-colors-solarized'
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized


" カレント行ハイライト
set cursorline

" NeoBundle 'joonty/vdebug'

"http://qiita.com/alpaca_taichou/items/ab2ad83ddbaf2f6ce7fb
NeoBundle 'Shougo/vimproc', { 'build' : { 'mac' : 'make -f make_mac.mak', 'unix' : 'make -f make_unix.mak', }, }
NeoBundle 'tpope/vim-rails', { 'autoload' : {'filetypes' : ['haml', 'ruby', 'eruby'] }}
NeoBundle 'alpaca-tc/vim-endwise.git', { 'autoload' : { 'insert' : 1, }}
NeoBundle 'edsono/vim-matchit', { 'autoload' : { 'filetypes': 'ruby', 'mappings' : ['nx', '%'] }}
NeoBundleLazy 'alpaca-tc/alpaca_tags', {
      \ 'rev' : 'development',
      \ 'depends': ['Shougo/vimproc', 'Shougo/unite.vim'],
      \ 'autoload' : {
      \   'commands' : ['AlpacaTags', 'AlpacaTagsUpdate', 'AlpacaTagsSet', 'AlpacaTagsBundle', 'AlpacaTagsCleanCache'],
      \   'unite_sources' : ['tags']
      \ }}
NeoBundle "git://github.com/Shougo/neocomplcache.git"
NeoBundle "git://github.com/tsukkee/unite-tag.git"

" *.php を読み込んだ際に symfony のタグを読み込む
" ctags -R -f ~/.tags.symfony --langmap=PHP:.php.inc /usr/local/symfony/1.4
autocmd BufNewFile,BufRead *.php set tags+=~/.tags.symfony

" ctags の自動実行: https://github.com/alpaca-tc/alpaca_tags
augroup AlpacaTags
  autocmd!
  if exists(':Tags')
    autocmd BufWritePost *.rb  TagsUpdate ruby
    autocmd BufWritePost *.php TagsUpdate symfony
    autocmd BufWritePost *.inc TagsUpdate symfony
    autocmd BufWritePost Gemfile TagsBundle
    autocmd BufEnter * TagsSet
  endif
augroup END
" AlpacaTags から ctags へのオプション設定。--php-types については、ctags --list-kinds=php を参照。
let g:alpaca_update_tags_config = {
      \ '_' : '-R --sort=yes --languages=-js,html,css',
      \ 'ruby': '--languages=+Ruby',
      \ 'php': '--languages=+PHP --langmap=PHP:.php.inc --php-types=c+f+d+i',
      \ 'symfony': '--languages=+PHP --langmap=PHP:.php.inc --php-types=c+f+d+i --exclude=web --exclude=cache --exclude=log --exclude=data --exclude=templates --exclude=migration --exclude=vendor --exclude=sandbox',
      \ }
nnoremap <expr>tt  ':Unite tag -horizontal -buffer-name=tags -input='.expand("<cword>").'<CR>'


" Unite
" noremap <C-U><C-B> :Unite buffer<CR>
" noremap <C-U><C-F> :UniteWithBufferDir -buffer-name=files file<CR>
" noremap <C-U><C-R> :Unite file_mru<CR>

filetype plugin on
filetype indent on
