#include <stdio.h>
#include "xparameters.h"

int *APB = XPAR_APB_M_0_BASEADDR;

int main()
{
	int inMdata, outMdata;
	int inSdata, outSdata;
	int Mbusy, Sbusy;

    inMdata = 0x81234563;
    inSdata = 0x86543213;

    APB[0x010/4] = 0x00000004;
    APB[0x008/4] = inMdata;
    APB[0x108/4] = inSdata;
    APB[0x00/4] = 0x1;
    Mbusy = APB[0x004/4];
    Sbusy = APB[0x104/4];
    while (Mbusy || Sbusy){
        Mbusy = APB[0x004/4];
        Sbusy = APB[0x104/4];
    }

    outMdata = APB[0x00c/4];
    outSdata = APB[0x10c/4];

    return 0;
}
