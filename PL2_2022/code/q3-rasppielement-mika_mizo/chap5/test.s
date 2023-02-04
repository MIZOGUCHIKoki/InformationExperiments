	.include	"common.s"
	.section	.init
	.global		_start
_start:
	mov	sp,	#STACK
	ldr	r0,	=TIMER_BASE
	ldr	r1,	[r0, #GPFSEL1]
	ldr	r9,	=time
	str	r1,	[r9]
	ldr	r8,	=100000
	add	r1,	r1,	r8
	str	r1,	[r9, #4]
	ldr	r8,	[r0, #GPFSEL1]
	ldr	r5,	[r0, #GPFSEL1]
	ldr	r2,	=10000
	ldr	r4,	=700000
	add	r8,	r8,	r2
	add	r9, 	r1,	r4
	mov	r6,	#0

loop00:
	ldr	r3,	[r0, #GPFSEL1]

	cmp	r8,	r3
	addcc	r8,	r8,	r2
	bcc	jumpsound
	
	cmp	r5,	r3
	addcc	r5,	r5,	r4
	bcc	jumpon
	
	cmp	r9,	r3
	addcc	r9,	r9,	r4
	bcc	jumpoff

	b	loop00

jumpsound:
	bl	sound
	b	loop00
jumpon:
	bl	led_on
	b	loop00
jumpoff:
	bl	led_off
	b	loop00
