	.equ	ON,	750000
	.equ	SEC,	1000000

	.include	"common.s"

	.section 	.init
	.global		_start

_start:
	ldr	r0,	=GPIO_BASE
	ldr	r1,	=TIMER_BASE

	ldr	r2, 	=GPFSEL_VEC1_LED
	str	r2,	[r0, #GPFSEL1]

	mov	r4,	#(1 << LED_PORT)

	ldr	r6,	=ON
	ldr	r12,	=SEC
	
	ldr	r5,	[r1,	#GPFSEL1]
	add	r11,	r5, 	r6

loop0:
	ldr	r9,	[r1, #GPFSEL1]
	cmp	r5,	r9
	strcc	r4,	[r0, #GPSET0]
	addcc	r5,	r5,	r12
	cmp	r11,	r9
	strcc	r4,	[r0, #GPCLR0]
	addcc	r11,	r11,	r12
	b	loop0

loop:	b	loop
