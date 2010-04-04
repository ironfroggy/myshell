"""""""""""""""""""""
" Jamie's .vimrc file
"""""""""""""""""""""

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Remove all autocommands.
autocmd!

:set guifont=lucidasanstypewriter-12
:set guifont=DejaVu\ Sans\ Mono\ 10
:set guifont=Bitstream\ Vera\ Sans\ Mono\ 12

" line numbers on:
" set number

" have no idea!
set beautify

syntax on

" bells
set noerrorbells
set vb t_vb=

" set background=light
" highlight Normal guibg=black guifg=white 
"
" CUSTOM COLOR SCHEMES:

" colorscheme marklar
" colorscheme wombat
" colorscheme anotherdark
" colorscheme aqua.vim
" colorscheme asmanian2 " forced background color

" Standard Color Schemes:
" colorscheme evening
" colorscheme blue
" colorscheme darkblue
" colorscheme default
colorscheme delek
" colorscheme desert
" colorscheme elflord
" colorscheme evening
" colorscheme koehler
" colorscheme morning
" colorscheme murphy
" colorscheme pablo
" colorscheme peachpuff
" colorscheme ron
" colorscheme shine
" colorscheme torte
" colorscheme zellner
" colorscheme peachpuff

set expandtab     " Do not insert tab when <Tab> was pressed - insert a number of spaces
set shiftwidth=4  " Number of spaces to use for each step of (auto)indent
set tabstop=4     " Number of spaces that a <Tab> in the file counts for
set softtabstop=4   " less than 4 may result in breaking of lists

autocmd FileType javascript set textwidth=0

set bs=2		" allow backspacing over everything in insert mode
set ai			" always set autoindenting on
"if has("vms")

set nobackup		" do not keep a backup file, use versions instead
"else
"  set backup		" keep a backup file
"endif

set history=500		" keep x lines of command line history
set ruler		" show the cursor position all the time

" hi Comment term=bold ctermfg=DarkGreen guifg=#80a0ff
" hi Constant term=underline ctermfg=DarkCyan guifg=#333333

" set background=light
" if &background=="light"
"	hi Comment term=bold ctermfg=DarkGreen guifg=#80a0ff
"	hi Constant term=underline ctermfg=gray guifg=#333333
" endif


" enable filetype detection:
filetype on


" 
" " Set options for python files
" autocmd FileType python set autoindent smartindent
" \ cinwords=class,def,elif,else,except,finally,for,if,try,while
" \ makeprg=compyle4vim.py
" \ errorformat=%E\ \ File\ \"%f\"\\,\ line\ %l\\,\ column\ %c,%C%m |
" \ execute "autocmd BufWritePost " . expand("%") . " call DoPython()"
" 
" " Compile (clearing *.cgi[co] files after compilation)
" " and if it is script, make it executable
" function DoPython()
" !compyle %
" if expand("%:e") != "py"
" !rm -f %[co]
" endif
" if getline(1) =~ "^#!"
" !chmod +x %
" endif
" endfunction
" 
" " Set options for text/html files
" autocmd BufReadPre *.txt,*README*,*.htm*,/tmp/pico.*,mutt-* set textwidth=75
" autocmd BufReadPre /tmp/pico.*,mutt-* set filetype=mail
" autocmd FileType css set smartindent
" 

" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
" (despite the mappings later):
autocmd FileType make set noexpandtab shiftwidth=8


" I like highlighting strings inside C comments
let c_comment_strings=1
let c_minlines=10000

" Python
au BufNewFile,BufRead *.py,*.mps      setf python

" filename [+=-] (path) - VIM
"         Where:
"                 filename        the name of the file being edited
"                 -               indicates the file cannot be modified, 'ma' off
"                 +               indicates the file was modified
"                 =               indicates the file is read-only
"                 =+              indicates the file is read-only and modified
"                 (path)          is the path of the file being edited
"                 - VIM           the server name |v:servername| or "VIM"

set title titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)

"""""""""""""""""""""""""""""""""""""""
" VST (restructured text plugin
"""""""""""""""""""""""""""""""""""""""
let g:vst_css_default=""
" String (empty). When unmodified default CSS will be included in HTML file. When non-empty default CSS will be written to external file. Existing file will be overwritten without warning. If equal to NONE (case sensitive) any reference to default CSS will be skipped. 
let g:vst_css_user=""
" String (empty). When non-empty link to specified file will be included.
"
"
let g:vst_write_export=1
let g:vst_pdf_view=1
let g:vst_pdf_viewer="kpdf"
let g:vst_pdf_clean=1
let g:vst_pdf_command="pdflatex -interaction=nonstopmode"
nmap _V :w<CR>:Vsti<CR>:w<CR>:bd<CR>
":Vsti pdf<CR>:w<CR>:bd<CR>
au BufNewFile,BufRead *txt      se syntax=rest
au BufNewFile,BufRead *rst      se syntax=rest
au BufNewFile,BufRead *rest     se syntax=rest
" autocmd FileType rst set noexpandtab
"  set formatoptions+=tqn
"  set formatlistpat=^\\s*\\(\\d\\+\\\|[a-z]\\)[\\].)]\\s*

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" buffer movement
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Use the arrows to do something useful
" map <right> :bn<cr>
" map <left> :bp<cr>

