	.equ	COUNT,	1500000
	.include 			"common.s"

	.section .init
	.global _start

@ Free register: r2
@ Reserved register: r0, r1, r3, r4, r5, r6
@ GPFSEL0 = 0x00, GPFSEL1 = 0x04, GPFSEL2 = 0x08

_start:
	ldr	r0,	=GPIO_BASE
	ldr	r1,	=TIMER_BASE

	ldr	r2, =GPFSEL_VEC1_LED
	str	r2,	[r0, #GPFSEL1]

	ldr	r3,	=COUNT
	mov	r4,	#(1 << LED_PORT)

	ldr	r5,	[r1,	#GPFSEL1]	@ start time
	add	r5,	r5,	r3					@ target turn off time

on:
	ldr		r6,	[r1, #GPFSEL1]	@ current time
	cmp		r6,	r5
	strcc	r4,	[r0, #GPSET0] 	@ below [Turn on]	r6 < r5
	bcc		on
	str		r4,	[r0, #GPCLR0] 	@ Turn off
	add		r5,	r3
off:
	ldr		r7,	[r1, #GPFSEL1]
	cmp		r7,	r5
	bcc		off
	add	r5,	r5,	r3					@ target turn off time
	b on
