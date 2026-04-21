.const RAND	0x8010

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

	set rD, '#'
	str [ CLS ], rZ
	str [ CURVIS ], rZ
	str [ CHAR ], rD

	set rA, 0
	set rB, 0
	str [ X1 ], rA
	str [ Y1 ], rB
	str [ STAMP ], rZ

!main
	lod rA, [ RAND ]
	mod rA, 80
	str [ X1 ], rA

	lod rB, [ RAND ]
	mod rB, 24
	str [ Y1 ], rB

	lod rE, [ CHAR ]
	cmp rE, 0
	jne !main

	lod rC, [ RAND ]
	mod rC, 16

	str [ FGCOLOR ], rC
	str [ CHAR ], rD
	str [ STAMP ], rZ
	jmp !main