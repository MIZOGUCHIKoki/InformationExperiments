	.equ	PWM_HZ,		9600*1000
	.equ	KEY_A4,		PWM_HZ/440
	.include	"common.s"
	.section	.init
	.global		_start
_start:
	@set GPIO
	ldr	r0,	=GPIO_BASE
	ldr	r1, 	=GPFSEL_VEC0
	str	r1,	[r0, #GPFSEL0 + 0]
	ldr	r1,	=GPFSEL_VEC1
	str	r1,	[r0, #GPFSEL0 + 4]
	ldr	r1, 	=GPFSEL_VEC2
	str	r1,	[r0, #GPFSEL0 + 8]

	@set CM
	bl	settings
	@set PWM
	ldr	r0,	=PWM_BASE
	ldr	r1,	=(1 << PWM_MSEN2 | 1 << PWM_PWEN2)
	str	r1,	[r0, #PWM_CTL]

	@ra
	ldr	r1,	=KEY_A4
	str	r1,	[r0, #PWM_RNG2]
	lsr	r1,	r1,	#1
	str	r1,	[r0, #PWM_DAT2]

loop:	b 	loop