"  map <ESC>OA <Up>
"  map <ESC>OB <Down>
"  map <ESC>OC <Right>
"  map <ESC>OD <Left>
"  imap <ESC>OA <Up>
"  imap <ESC>OB <Down>
"  imap <ESC>OC <Right>
"  imap <ESC>OD <Left>
"

" :map <M-Esc>[62~ <MouseDown>
" :map! <M-Esc>[62~ <MouseDown>
" :map <M-Esc>[63~ <MouseUp>
" :map! <M-Esc>[63~ <MouseUp>
" :map <M-Esc>[64~ <S-MouseDown>
" :map! <M-Esc>[64~ <S-MouseDown>
" :map <M-Esc>[65~ <S-MouseUp>
" :map! <M-Esc>[65~ <S-MouseUp>
" 
hi Type	term=underline ctermfg=Blue guifg=#60ff60
hi Normal term=underline ctermfg=Green guifg=#60ff60

" delete from cursor position to string 'END' anywhere in file:
:map _x d/END/e<CR>

" autocmd CursorHold *.py BikeShowScope

au FileType python source ~/.vim/python-menu.vim


set viminfo='500,f1
"set viminfo='200,\"500	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
" " When editing a file, always jump to the last cursor position
" autocmd BufReadPost * if line("'\"") | exe "normal `\"" | endif
" autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
"
" set viminfo='10,\"100,:20,%,n~/.viminfo 

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GO to where you WERE BEFORE!!
" When vim is opened, put you back to where you were.
""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup JumpCursorOnEdit 
  au! 
  autocmd BufReadPost * 
    \ if expand("<afile>:p:h") !=? $TEMP | 
    \   if line("'\"") > 1 && line("'\"") <= line("$") | 
    \     let JumpCursorOnEdit_foo = line("'\"") | 
    \     let b:doopenfold = 1 | 
    \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) | 
    \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 | 
    \        let b:doopenfold = 2 | 
    \     endif | 
    \     exe JumpCursorOnEdit_foo |         
    \   endif | 
    \ endif 
  " Need to postpone using "zv" until after reading the modelines. 
  autocmd BufWinEnter * 
    \ if exists("b:doopenfold") | 
    \   exe "normal zv" | 
    \   if(b:doopenfold > 1) | 
    \       exe  "+".1 | 
    \   endif | 
    \   unlet b:doopenfold | 
    \ endif 
augroup END 

" python highlighting
" doesn't work for some reason
"let python_highlight_all = 1
"syn match   pythonComment       "log\.*$"


