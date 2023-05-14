" vim: set com=b\:\" tw=79 fo=croq2:
"
" User commands:
" _ls	loads vim's current directory.
" _LS	loads the current file's directory. (it doesn't work on a [No File]).
"
" or 'edit' the directory ("vim /tmp/", or from vim with ":e .", ":sp ~/bin",
" etc., sometimes a trailing "/" is needed)
"
" Magic Keys:
"
" In normal mode:
"   <Return>	On a file entry.  Loads the file/directory.
"   <Return>	On a line starting with ":" executes the line as a :-command.
"   <Return>	On any other line.  Executes the 'listing command' (normally
"               ":r!ls -lLa /home/user" displayed on line 1)
"   <C-N>	Moves the cursor to the next file entry.
"   		([count]<C-N> also works:  9<C-N>)
"   <C-P>	Moves the cursor to the previous file entry.
"               ([count]<C-P> also works:  9<C-P>)
"   o		Same as <Return> but it splits the window first.
"   U		Loads the parent directory. (The current buffer is not deleted).
"   R		Refresh (executes the 'listing command').
"   Q		Quit.
"
"   %		(Un)Tag a file entry.  It can be used alone on the current line,
"		or from the visual to toggle the tag of the selected lines.
"
" The next commands create a new window which prompts the user to execute a
" command on the tagged files (or the current file if there are no tagged
" files).  <Tab> may be used to expand " filenames in insert mode.
" Use "done" to execute the command. "Q" can be used to quit without executing
" the command.
"
"   _CP		Copy the file(s) to another place.
"   _MV		Move the file(s) to another place.
"   _LN		Link the file(s) to another place.
"   _SLN	Link (symbolic) the file(s) to another place.
"   _MK		Make directories (the given files are used as a template)
"   _RM		Remove the file(s) (directories have to be empty)
"   _RF		Remove (force) the file(s) (rm -rf is used, directories are
"		removed recursively).  BE CAREFUL with this one.
"
" In insert mode:
"   <Return>	Exits insert mode and does the same as <Return> in normal mode.
"   <Tab>	Expands filenames.
"   		(These commands are useful to edit the listing-command.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The internal macros start with "__" and end with "-".
"
" __CQ-  quotes all the shell metachararacters in the lines so each line can
"	 be seen as a single pathname. (normally used just in the current
"	 line: 1__CQ-) cursor: same line, but might end on column 1.
"	 pattern: :-search (& therefore last-search too), replace.
"
" __LS-  if the lines has a pathname, it strips the first occurrence of
"	 following "patterns": (anything might be before or after them)
"	 //something//../  ->	/   (// means at least 1 / in a row)
"	 //../		  ->	/   (/../ at the beginning of the pathname)
"     				    (// means at least 1 / in a row)
"	 //./		  ->	/   (// means at least 1 / in a row)
"	 //		  ->	/   (// means at least 2 / in a row)
"	 cursor: same line,  but might end on column 1.  pattern: all.
"
" __L1-  Adds the 'listing command' (:r!ls -lLA <dir>) in line 1, which is
"	 always needed to get the (macro's) working directory. <dir> quoted
"	 with __LQ-.  cursor: line 1, just before the dir. name.
"	 register:-,"
" __L1C- checks if the first line is a :-command, calls __L1- if not.  Calls
"	 __LS- to strip the dir. name.  (an aux. map is used: __LA-)
"	 cursor: line 1, might end in col 1.  register: -," (iff _L1- called).
"	 pattern: search patterns changed.
"
" __LLs- Gets the listing command in the line 1, adds a trailing / if needed
"	 and then executes the register, adds a / to the directories names, and
"	 :set's nomod.  cursor: line 4, after the last space.	pattern: all.
" __LC-  this macro is executed on a line which starts with ":", assuming it
"	 is a :-command, the line is *copied* (to ensure there are at least 2
"	 lines in the buf.) to the first line, all the other lines are removed,
"	 if the line starts with ":r!ls" the macro __LLs- is used otherwise it
"	 is executed.  cursor: same of __LLs- when executed or line 1 col 1.
"	 register: :-command in ",0.  (0: :-command) the previous buf. contents
"	 deleted -> 1.  pattern: search, (all when __LLs-).
"
" __LBD- It creates a normal-command to display the file whose name appears in
"	 the current line and destroys the current window (to keep the window
"	 dimensions something must be loaded before bdelete the current
"	 window, but if the old buf. is :bdeleted after loading the new one
"	 then we'd end with nothing if the old and new files are the same) so
"	 /dev/null is temporarily loaded to avoid that.  register: .
"
" __LK-  It creates a normal-command to split the window to display the file
"	 whose name appears in the current line (the old buffer is kept).
"	 register: .
"
" __LF-  called when <CR> is typed in a line which looks like a file entry, it
"	 expects the filename in register 0 (yank), the listing command on line
"	 1 (to get the dir. name), and a macro __LFP- mapped to either __LBD-
"	 or __LK- depending on whether the current buf. is going to be deleted
"	 or kept.  It quotes the filename, adds the dir., __LS-strips it,
"	 loads that file by executing the command generated by __LFP- and
"	 finally shows the file info (:f), note that it explicitly jumps to
"	 line 1 to avoid "Press return" msgs.  cursor: line 1, col 1.(sure?)
"	 register: ", - (loading command).  patterns: all.
"
" __LN-  if the cursor is at the start of a line with a file entry, then this
"	 macro moves the cursor to the beginning of the filename, (note that
"	 3E2l must not be replaced with 4W or the macro will get confused with
"	 filenames made completely with spaces/tabs)
"
" __LWh- sets [Wh]ich action will be done by the macro __LD- depending on
"	 whether the current line looks like a file entry, a :-command, or
"	 none (when none the listing command is executed) finally calls __LD-.
"	 patterns: all.  registers: depend on __LD-
"
" %	 it toggles the tag (leading % char.) of the selected lines (default
"	 just the current) cursor: below the end of the selected area.
"	 patterns: all.
"
" __LSC- puts the current line, and all the tagged ones in register l, the
"	 listing command is yanked, then splits a new window
"	 (/Command:_<command name from macro __L_C->), pastes the register l
"	 as the first paragraph and the second paragraph is a white space
"	 followed by the working directory (gotten from the listing command)
"	 this line is yanked (without the trailing NL) and finally the macros
"	 __CI- and __CB- are called.  After that the first paragraph has
"	 quoted pathnames with a leading space, the second paragraph remains
"	 the same, and a banner is added as the third paragraph.
"	 cursor: last line, last char, of a new window.
"
" _CP, _MV, _LN, _SLN
"	 these macros call __LSC to create a new window which prompts the user
"	 to copy/move/link/symbolic-link the given files (tagged files, if
"	 there are none, the file on the current line, if it doesn't list a
"	 file then the working directory:) to the (macro's)working directory.
"	 the cursor is left at the end of working directory name so it can be
"	 easily edited.
"
" _MK	 call __LSC to create a new window which prompts the user to create
"	 directories (the given files are used as a template) 
"
" _RF	 call __LSC to create a new window which prompts the user to delete
"	 the given files, and directories.  rm -rf is used!! directories are
"	 removed recursively.
" _RM	 same as RF but it uses rm on files and rmdir on directories, (so
"	 directories must be empty)
"
" <CR>	 in insert-mode goes to normal mode and then execute the normal-mode's
"	 macro <CR>.
" <Tab>  in insert mode, expands file names.
"
" <CR>	 normal-mode set __LFP- to __LBD-, and then calls __LWh- which means
"	 that a new file/directory is going to be loaded and the current
"	 buffer will be removed.
"
"    on a line with a file entry, that file (or directory) is loaded.
"    on a line starting with : that line is executed as a :-command.
"    on any other line the 'listing command' (normally on line 1) is executed.
"
" <C-N>	moves the cursor to the next line, and then calls __LN- from the
"	beginning of the line to jump to the next file name.
"	[count]<C-N> works too.
"
" <C-P>	moves the cursor to the previous line, and then calls __LN- from the
"	beginning of the line to jump to the next file name.
"	[count]<C-P> works too.
"
" o	set __LFP- to __LK- and then calls __LWh-, so works like <CR> but
"	doesn't destroy the current buffer, it splits the window instead.
"
" U	loads parent directory. (current buffer is not deleted)  it first
"	checks for the listing command and adds a /../ at the end of the line,
"	strips the directory's name, and executes the listing command, finally
"	the buffer's name is set accordingly to the directory's.
" Q	quit
" R	refresh (executes the 'listing command')
"
" __+-  refresh, just as R.  Called by the /Command:_*'s macro "done".  This is
"	the only internal macro without a L/C in it's name.  That's because when
"	"__+-" is interpreted the cursor may or may not be in the listing window,
"	so, it has to be harmless in a "normal" buffer (where it just moves the
"	cursor to the first non-blank in the line)
"
" The buffer's refresh is automatically done when it is empty.
"
"
" in the buffers /Command:_*
" __CJ-	 joins the lines in a paragraph without adding or removing any space.
" __CJ2- same but with 2 paragraphs.
"
" done	 filters the buffer through $SHELL, if no messages (errors) are
"	 returned then the window is deleted, otherwise the window displays
"	 those messages and "u" (undo) can be used to get back the previous
"	 contents of the buffer.  Finally, "__+-" is executed, it is harmless
"	 in a normal buffer, but in the listing window it refreshes the listing.
"
" Q	 quit.
" <Tab>  insert-mode expand filenames.
" <CR>   insert-mode exits insert-mode.
"
" __CB-  prints a banner at the end of the buffer giving instructions.
"
" __CI-  (called from __LSC-) it gets the former current line (aka. default)
"	 as line 1 and the tagged lines (if any) from line 2 on, then checks
"	 line 2, if there were tagged lines then the default line is removed,
"	 then line 1 has either the default line or the first of the tagged
"	 files, if this line doesn't look like a file entry then it is
"	 replaced with a dummy entry to the "./" file. finally __CP- is called
"	 to generate the full pathname.
"
" __CP-  selects the first paragraph which is a list of file entries, then 4
"	 global commands are executed, 1) remove everything but the filename,
"	 2)quote (__CQ-) those filenames, 3) add the directory name (which is
"	 obtained from the yank buffer) and finally 4) strips (__LS-) the
"	 pathnames.
"
" Last modified: 961206 Raúl Segura Acevedo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

