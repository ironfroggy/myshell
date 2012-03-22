set expandtab     " Do not insert tab when <Tab> was pressed - insert a number of spaces
set shiftwidth=4  " Number of spaces to use for each step of (auto)indent
set tabstop=4     " Number of spaces that a <Tab> in the file counts for
set softtabstop=4   " less than 4 may result in breaking of lists

" Force myself to learn more vi movements
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

set undofile
set undodir=$TEMP
