	.include	"common.h"
	.section 	.init
	.global 	_start
_start:
	ldr	r0, =GPIO_BASE
	ldr	r1, =GPFSEL_VEC0
	str	r1, [r0, #GPFSEL0 + 0]
	ldr	r1, =GPFSEL_VEC1
	str	r1, [r0, #GPFSEL0 + 4]
	ldr	r1, =GPFSEL_VEC2
	str	r1, [r0, #GPFSEL0 + 8]

@ COL:列	RAW:行
@ r行c列<=> (r,c)
@ r == 0 && c == 1 -> 点灯
	ldr	r3,	=row		@ row port number
	mov	r4,	#0			@ rowLoopVar::i
	ldr	r5,	=frame_buffer		@ Read frame_buffer's address
rowLoop:
	bl		clear		@ clear
	ldrb	r6,	[r5, r4]	@ Read only 1byte form frame_buffer offset
	ldrb	r7,	[r3, r4]	@ Read only 1byte	form Row_Port
	mov		r8,	#0		@ colLoopVar::j0
	mov		r9,	#7		@ colLoopVar::j1
	ldr		r2,	=col		@ col port number 
colLoop:
	mov		r12,	#0x01
	ldrb	r10,	[r2, r8]	@ Read only 1byte form Col_Port
	and		r1,	r6,	r12,	lsl	r9
	cmp		r1,	#0
	lsl		r1,	r12,	r10
	strne	r1,	[r0, #GPSET0]		@ 1 -> SET
	streq	r1,	[r0, #GPCLR0]		@ 0 -> CLE
	add		r8,	r8,	#1
	sub		r9,	r9,	#1
	cmp		r8,	#8
	bne		colLoop
@rowLoopE
	mov		r12,	#0x01
	lsl		r1,	r12, r7
	str		r1,	[r0, #GPCLR0]
	bl		waite
	add		r4,	r4,	#1
	cmp		r4,	#8
	moveq	r4,	#0
	b			rowLoop

@ Port number
col:
	.byte	27,	8, 25, 23, 24, 22, 17, 4
row:
	.byte	14,	15,	21,	18,	12,	20,	7, 16

@ initialize
clear:
	ldr	r1, =(1 << ROW1_PORT | 1 << ROW2_PORT | 1 << ROW3_PORT | 1 << ROW4_PORT | 1 << ROW5_PORT | 1 << ROW6_PORT | 1 << ROW7_PORT | 1 << ROW8_PORT)
	str	r1, [r0, #GPSET0]
	bx	r14

@ waite method
waite:
	ldr	r1,	=0xff
	1:
		subs	r1,	r1,	#1
		bne		1b
	bx	r14
frame_buffer:
	.byte 0x1e, 0x21, 0x4c, 0x92, 0x49, 0x22,0x14, 0x08