au!BufEnter */,.,..,/Command:_* no__CQ- :g/\([];&><()~$*? <C-I>\\\[#\|^]\)/s//\\\1/g<CR>
au BufEnter */,.,..,/Command:_* no__LS- :g-\(/\+[^/]*\)\=/\+\.\./\<BAR>/\+\.\=/-s--/-<CR>
au BufEnter */,.,.. nm__L1- :0r!echo :r1ls -lLa %:p/<CR>f1r!0dt/1__CQ-0P
au BufEnter */,.,.. nm__L1C- :nm__LA- 1G<BAR>1v-^:-nm__LA- __L1-<CR>__LA-1__LS-
au BufEnter */,.,.. nm__LLs- :1v-/$-s-$-/<CR>yy@0:g-^d-s-$-/<CR>:g/[^:].*[0-9] [A-Z]/s/^/  <CR>1G__LN-
au BufEnter */,.,.. nm__LC- yy1GPjdG:nm__LD- @0<Bar>1g-^:r!ls-nm__LD- __LLs-<CR>__LD-:set nomod<CR>
au BufEnter */,.,.. nn__LBD- I:e!/dev/null<Bar>bd!#<bar>e<End><Bar>bd#<Esc>
au BufEnter */,.,.. nn__LK- Iu<C-V><C-O>:set nomod<Bar>sp<Esc>
au BufEnter */,.,.. nm__LF- 0dt/D"0p1__CQ-0"-P1__LS-__LFP-y1G@":f<CR>1G
au BufEnter */,.,..,/Command:_* nm__LN- /[0-9] [A-Z]<CR>3E2l
au BufEnter */,.,.. nm__LWh- :nm__LD- __LC-<Bar>.g/^[ %]/nm__LD- __LF-<BAR>norm __LN-y$<CR>:.g/^:/nm__LD- __LC-<Bar>t0<CR>__L1C-__LD-

au BufEnter */,.,.. nm % v%|vn % :g/^%/s//x<CR>:'<,'>g/^ /s//%<CR>:'<,'>g/^x/s// <CR>:set nomod<CR>:" toggle tag<CR>`>j
au BufEnter */,.,.. nm __LSC- "lyy__L1C-yy``:g/^%/y L<CR>:5sp/Command:___L_C-_(from_%)<BAR>cu __L_C-<CR>1GdG"lPG"0pt/d0yl3P0y$__CI-__CB-
au BufEnter */,.,.. nm _CP :cno__L_C- cp<CR>__LSC-1G0icp<Esc>__CJ2-
au BufEnter */,.,.. nm _MV :cno__L_C- mv<CR>__LSC-1G0imv<Esc>__CJ2-
au BufEnter */,.,.. nm _LN :cno__L_C- ln<CR>__LSC-1G0iln<Esc>__CJ2-
au BufEnter */,.,.. nm _SLN :cno__L_C- ln-s<CR>__LSC-1G0iln -s<Esc>__CJ2-
au BufEnter */,.,.. nm _RF :cno__L_C- rm-rf<CR>__LSC-{d{{irm -rf<Esc>__CJ-
au BufEnter */,.,.. nm _RM :cno__L_C- rm<CR>__LSC-{kddmy:1,-2g-/$-m'y-<CR>:.g-/$-norm {j0irmdir<C-V><ESC>__CJ-<CR>:1g/./norm 0irm<C-V><Esc>__CJ-<CR>
au BufEnter */,.,.. nm _MK :cno__L_C- mk<CR>__LSC-{d{{imkdir__CJ-

au BufEnter */,.,.. im<CR> <Esc><CR>|im<TAB> <C-X><C-F>
au BufEnter */,.,.. nm<CR> :nm__LFP- __LBD-<CR>__LWh-
au BufEnter */,.,.. nm<C-N> +__LN-:"next"<CR>|nm<C-P> -__LN-:"previous"<CR>
au BufEnter */,.,.. nm o   :nm__LFP- __LK-<CR>__LWh-
au BufEnter */,.,.. nm U   __L1C-A/../<Esc>1__LS-__LC-1G0f/y$:f <C-R>"<CR>
au BufEnter */,.,.. nm Q   :bd!<CR>
au BufEnter */,.,.. nm R __L1C-__LC-|nm__+- __L1C-__LC-
au BufEnter */,.,.. set magic|nm__LA- dummy|nm__LFP- dummy
" [R]efresh only iff the buffer is empty
au BufEnter */,.,.. nn__LD- ma|.v/./nm __LD- R
au BufEnter */,.,.. norm__LD-

au!BufLeave */,.,.. unm__CQ-|unm__LS-|unm__L1-|unm__L1C-|unm__LLs-|unm__LC-
au BufLeave */,.,.. unm__LBD-|unm__LK-|unm__LF-|unm__LN-|unm__LWh-
au BufLeave */,.,.. unm__LD-|unm__LA-|unm__LFP-|iun<CR>|iun<Tab>
au BufLeave */,.,.. nun<CR>|nun<C-N>|nun<C-P>|nun o|nun U|nun Q|nun R|nun__+-
au BufLeave */,.,.. unm %|unm_CP|unm_MV|unm_LN|unm_SLN|unm_RF|unm_RM|unm__LSC-|unm_MK

map _ls :sp.<CR>3G$B
map _LS :sp%:p:h/<CR>3G$B

au BufEnter /Command:_* nn__CJ- vp:j!<CR>:set nomod<CR>$
au BufEnter /Command:_* nn__CJ2- v2p:j!<CR>:set nomod<CR>$
" maybe someday...
" au BufEnter /Command:_* nm done :%!$SHELL<CR>:g/./err<CR>:bd!<CR>my__+-`y
au BufEnter /Command:_* nm done :%!$SHELL<CR>:g/./err<CR>:bd!<CR>__+-
au BufEnter /Command:_* nn Q :bd!<CR>
au BufEnter /Command:_* ino<TAB> <C-X><C-F>|ino<CR> <Esc>
au BufEnter /Command:_* nn__CA- dummy
au BufEnter /Command:_* nn __CB- Go<NL># Normal-mode: Type "done" to execute the command, "Q" to quit.<NL># Insert-mode: Tab to expand filenames, Return go to Normal mode.<Esc><<<<

au BufEnter /Command:_* nm__CI- :2g/^%/1d<CR>:1v/^[% ]/s-.*-69 N u l ./<CR>__CP-
au BufEnter /Command:_* nm__CP- 1Gv}k:g/[0-9] [A-Z]/norm n3E2ld0<CR>gv__CQ-gv:g/^/norm "0P<CR>gv__LS-
au BufEnter /Command:_* set tw=0
au!BufLeave /Command:_* unm__CQ-|unm__LS-|unm__LN-|unm__CI-|unm__CP-
au BufLeave /Command:_* unm__CB-|unm__CJ2-|unm__CJ-|unm__CA-
au BufLeave /Command:_* iu<Tab>|iu<CR>|unm Q|unm done
