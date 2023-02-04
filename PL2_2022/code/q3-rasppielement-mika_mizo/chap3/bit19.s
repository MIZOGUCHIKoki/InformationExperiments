	.include	"common.s"
	.section .init
	.global _start

@ Free regitser: r2
@ Reserved register: r0, r1, r3, r4
@ GPFSEL0 = 0x00, GPFSEL1 = 0x04, GPFSEL2 = 0x08

_start:
	ldr	r0,	=GPIO_BASE
	ldr	r1,	=TIMER_BASE

	@ difine output port
	ldr	r2, =GPFSEL_VEC1_LED
	str	r2,	[r0, #GPFSEL1]

	mov	r4,	#(1 << LED_PORT)

loop:
	ldr		r3,	[r1, #GPFSEL1]
	tst		r3,	#(1 << 19)
	strne	r4,	[r0, #GPSET0]
	streq	r4,	[r0, #GPCLR0]
	b 	loop
