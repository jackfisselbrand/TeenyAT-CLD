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

	str [ CLS ], rZ
	str [ CURVIS ], rZ

	set rD, 0
	set rE, 0

	str [ X1 ], rD
	str [ Y1 ], rE
	set rC, 1
	str [ FGCOLOR ], rC
	
	set rA, !cld



!main
	cmp rA, !cld_end
	je !done



!get_next_char
	lod rB, [ rA ]
	inc rA

	cmp rB, 0
	je !get_next_line

	str [ CHAR ], rB
	str [ PRINT ], rZ
	jmp !get_next_char



!get_next_line
	dly 100000
	set rD, 0
	inc rE
	
	str [ X1 ], rD
	str [ Y1 ], rE

	lod rC, [ RAND ]
	mod rC, 15
	inc rC

	str [ FGCOLOR ], rC

	jmp !main



!reset_color
	set rC, 1
	str [ FGCOLOR ], rC
	jmp !main



!done
	set rD, 0
	set rE, 0

	str [ X1 ], rD
	str [ Y1 ], rE
	
	set rA, !cld


	jmp !main


!cld
	.raw "________/\\\\\\\\\__/\\\______________/\\\\\\\\\\\\____        "
	.raw " _____/\\\////////__\/\\\_____________\/\\\////////\\\__       "
	.raw "  ___/\\\/___________\/\\\_____________\/\\\______\//\\\_      "
	.raw "   __/\\\_____________\/\\\_____________\/\\\_______\/\\\_     "
	.raw "    _\/\\\_____________\/\\\_____________\/\\\_______\/\\\_    "
	.raw "     _\//\\\____________\/\\\_____________\/\\\_______\/\\\_   "
	.raw "      __\///\\\__________\/\\\_____________\/\\\_______/\\\__  "
	.raw "       ____\////\\\\\\\\\_\/\\\\\\\\\\\\\\\_\/\\\\\\\\\\\\/___ "
	.raw "        _______\/////////__\///////////////__\////////////_____"
!cld_end
