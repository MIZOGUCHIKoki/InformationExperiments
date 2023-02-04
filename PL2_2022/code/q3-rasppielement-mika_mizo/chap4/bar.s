	.include	"common.s"

	.equ	T,	3000000

	.section	.init
	.global		_start

_start:
	ldr	r0,	=GPIO_BASE
	ldr	r1, 	=GPFSEL_VEC0
	str	r1,	[r0, #GPFSEL0 + 0]
	ldr	r1,	=GPFSEL_VEC1
	str	r1,	[r0, #GPFSEL0 + 4]
	ldr	r1, 	=GPFSEL_VEC2
	str	r1,	[r0, #GPFSEL0 + 8]

	ldr	r1,	=(1 << ROW2_PORT | 1 << ROW3_PORT | 1 << ROW4_PORT | 1 << ROW5_PORT | 1 << ROW6_PORT | 1 << ROW7_PORT | 1 << ROW8_PORT)
	str	r1,	[r0, #GPSET0]
	ldr	r1,	=(1 << ROW1_PORT)
	str	r1,	[r0, #GPCLR0]

	ldr	r2,	=T
	ldr	r3,	=TIMER_BASE
	ldr	r4,	[r3, #GPFSEL1]

	ldr	r5,	=waite
	ldr	r6,	=port

	mov	r7,	#15
	mov	r12,	#1
	
set:
	ldr	r8,	[r5, r7, lsl #2]
	add	r8,	r8,	r4
	str	r8,	[r5, r7, lsl #2]
	subs	r7, 	r7,	#1
	bpl	set

loop0:
	mov	r7,  	#15
	ldr	r8,	[r3, #GPFSEL1]

loop1:
	ldr	r9,	[r5, r7, lsl #2] @目標時刻
	cmp	r8,	r9
	bmi	endp

	add	r9,	r9,	r2
	str	r9,	[r5, r7, lsl #2]
	and	r10,	r7, 	#7
	ldrb	r11,	[r6, r10]
	lsl	r11,	r12,	r11

	mov	r10,	r7, lsr #3
	cmp	r10,	#1
	bmi	on

off:
	str	r11,	[r0, #GPCLR0]
	b	endp

on:
	str	r11,	[r0, #GPSET0]

endp:
	subs	r7,	r7,	#1
	bpl	loop1
	b loop0


	.section	.data

waite:
	.word	0x00, 0x3e80, 0x13880, 0x2ee00,	0x55f00, 0x88b80, 0xc7380, 0x111700,0x2625a0, 0x25e720, 0x24ed20, 0x2337a0, 0x20c6a0, 0x1d9a20, 0x19b220, 0x150ea0

port:
	.byte 	27, 8, 25, 23, 24, 22, 17, 4