""""""""""""""""""""""""""""""""""""""""""""""""""""""
" mouse everywhere
""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set mouse=a
set mouse=
" Next fixes screen+vim mouse problems
"set ttymouse=xterm2

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Window Movement Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" control-arrows to move between windows
" right
nnoremap [1;5C l
" left
nnoremap [1;5D h
" up
nnoremap [1;5A k
" down
nnoremap [1;5B j

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fold Columns
""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn ON the fold columns in the regular window (you can click on it
" in text-mode vim -- yay!)

:function! Togglefoldcolumn() 
:   if &foldcolumn==3
:       se foldcolumn=0
:   else 
:       se foldcolumn=3
:   endif
:   echo "foldcolumn="&foldcolumn
:endfunction 
:command! Togglefoldcolumnnow call Togglefoldcolumn() 
:noremap <F9> :Togglefoldcolumnnow<cr>
" se foldcolumn=3

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Python Setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" this is AWESOME:
""" http://blog.sontek.net/2008/05/11/python-with-a-modular-ide-vim/

" There are 2 ways to add your ability to jump between python class libraries, the first is to setup vim to know where the Python libs are so you can use gf to get to them (gf is goto file). You can do this by adding this snippet to your .vimrc:

python << EOF
import os
import sys
import vim
for p in sys.path:
    if os.path.isdir(p):
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF

" With that snippet you will be able to go to your import statements and hit gf on one of them and itll jump you to that file.

" Continuing accessibility of the Python class libraries we are going to want to use ctags to generate an index of all the code for vim to reference:

" $ ctags -R -f ~/.vim/tags/python.ctags /usr/lib/python2.5/

" and then in your .vimrc

set tags+=$HOME/.vim/tags/python.ctags
" this is GREAT but 3.9MB!!!
set tags+=$HOME/.vim/tags/bz.ctags

" This will give you the ability to use CTRL+] to jump to the method/property under your cursor in the system libraries and CTRL+T to jump back to your source code.

" I also have 2 tweaks in my .vimrc so you can use CTRL+LeftArrow and CTRL+RightArrow to move between the files with more natural key bindings.

" (ignored, see above)

" map <silent><C-Left> <C-T>
" map <silent><C-Right> <C-]>

" You can also see all the tags youve been to with :tags

" To enable code completion support for Python in Vim you should be able to add the following line to your .vimrc:

autocmd FileType python set omnifunc=pythoncomplete#Complete
" 
" but this relies on the fact that your distro compiled python support into vim (which they should!).
" 
" Then all you have to do to use your code completion is hit the unnatural, wrist breaking, keystrokes CTRL+X, CTRL+O. Ive re-bound the code completion to CTRL+Space since we are making vim an IDE! Add this command to your .vimrc to get the better keybinding:
" 
inoremap <Nul> <C-x><C-o>

" http://www.vim.org/scripts/script.php?script_id=910
"
let g:pydoc_cmd="/usr/bin/pydoc"


" The other must-have feature of an IDE when browsing code is being able
" to open up multiple files in tabs. To do this you type :tabnew to open
" up a file in a new tab and than :tabn and :tabp to move around the
" tabs. Add these to lines to your .vimrc to be able to move between the
" tabs with ALT+LeftArrow and ALT+RightArrow:
"
map <silent><A-Right> :tabnext<CR>
map <silent><A-Left> :tabprevious<CR>

""" Python Debugging / F7 and Shift-F7 to add/remove breakpoints
""" just launch your application with !python % (percent being the current file, you can declare your main file here if its different).

" To add debugging support into vim, we use the pdb module. Add this to your ~/.vim/ftplugin/python.vim to have the ability to quickly add break points and clear them out when you are done debugging:

python << EOF
def SetBreakpoint():
    import re
    nLine = int( vim.eval( 'line(".")'))

    strLine = vim.current.line
    strWhite = re.search( '^(\s*)', strLine).group(1)

    vim.current.buffer.append(
       "%(space)spdb.set_trace() %(mark)s Breakpoint %(mark)s" %
         {'space':strWhite, 'mark': '#' * 30}, nLine - 1)

    for strLine in vim.current.buffer:
        if strLine == "import pdb":
            break
    else:
        vim.current.buffer.append( 'import pdb', 0)
        vim.command( 'normal j1')

vim.command( 'map <f7> :py SetBreakpoint()<cr>')

def RemoveBreakpoints():
    import re

    nCurrentLine = int( vim.eval( 'line(".")'))

    nLines = []
    nLine = 1
    for strLine in vim.current.buffer:
        if strLine == 'import pdb' or strLine.lstrip()[:15] == 'pdb.set_trace()':
            nLines.append( nLine)
        nLine += 1

    nLines.reverse()

    for nLine in nLines:
        vim.command( 'normal %dG' % nLine)
        vim.command( 'normal dd')
        if nLine < nCurrentLine:
            nCurrentLine -= 1

    vim.command( 'normal %dG' % nCurrentLine)

vim.command( 'map <s-f7> :py RemoveBreakpoints()<cr>')
EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" End Awesome Python Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" surprisingly important ;-)
" light or dark
""""""""""""""""""""""""""""""""""""""""""""""""""""""
se background=dark

" this is cool:
" from
" http://vim.wikia.com/wiki/Remove_annoyance_with_syntax_highlighting_when_starting_a_string
" this is annoying, because " is too unevenly used
" inoremap " ""<Esc>i
" following on with the same idea... ;-)
" this one is annoying, because it gets contractions like it's
" inoremap ' ''<Esc>i
" these are great for new code, but not for editing existing code:
" inoremap { {}<Esc>i
" inoremap ( ()<Esc>i
" inoremap [ []<Esc>i
" inoremap < <><Esc>i
" inoremap <!-- <!----><Esc>hhi
"
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" F2 Tag List (exuberant Ctags)
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Exuberant Ctags
" Taglist WOOHOO
" See also http://vim-taglist.sourceforge.net/manual.html
"
" don't change window size in a terminal
" this is required in screen, but seems to work fine in konsole
" with it off
let Tlist_Inc_Winwidth=1

" change focus to tag window when it's opened
let Tlist_GainFocus_On_ToggleOpen=1

" Open this awesome plugin on startup
" probably not recommended if minibufexpl is used (so that it gets to be
" on top). ... also you should turn Tlist_GainFocus_On_ToggleOpen=0
let Tlist_Auto_Open=0

" Close vim when only tlist is left open
let Tlist_Exit_OnlyWindow=1

" single click will choose that item
" (instead of double)
let Tlist_Use_SingleClick=1

" Require automatic processing of new or modified files
let Tlist_Auto_Update=1

" ALWAYS process the files
let list_Process_File_Always=1

" Do not close tags for other files
" let Tlist_File_Fold_Auto_Close=0

" not display the Vim fold column in the taglist window
let Tlist_Enable_Fold_Column=1

" sort tags by name (instead of by chrono order in the file)
" Actually, knowing them by their file order is a bit easier ;-)
" let Tlist_Sort_Type="name"

let Tlist_WinWidth=25
let Tlist_Close_On_Select=0
let Tlist_Compact_Format=0
let Tlist_Display_Tag_Scope=0
let Tlist_File_Fold_Auto_Close=0
let Tlist_Inc_Winwidth=0

" the all-important toggle key is ALT-1
map 1 :TlistToggle<CR>
map <Meta-1> :TlistToggle<CR>
map F2 :TlistToggle<CR>

map 2 :TlistOpen<CR>
map <Meta-2> :TlistOpen<CR>

map 3 :TlistSessionLoad /mnt/non_prod/.development.taglist<CR>
map <Meta-3> :TlistSessionLoad<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" miniBufExplorer
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" F4 switch between textwidth=72 and textwidth=0
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
set textwidth=0
:function! Toggletextwidth() 
:   if &textwidth==0 
:       se textwidth=72 
:   else 
:       se textwidth=0 
:   endif
:   echo "textwidth="&textwidth 
:endfunction 
:command! Toggletw call Toggletextwidth() 
:noremap <f4> :Toggletw<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" F5 VTreeExplorer
""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <F5> :VTreeExplore<CR>
let treeExplVertical=1
let treeExplWinSize=30
let treeExplHidden=0
let TreeExplHidePattern=".*\.pyc$"
let treeExplDirSort=-1

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" F8 TagExplorer (vim ide)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" doesn't play nicely with the other children
"
nnoremap <silent> <F8> :TagExplorer<CR>
let TE_WinWidth = 20
" le winwidth = 10
let TE_Use_Horiz_Window = 0
let TE_Use_Right_Window = 1
let TE_Exclude_Dir_Pattern = 'obj.*\|.*test.*|.*old.*'
let TE_Include_File_Pattern = '.*\.py$\|.*\.txt$|.*\.html$|.*\.ini$|.*\.sh$|.*\.conf$'
let TE_Ctags_Path = '/usr/bin/ctags-exuberant'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" F11 reverse background macro
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" switch light to dark terminal
" http://www.vim.org/tips/tip.php?tip_id=53
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
:function! ReverseBackground() 
:   let Mysyn=&syntax 
:   if &bg=="light" 
:       se bg=dark 
:       highlight Normal guibg=black guifg=white 
:   else 
:       se bg=light 
:       highlight Normal guibg=white guifg=black 
:   endif   
:   syn on   
:   exe "set syntax=" . Mysyn 
:   echo "now syntax is "&syntax 
:endfunction 
:command! Invbg call ReverseBackground() 
:noremap <F11> :Invbg<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" F12 paste toggle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
:function! Togglepaste() 
:   if &paste==1
:       se nopaste
:   else 
:       se paste
:   endif
:   echo "paste="&paste
:endfunction 
:command! Togglepastenow call Togglepaste() 
:noremap <f12> :Togglepastenow<cr>I

"se pastetoggle=<f12> " toggle paste mode with f12

" map control-h and control-[ to left buffer
" and control l and control-] to right
" map  :bp<CR>
" map  :bn<CR>
" map  :bp<CR>
" map  :bn<CR>

map . :bn<CR>
map , :bp<CR>

" for gvim:
map <M-Left> :bp<CR>
map <M-Right> :bn<CR>

" map [1;3C :bn<CR>
" map [0;3D :bp<CR>
"  KONSOLE: (they totally don't seem to work in screen)
" Neat vim feature: tabs; really cool, but apparently (!) they don't
" work with most plugins
" map l :tabn<CR> " alt-right
" map h :tabp<CR> " alt-left
" map [1;3C :tabn<CR> " alt-right
" map [1;3D :tabp<CR> " alt-left
" map [1;5C :tabn<CR> " ctrl-right
" map [1;5D :tabp<CR> " ctrl-left
nnoremap x <Esc>:wqa<CR>
nnoremap w <Esc>:w<CR>

" Force myself to learn more vi movements
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
