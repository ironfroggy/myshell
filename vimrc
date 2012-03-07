set nocompatible " TODO: Learn what this really does

set expandtab     " Do not insert tab when <Tab> was pressed - insert a number of spaces
set shiftwidth=4  " Number of spaces to use for each step of (auto)indent
set tabstop=4     " Number of spaces that a <Tab> in the file counts for
set softtabstop=4   " less than 4 may result in breaking of lists

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

syntax on

" Force myself to learn more vi movements
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Highlight search and CTRL+L to clear the highlight
:set hlsearch
:nnoremap <silent> <C-l> :noh<CR><C-l>

" xmllint shortcut
" one or more lines:
vmap ,px !xmllint --format -<CR>
" pretty-print current line
nmap ,px !!xmllint --format -<CR>

" sort lines
vmap ,ss !sort <CR>
nmap ,ss :0<CR>VG!sort<CR>

" filetype settings
filetype on
filetype plugin on
filetype indent on

set linebreak
set showbreak=.\ 

autocmd FileType * setlocal nolinebreak
autocmd FileType * setlocal showbreak=
