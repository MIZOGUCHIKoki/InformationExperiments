	.include "common.h"
	.equ SW1_PORT, 13
	
	.section .init
	.global _start
_start:
	ldr	r0, =GPIO_BASE
	ldr	r1, =GPFSEL_VEC0
	str	r1, [r0, #GPFSEL0 + 0]
	ldr	r1, =GPFSEL_VEC1
	str	r1, [r0, #GPFSEL0 + 4]
	ldr	r1, =GPFSEL_VEC2
	str	r1, [r0, #GPFSEL0 + 8]
	
	ldr	r1, =frame_buffer
	ldr	r5, =(1 << ROW1_PORT | 1 << ROW2_PORT | 1 << ROW3_PORT | 1 << ROW4_PORT | 1 << ROW5_PORT | 1 << ROW6_PORT | 1 << ROW7_PORT | 1 << ROW8_PORT)
	str	r5, [r0, #GPSET0]

	mov	sp,	#STACK						
	mov	r3,	#0x1

	mov	r2, #0
	mov	r9, #0x80

	

loop0:
	ldr	r11, =0xff
	
	ldr	r10, [r0, #0x0034]
	tst	r10, #(1 << SW1_PORT)
	beq	hyouji

	lsr 	r4, r2, #3
	ldrb	r5, [r1, r4]
	and	r6, r2, #7
	lsr	r8, r9, r6
	eor	r5, r5, r8
	strb	r5, [r1, r4]

	add 	r2, r2, #1
	cmp	r2, #64
	moveq	r2, #0
	
	
hyouji:
	
	bl	display
	subs	r11, r11, #1
	bne hyouji

	b loop0


loop:	b	loop

	
	.section .data
	.global frame_buffer
frame_buffer:
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	

	
	
