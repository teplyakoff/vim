source ~/.vim/settings.vim
"--------------------------+
"        General           |
"--------------------------+
"pathogen
let g:pathogen_disabled = []
if !has('gui_running')
   call add(g:pathogen_disabled, 'powerline')
endif

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" set <leader> key 
let mapleader = ","
let g:mapleader = ","

" autoreload vimrc
autocmd! bufwritepost .vimrc source ~/.vimrc

" gundo 
nnoremap <F6> :GundoToggle<CR>

" folding
set foldenable                  " enable folding
set foldcolumn=2                " add a fold column
set foldmethod=marker           " detect triple-{ style fold markers
set foldlevelstart=99           " start out with everything folded
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
                                " which commands trigger auto-unfold
function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . ' …' . repeat(" ",fillcharcount) . foldedlinecount . ' '
endfunction
set foldtext=MyFoldText()

" file options
set fileencodings=utf8
set encoding=utf8 nobomb " utf-8 with out BOM
set termencoding=utf-8 " default text encoding
set ff=unix " default file format

" not compatible with the old-fashion vi mode
set nocompatible


"--------------------------+
"        Appearance        |
"--------------------------+
" color shceme
colorscheme molokai
let g:molokai_original=1

" status line
set laststatus=2
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %{&fileformat}\ [LEN=%L]

" show line numbers
set nu

" Show incomplete commands in statusbar
set showcmd

" always show cursor
set ruler

" command bar height
set ch=1

" highlight syntax
syntax on

" enable highlight
set list

" non-printable characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_

" 256 color mode
set t_Co=256

" the first guy to show bracket after entering the second
set showmatch

" show brackets for html
set matchpairs+=<:>

"higlight search result
set hlsearch 


"--------------------------+
"           Misc           |
"--------------------------+
" hide mouse pointer when printing
set mousehide 

" yank to the system register (*) by default
set clipboard=unnamed

" Enable filetype plugins
filetype on
filetype plugin on
filetype indent on
au FileType php set omnifunc=phpcomplete#CompletePHP

" no *~ backup and swap files
set nobackup
set nowritebackup
set noswapfile

" auto update files
set autoread 

" folding by indentation
set nofoldenable

" set 7 lines to the cursor - when moving vertically using j/k
set so=7 

" enable autoident
set autoindent

" tabs
set expandtab " tab to spaces
set shiftwidth=4 "size of tab
set softtabstop=4
set tabstop=4

" enable smart indent
set smartindent

" Fix <Enter> for comment
set fo+=cr

" Выключаем надоедливый "звонок"
set novisualbell
set t_vb=   

" session options
set sessionoptions=curdir,buffers,tabpages

" allow to use backspace instead of "x"
set backspace=indent,eol,start whichwrap+=<,>,[,]

" a buffer becomes hidden when it is abandoned
"set hidden

" mouse
set mouse=a
set mousemodel=popup


"--------------------------+
"         Mapping          |
"--------------------------+
"C-q - comment/uncomment (NERD_Comment)
map <C-q> <leader>ci
nmap <C-q> <leader>ci
imap <C-q> <ESC><leader>cii

" PHP documenter script bound to Control-K
autocmd FileType php inoremap <C-K> <ESC>:call PhpDocSingle()<CR>i
autocmd FileType php nnoremap <C-K> :call PhpDocSingle()<CR>
autocmd FileType php vnoremap <C-K> :call PhpDocRange()<CR>

"disable arrows
map <left> <nop>
map <right> <nop>
map <up> <nop>
map <down> <nop>

" C-c and C-v - Copy/Paste to global clipboard
vmap <C-C> "+yi
imap <C-v> <esc>"+gPi

" C-d - duplicate current line
imap <C-d> <esc>yypi

" fast search and replace word under  cursor
nmap <C-h> :%s/\<<c-r>=expand("<cword>")<cr>\>/

" Swap ; and :
map ; :
noremap ;; ;


" F5 - show buffers
nmap <F5> <Esc>:BufExplorer<cr>
vmap <F5> <esc>:BufExplorer<cr>
imap <F5> <esc><esc>:BufExplorer<cr>

" < & > - indent of blocks
vmap < <gv
vmap > >gv

" auto insert ]
imap [ []<LEFT>

" auto insert }
imap {<CR> {<CR>}<Esc>

" reselct paste text
nnoremap <leader>v V`]

" quick exit to normal mode
inoremap jj <ESC>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" copy current doc - open new tab - paste doc
map <leader>co ggVGy:tabnew<cr>:<cr>pgg

" useful search
nnoremap / /\v
vnoremap / /\v

" folding
map <leader>zc :EnablePHPFol<cr>
map <leader>zo :DisablePHPFold<cr>

nnoremap <leader>a :Ack

" marks browser
map <leader>m :MarksBrowser<cr>

" Tagbar plugin
nmap <F8> :TagbarToggle<cr>
let g:tagbar_left = 1
let g:tagbar_width = 30
let g:tagbar_iconchars = ['▶', '◢']
let g:tagbar_sort = 0


let g:ctrlp_extensions = ['tag','changes','mixed']
set runtimepath^=~/.vim/bundle/kien-ctrlp.vim/plugin/ctrlp.vim
let g:ctrlp_use_caching = 1
let g:ctrlp_cache_dir = '~/.vim/.cache/ctrlp'

set autochdir
let NERDTreeChDirMode=2
nnoremap <leader>n :NERDTree .<CR>

