#include <stdio.h>
#include <stdlib.h>

#include "teenyat.h"
#include "RogueWrapper/roguewrapper.h"

#define X1 0x9000
#define Y1 0x9001
#define CURVIS 0x9002
#define CHAR 0x9003
#define FGCOLOR 0x9004
#define BGCOLOR 0x9005
#define KEY 0x9006
#define PRINT 0x9007
#define STAMP 0x9008
#define CLS 0x9009
#define RCOLOR 0x900A
#define RCURVIS 0x900B

void bus_read(teenyat *t, tny_uword addr, tny_word *data, uint16_t *delay);
void bus_write(teenyat *t, tny_uword addr, tny_word data, uint16_t *delay);

int main(int argc, char** argv) {	
	FILE* tny_bin_file = fopen(argv[1], "rb");
	
	if (tny_bin_file == NULL) {
		printf("File does not exist\n");
		return EXIT_FAILURE;
	}

	teenyat t;
	tny_init_from_file(&t, tny_bin_file, bus_read, bus_write);
	setvbuf(stdout, NULL, _IONBF, 0);

	setPrintOffsetX(2);
	setPrintOffsetY(2);

	for (;;) {
		tny_clock(&t);
	}

	printf("\n");
	return EXIT_SUCCESS;

}

void bus_read(teenyat *t, tny_uword addr, tny_word *data, uint16_t *delay) {
	switch (addr) {
		case X1:
			data->u = getX1Pos();
			break;
		case Y1:
			data->u = getY1Pos();
			break;
		case CURVIS:
			data->u = getCursorVis();
		case CHAR:
			data->u = getCharacter();
			break;
		case FGCOLOR:
			data->u = getFgColor();
		case BGCOLOR:
			data->u = getBgColor();
			break;
		case KEY:
			data->u = getKeyPress();
			break;
		default:
			return;
	}

	return;
}



void bus_write(teenyat *t, tny_uword addr, tny_word data, uint16_t *delay){
	switch (addr) {
		case X1:
			setX1Pos(data.u);
			break;
		case Y1:
			setY1Pos(data.u);
			break;
		case CURVIS:
			setCursorVis(data.u);
			break;
		case CHAR:
			setCharacter(data.u);
			break;
		case FGCOLOR:
			setFgColor(data.u);
			break;
		case BGCOLOR:
			setBgColor(data.u);
			break;
		case PRINT:
			print();
			break;
		case STAMP:
			stamp();
			break;
		case CLS:
			clear();
			break;
		case RCOLOR:
			clearColor();
			break;
		case RCURVIS:
			resetCursorVis();
			break;
		default:
			return;
	}

	return;
}