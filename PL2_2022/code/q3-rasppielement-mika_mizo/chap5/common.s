	.equ	GPIO_BASE,		0x3f200000 

	.equ	GPFSEL0,			0x00       
	.equ	GPFSEL1,			0x04
	.equ	GPFSEL2,			0x08

	.equ	GPSET0,     	0x1C       
	.equ	GPCLR0,     	0x28       

	@ GPFSEL0 Display
	.equ	GPFSEL_VEC0,	0x01201000 
	@ GPFSEL1 LED, Display, Speacker
	.equ	GPFSEL_VEC1,	0x11249041
	@ GPFSEL2 Display
	.equ	GPFSEL_VEC2, 	0x00209249 

@ initialize stack pointer
	.equ	STACK,				0x8000

@ define port number
	@ LED Light
	.equ	LED_PORT,			10
	@ LED Display
	.equ	COL1_PORT, 		27
	.equ	COL2_PORT, 		8
	.equ	COL3_PORT, 		25
	.equ	COL4_PORT, 		23
	.equ	COL5_PORT, 		24
	.equ	COL6_PORT, 		22
	.equ	COL7_PORT, 		17
	.equ	COL8_PORT, 		4
	.equ	ROW1_PORT, 		14
	.equ	ROW2_PORT, 		15
	.equ	ROW3_PORT, 		21
	.equ	ROW4_PORT, 		18
	.equ	ROW5_PORT, 		12
	.equ	ROW6_PORT, 		20
	.equ	ROW7_PORT, 		7
	.equ	ROW8_PORT, 		16
@ Timer base
	.equ	TIMER_BASE,		0x3f003000
@ Switch Port
  .equ  SW_1,      		13
  .equ  SW_2,      		26
  .equ  SW_3,      		5
  .equ  SW_4,      		6
@ Speacker
	.equ	CM_BASE,	 		0x3f101000
	.equ	CM_PWMCTL, 		0xa0
	.equ	CM_PWMDIV, 		0xa4
@ PWM
	.equ	PWM_BASE,	 		0x3f20c000
	.equ	PWM_RNG2,	 		0x20
	.equ	PWM_DAT2,	 		0x24
	.equ	PWM_CTL,	 		0x00
	.equ	PWM_MSEN2, 		15
	.equ	PWM_PWEN2, 		8
