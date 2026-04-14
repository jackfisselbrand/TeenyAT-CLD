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

!main
	lod rA, [ KEY ]
	cmp rA, 0
	jg !print
	jmp !main

!print
	cmp rA, 8
	je !backspace
	cmp rA, 127
	je !backspace
	
	cmp rA, 10
	je !return
	cmp rA, 13
	je !return

	str [ CHAR ], rA

	str [ PRINT ], rZ

	jmp !main

!backspace
	lod rD, [ X1 ]
	dec rD
	str [ X1 ], rD

	set rC, ' '
	str [ CHAR ], rC
	str [ STAMP ], rZ
	jmp !main

!return
	lod rD, [ Y1 ]
	inc rD
	str [ Y1 ], rD
	str [ X1 ], rZ

	set rC, ' '
	str [ CHAR ], rC
	str [ STAMP ], rZ
	jmp !main