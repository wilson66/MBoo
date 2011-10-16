;-----------------------------------------
;
;  Audio Extract Program, MBoo Project
;
;-----------------------------------------

.386
.model flat, stdcall
option casemap:none

include		windows.inc
include		masm32.inc
includelib	masm32.lib
include		kernel32.inc
includelib	kernel32.lib
include		user32.inc
includelib	user32.lib
;-------------------------------------------
.data?
szArg1			BYTE	128 DUP(?)
szArg2			BYTE	128 DUP(?)
szSWFFileName	BYTE	128 DUP(?)
szOutput		BYTE	1024 DUP(?)
szBuffer		BYTE	1024 DUP(?)
;-------------------------------------------
.const 
szUsageMessage	BYTE	'Audio Extract Utility, Usage: ae swf_filename mp3_filename',0dh,0ah,0
sz0D0A			BYTE	0dh, 0ah, 0
szErrorStr2		BYTE	0dh,0ah,'Error, file not found!',0
szFormat1		BYTE	'arg[1]£º%s',0dh,0ah,'arg[2]£º%s',0dh,0ah,0
;-------------------------------------------
.code
include		_Cmdline.asm
start:
	invoke _argc		; count the command line arg
	.if (eax != 3)
		invoke	StdOut, offset szUsageMessage
		invoke	ExitProcess,NULL
	.endif

	invoke	ArgClC, 1, offset szArg1			;place arg1 into the buffer szArg1
	invoke	ArgClC, 2, offset szArg2			;place arg1 into the buffer szArg2

	invoke	StdOut, offset szArg1
	invoke	StdOut, offset sz0D0A
	invoke	StdOut, offset szArg2
	invoke	ExitProcess,NULL

	invoke	GetPathOnly, offset szArg1,  offset szBuffer
	invoke	StrLen, offset szBuffer
	.if (eax == 0 )						;only file name
		invoke	GetAppPath, offset szSWFFileName		
	.endif
	
	invoke  szCatStr, offset szSWFFileName,  offset szArg1
	invoke	exist,offset szSWFFileName			;the swf file is exist?
	.if (eax == 0 )
		invoke StdOut, offset szSWFFileName		;swf file absolute path
		invoke StdOut, offset szErrorStr2
		invoke	ExitProcess,NULL
	.endif	

	invoke	wsprintf,addr szOutput,addr szFormat1,addr szArg1,addr szArg2
	invoke	StdOut, offset szOutput
	invoke	ExitProcess,NULL
end start
