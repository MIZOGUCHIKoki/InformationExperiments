	.include	"common.h"
	.section 	.init
	.global 	_start
_start:
	@ set to output device LED , Display
	ldr	r0,	=GPIO_BASE
	@ 0-9 の一部を出力設定
	ldr	r1,	=GPFSEL_VEC0
	str	r1,	[r0,	#GPFSEL0 + 0]	
	@ 10-19 の一部を出力設定
	ldr	r1,	=GPFSEL_VEC1
	str	r1,	[r0,	#GPFSEL0 + 4] 
	@ 20-29 の一部を出力設定
	ldr	r1,	=GPFSEL_VEC2
	str	r1,	[r0,	#GPFSEL0 + 8]
	@ turn on the (r,c) LED <=> col==1 && row==0
	bl clear
loop0:
	@ col3, row2
	ldr			r2,	=0xfff
cr32:
	mov     r1, #(1 << COL3_PORT)
	str     r1, [r0, #GPSET0]			@	COL3, set "1"
	mov     r1, #(1 << ROW2_PORT)
	str     r1, [r0, #GPCLR0]			@ ROW2,	set "0"
	subs		r2,	r2,	#1
	bne			cr32
	@ Clear
	mov			r1,	#(1 << COL3_PORT)
	str			r1,	[r0,	#GPCLR0]
	mov			r1,	#(1 << ROW2_PORT)
	str			r1,	[r0,	#GPSET0]
	@ col7,	row4
	ldr			r2,	=0xfff
cr74:
	mov			r1,	#(1 << COL7_PORT)
	str			r1,	[r0,	#GPSET0]
	mov			r1,	#(1 << ROW4_PORT)
	str			r1,	[r0,	#GPCLR0]
	subs		r2,	r2,	#1
	bne			cr74
	@ Clear
	mov			r1,	#(1 << COL7_PORT)
	str			r1,	[r0,	#GPCLR0]
	mov			r1,	#(1 << ROW4_PORT)
	str			r1,	[r0,	#GPSET0]
	b loop0
clear:
	mov     r1, #(1 << COL1_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << COL2_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << COL3_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << COL4_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << COL5_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << COL6_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << COL7_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << COL8_PORT)
	str     r1, [r0, #GPCLR0]

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
	bx			r14
loop:
	b       loop
