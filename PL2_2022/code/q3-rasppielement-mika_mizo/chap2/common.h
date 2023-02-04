	.equ	GPIO_BASE,  0x3f200000 
	.equ	GPFSEL0,    0x00       
	.equ	GPSET0,     0x1C       
	.equ	GPCLR0,     0x28       

	.equ	GPFSEL_VEC0, 0x01201000 @ GPFSEL0 に設定する値 (GPIO #4, #7, #8 を出力用に設定)
	.equ	GPFSEL_VEC1, 0x01249041 @ GPFSEL1 に設定する値 (GPIO #10, #12, #14, #15, #16, #17, #18 を出力用に設定)
	.equ	GPFSEL_VEC2, 0x00209249 @ GPFSEL2 に設定する値 (GPIO #20, #21, #22, #23, #24, #25, #27 を出力用に設定)

	.equ	COL1_PORT, 27
	.equ	COL2_PORT, 8
	.equ	COL3_PORT, 25
	.equ	COL4_PORT, 23
	.equ	COL5_PORT, 24
	.equ	COL6_PORT, 22
	.equ	COL7_PORT, 17
	.equ	COL8_PORT, 4
	.equ	ROW1_PORT, 14
	.equ	ROW2_PORT, 15
	.equ	ROW3_PORT, 21
	.equ	ROW4_PORT, 18
	.equ	ROW5_PORT, 12
	.equ	ROW6_PORT, 20
	.equ	ROW7_PORT, 7
	.equ	ROW8_PORT, 16

	.equ	STACK,			0x8000
