/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#define SYNTH
#include <stdio.h>
#ifdef SYNTH
#include "platform.h"
#include "xil_printf.h"
#endif

int *APB = XPAR_APB_M_0_BASEADDR;

int main()
{
	int inMdata, outMdata;
	int inSdata, outSdata;
	int Mbusy, Sbusy;
#ifdef SYNTH
    init_platform();

    printf("Hello World\n\r");
#endif
    inMdata = 0x81234563;
    inSdata = 0x86543213;
#ifdef SYNTH
    printf("Master input %x Slave input %x\n\r",inMdata,inSdata);
#endif

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

#ifdef SYNTH
	if (outMdata == inSdata){
    printf("Slave sent %x Master received %x PASS \n\r",inSdata,outMdata);
	} else {
    printf("ERROR : Slave sent %x Master received %x fail\n\r",inSdata,outMdata);
	};
	if (outSdata == inMdata){
    printf("Master sent %x Slave received %x PASS \n\r",inMdata,outSdata);
	} else {
    printf("ERROR : Master sent %x Slave received %x fail\n\r",inMdata,outSdata);
	};
    printf("Successfully ran Hello World application\n\r");
    cleanup_platform();
#endif
    return 0;
}
