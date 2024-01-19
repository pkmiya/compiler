/* プログラム 7.5 : 関数main() （MainFunc.c，134, 135ページ） */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "VSM.h"

static int ExecSW = 1, ObjOutSW = 0, TraceSW = 0, StatSW = 0;
static INSTR Iseg;

int readObject(char file[]) {
    FILE *fp;
    fp = fopen(file, "r");
    while(fscanf(fp, "%d,%d,%lf", &Iseg.Op, &Iseg.Reg, &Iseg.Addr) != EOF)
        SetI(Iseg.Op, Iseg.Reg, Iseg.Addr);
    fclose(fp);

    return 0;
}

int main(int argc, char *argv[]) {
    if(argc > 1) {
        SetPC(0);
        readObject(argv[1]);
        DumpIseg(0, PC() - 1);
        
        printf("Enter execution phase\n");
        if(StartVSM(0, TraceSW) != 0)
            printf("Execution aborted\n");
    }

    return 0;
}
