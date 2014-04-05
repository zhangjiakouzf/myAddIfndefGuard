" A script to automatically insert the correct #ifndef/#define/#endif guards
" for a C/C++ header file.
"
" If the file has yet to be saved (and hence has no filename), nothing will
" happen.
"
" Some examples of what this script will do:
" 
" filename: SFGameState.h
" Inserted at top of file: #ifndef SFGAMESTATE_H
"                          #define SFGAMESTATE_H
" Inserted at bottom of file: #endif
"
" filename: SFGAMESTATE.cpp
" Inserted at top of file: #ifndef SFGAMESTATE_H
"                          #define SFGAMESTATE_H
" Inserted at bottom of file: #endif
" NOTE: It doesn't check to see if the current file ends with a .h
"
" NOTE: It doesn't yet check to see if there already is a
" #ifndef/#define/endif sequence. Make sure to not call this more than one per
" file. There is no way to automatically remove the added text, it can only be
" removed by hand.
"
" 
" This script is in the public domain.
"
" Last Update: Saturday, 19th Febuary 2005
" Maintainer: Rory McCann <ebelular at gmail dot com>

function AddIfndefGuardH()

	let s:uppercase_filename = toupper(expand("%:t:r"))

	" The current file might not have been saved, hence it wouldn't have a
	" filename. In this case s:uppercase_filename would be empty. The
	" function will only do stuff if uppercase_filename is nonempty

	if strlen(s:uppercase_filename) != 0
		
		let s:header_guard = "__" . s:uppercase_filename . "_H__"

		echo s:header_guard

		" It's possible the user has already created ifndef guard code
		" (or called this function on this file), so we need to check
		" for that... in a later version. >:)
		
		" Add the text to the start and end of the file.

		call append(0, "#ifndef ".s:header_guard)
		call append(1, "#define ".s:header_guard)
		call append(2, "#include \"common.h\"")
		call append(3, "")
		call append(4, "namespace alimail{")
		call append(5, "")
		call append(6, "class XXX{")
		call append(7, "public:")
		call append(8,"\tXXX();")
		call append(9,"\t~XXX();")
		call append(10,"private:")
		call append(11,"")
		call append(12,"};")
		call append(13,"")
		let s:last_line = line('$')
		call append(s:last_line-1, "};")
		call append(s:last_line,"#endif")

	endif

endfunction

function AddIfndefGuardC()

	let s:uppercase_filename = tolower(expand("%:t:r"))

	" The current file might not have been saved, hence it wouldn't have a
	" filename. In this case s:uppercase_filename would be empty. The
	" function will only do stuff if uppercase_filename is nonempty

	if strlen(s:uppercase_filename) != 0
		


		" It's possible the user has already created ifndef guard code
		" (or called this function on this file), so we need to check
		" for that... in a later version. >:)
		
		" Add the text to the start and end of the file.

		call append(0, "#include \"".s:uppercase_filename.".h\"")
		call append(1, "")
"		call append(2, "BEG_DEF_NAMESPACE_IMAP4AGENT")
		call append(3, "")
		call append(4, "XXX::XXX(){")
		call append(5, "}")
		call append(6,"")
		call append(7, "XXX::~XXX(){")
		call append(8, "}")
		call append(9,"")
		let s:last_line = line('$')
"		call append(s:last_line-1, "END_DEF_NAMESPACE_IMAP4AGENT")

	endif

endfunction
function AddNameSpaceGuard()
	call append(5 ,"BEG_DEF_NAMESPACE_IMAP4AGENT")
	let s:last_line = line('$')
	call append(s:last_line-1 , "END_DEF_NAMESPACE_IMAP4AGENT")
endfunction
function AddMainTemplate()
	call append(0, "#include <iostream>")
	call append(1, "using namespace std;")
	call append(2, "int main(int argc, char ** argv){")
	call append(3, "	int ret=0;")
	call append(4, "	cout << argv[0] << \" return:\" << ret << endl;")
	call append(5, "	return ret;")
	call append(6 ,"}")
"	let s:last_line = line('$')
"	call append(s:last_line-1 , "END_DEF_NAMESPACE_IMAP4AGENT")
endfunction

function UseNameSpaceGuard()
	call append(5 ,"USE_NAMESPACE_SMTP")
endfunction

command! -nargs=0 HEADH :call AddIfndefGuardH()
command! -nargs=0 HEADC :call AddIfndefGuardC()
command! -nargs=0 MAIN  :call AddMainTemplate()
command! -nargs=0 DEFNS :call AddNameSpaceGuard()
command! -nargs=0 USENS :call UseNameSpaceGuard()
