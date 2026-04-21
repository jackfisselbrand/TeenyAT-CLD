.const X1 0x9000
.const Y1 0x9001
.const CURVIS 0x9002
.const CHAR 0x9003
.const FGCOLOR 0x9004
.const BGCOLOR 0x9005
.const KEY 0x9006
.const PRINT 0x9007
.const STAMP 0x9008
.const CLS 0x9009
.const RCOLOR 0x900A
.const RCURVIS 0x900B

	str [ CLS ], rZ
	
	set rA, rZ
	set rB, rZ
	str [ X1 ], rA
	str [ Y1 ], rB

!main
	lod rD, [ KEY ]

	;;; check for backspace and return
	cmp rD, 8 ; 8 in ascii is the backspace character
	je !backspace
	cmp rD, 127 ; 127 in ascii is delete
	je !backspace 

	cmp rD, 10 ; 10 in ascii is the linefeed character
	je !return
	cmp rD, 13 ; 13 in ascii is the carraige return character
	je !return

	cmp rD, 27 ; 27 in ascii is escape
	je !exit

	cmp rD, 0
	je !main

!print
	str [ CHAR ], rD
	str [ PRINT ], rZ
	jmp !main

!backspace
	lod rA, [ X1 ]
	dec rA

	cmp rA, 0
	jl !upline

	str [ X1 ], rA
	
	set rC, ' '
	str [ CHAR ], rC

	str [ STAMP ], rZ

	jmp !main

!return
	lod rB, [ Y1 ]
	inc rB

	cmp rB, 23
	je !main

	str [ X1 ], rZ
	str [ Y1 ], rB

	str [ STAMP ], rZ

	jmp !main


!upline
	lod rB, [ Y1 ]
	dec rB

	cmp rB, 0
	jl !main

	str [ Y1 ], rB
	lod rA, [ X1 ]

!find_last_char
	inc rA
	str [ X1 ], rA
	lod rC, [ CHAR ]
	cmp rC, 0
	jne !find_last_char	

	str [ STAMP ], rZ

	jmp !main

!exit
	jmp !exit