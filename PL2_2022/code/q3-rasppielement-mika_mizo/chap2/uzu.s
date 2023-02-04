	.equ    GPIO_BASE,  0x3f200000 
	.equ    GPFSEL0,    0x00       
	.equ    GPSET0,     0x1C       
	.equ    GPCLR0,     0x28       

	.equ    GPFSEL_VEC0, 0x01201000 @ GPFSEL0 に設定する値 (GPIO #4, #7, #8 を出力用に設定)
	.equ    GPFSEL_VEC1, 0x01249041 @ GPFSEL1 に設定する値 (GPIO #10, #12, #14, #15, #16, #17, #18 を出力用に設定)
	.equ    GPFSEL_VEC2, 0x00209249 @ GPFSEL2 に設定する値 (GPIO #20, #21, #22, #23, #24, #25, #27 を出力用に設定)

	.equ COL1_PORT, 27
	.equ COL2_PORT, 8
	.equ COL3_PORT, 25
	.equ COL4_PORT, 23
	.equ COL5_PORT, 24
	.equ COL6_PORT, 22
	.equ COL7_PORT, 17
	.equ COL8_PORT, 4
	.equ ROW1_PORT, 14
	.equ ROW2_PORT, 15
	.equ ROW3_PORT, 21
	.equ ROW4_PORT, 18
	.equ ROW5_PORT, 12
	.equ ROW6_PORT, 20
	.equ ROW7_PORT, 7
	.equ ROW8_PORT, 16

	.section .init
	.global _start
_start:
	@ LEDとディスプレイ用のIOポートを出力に設定する
	ldr     r0, =GPIO_BASE
	ldr     r1, =GPFSEL_VEC0
	str     r1, [r0, #GPFSEL0 + 0]
	ldr     r1, =GPFSEL_VEC1
	str     r1, [r0, #GPFSEL0 + 4]
	ldr     r1, =GPFSEL_VEC2
	str     r1, [r0, #GPFSEL0 + 8]

RowReset:
	mov     r1, #(1 << ROW1_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW2_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW3_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW4_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW5_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW6_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW7_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW8_PORT)
	str     r1, [r0, #GPSET0]
set1:
	mov     r1, #(1 << COL1_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << COL2_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << COL3_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << COL4_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << COL5_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << COL6_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << COL7_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << COL8_PORT)
	str     r1, [r0, #GPCLR0]
setRow1:
	mov     r1, #(1 << ROW1_PORT)
	str     r1, [r0, #GPCLR0]
	ldr r2, =0xfff
1:	
	subs r2, r2, #1
	bne 1b


resetRow1:
	mov     r1, #(1 << ROW1_PORT)
	str     r1, [r0, #GPSET0]
reset1andSet2:
	mov 	r1, #(1 << COL3_PORT)
	str	r1, [r0, #GPSET0]
	mov 	r1, #(1 << COL4_PORT)
	str	r1, [r0, #GPCLR0]
	mov	r1, #(1 << COL5_PORT)
	str	r1, [r0, #GPCLR0]
	mov	r1, #(1 << COL6_PORT)
	str	r1, [r0, #GPCLR0]
	mov	r1, #(1 << COL7_PORT)
	str	r1, [r0, #GPCLR0]
	mov 	r1, #(1 << COL8_PORT)
	str 	r1, [r0, #GPSET0]
setRow2:
	mov 	r1, #(1 << ROW2_PORT)
	str 	r1, [r0, #GPCLR0]
	ldr r2, =0xfff
1:	
	subs r2, r2, #1
	bne 1b


resetRow2:
	mov 	r1, #(1 << ROW2_PORT)
	str	r1, [r0, #GPSET0]
reset2andSet3:
	mov 	r1, #(1 << COL2_PORT)
	str	r1, [r0, #GPSET0]
	mov	r1, #(1 << COL3_PORT)
	str 	r1, [r0, #GPCLR0]
	mov 	r1, #(1 << COL5_PORT)
	str	r1, [r0, #GPSET0]
	mov 	r1, #(1 << COL6_PORT)
	str	r1, [r0, #GPSET0]
	mov	r1, #(1 << COL8_PORT)
	str	r1, [r0, #GPCLR0]
setRow3:
	mov 	r1, #(1 << ROW3_PORT)
	str 	r1, [r0, #GPCLR0]
	ldr r2, =0xfff
1:	
	subs r2, r2, #1
	bne 1b

resetRow3:
	mov 	r1, #(1 << ROW3_PORT)
	str 	r1, [r0, #GPSET0]
reset3andSet4:
	mov	r1, #(1 << COL1_PORT)
	str 	r1, [r0, #GPSET0]
	mov 	r1, #(1 << COL2_PORT)
	str	r1, [r0, #GPCLR0]
	mov 	r1, #(1 << COL4_PORT)
	str	r1, [r0, #GPSET0]
	mov 	r1, #(1 << COL5_PORT)
	str 	r1, [r0, #GPCLR0]
	mov 	r1, #(1 << COL6_PORT)
	str	r1, [r0, #GPCLR0]
	mov 	r1, #(1 << COL7_PORT)
	str	r1, [r0, #GPSET0]
setRow4:
	mov 	r1, #(1 << ROW4_PORT)
	str 	r1, [r0, #GPCLR0]
	ldr r2, =0xfff
1:	
	subs r2, r2, #1
	bne 1b


resetRow4:
	mov 	r1, #(1 << ROW4_PORT)
	str 	r1, [r0, #GPSET0]
reset4andSet5:
	mov 	r1, #(1 << COL1_PORT)
	str 	r1, [r0, #GPCLR0]
	mov 	r1, #(1 << COL2_PORT)
	str	r1, [r0, #GPSET0]
	mov	r1, #(1 << COL4_PORT)
	str 	r1, [r0, #GPCLR0]
	mov 	r1, #(1 << COL5_PORT)
	str 	r1, [r0, #GPSET0]
	mov 	r1, #(1 << COL7_PORT)
	str	r1, [r0, #GPCLR0]
	mov	r1, #(1 << COL8_PORT)
	str	r1, [r0, #GPSET0]
setRow5:
	mov 	r1, #(1 << ROW5_PORT)
	str 	r1, [r0, #GPCLR0]
	ldr 	r2, =0xfff
1:
	subs r2, r2, #1
	bne 1b


resetRow5:
	mov 	r1, #(1 << ROW5_PORT)
	str 	r1, [r0, #GPSET0]
reset5andSet6:
	mov 	r1, #(1 << COL2_PORT)
	str 	r1, [r0, #GPCLR0]
	mov 	r1, #(1 << COL3_PORT)
	str 	r1, [r0, #GPSET0]
	mov 	r1, #(1 << COL5_PORT)
	str	r1, [r0, #GPCLR0]
	mov 	r1, #(1 << COL7_PORT)
	str 	r1, [r0, #GPSET0]
	mov 	r1, #(1 << COL8_PORT)
	str 	r1, [r0, #GPCLR0]
setRow6:
	mov	r1, #(1 << ROW6_PORT)
	str	r1, [r0, #GPCLR0]
	ldr 	r2, =0xfff
1:
	subs r2, r2, #1
	bne 1b

resetRow6:
	mov 	r1, #(1 << ROW6_PORT)
	str 	r1, [r0, #GPSET0]
reset6andSet7:
	mov 	r1, #(1 << COL3_PORT)
	str 	r1, [r0, #GPCLR0]
	mov	r1, #(1 << COL4_PORT)
	str 	r1, [r0, #GPSET0]
	mov	r1, #(1 << COL6_PORT)
	str	r1, [r0, #GPSET0]
	mov 	r1, #(1 << COL7_PORT)
	str	r1, [r0, #GPCLR0]
setRow7:
	mov 	r1, #(1 << ROW7_PORT)
	str	r1, [r0, #GPCLR0]
	ldr 	r2, =0xfff
1:
	subs r2, r2, #1
	bne 1b

resetRow7:
	mov 	r1, # (1 << ROW7_PORT)
	str 	r1, [r0, #GPSET0]
reset7andSet8:
	mov	r1, #(1 << COL4_PORT)
	str	r1, [r0, #GPCLR0]
	mov	r1, #(1 << COL5_PORT)
	str	r1, [r0, #GPSET0]
	mov	r1, #(1 << COL6_PORT)
	str	r1, [r0, #GPCLR0]
setRow8:
	mov 	r1, #(1 << ROW8_PORT)
	str	r1, [r0, #GPCLR0]
	ldr	r2, =0xfff
1:
	subs r2, r2, #1
	bne 1b
	b RowReset

loop:	b loop
	
