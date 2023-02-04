	@.equ	PWM_HZ,	9600*1000
	@.equ	KEY_A4, PWM_HZ / 440
	@.equ	KEY_H4,	PWM_HZ / 494
	@.equ	KEY_C4,	PWM_HZ / 523
	@.equ	KEY_D4,	PWM_HZ / 587
	@.equ	KEY_E4,	PWM_HZ / 659
	@.equ	KEY_F4,	PWM_HZ / 698
	@.equ	KEY_G4,	PWM_HZ / 784
	@.equ	KEY_A5,	PWM_HZ / 880

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
	ldr     r0, =CM_BASE
	ldr     r1, =0x5a000021                     @  src = osc, enable=false
	str     r1, [r0, #CM_PWMCTL]

1:    @ wait for busy bit to be cleared
	ldr     r1, [r0, #CM_PWMCTL]
	tst     r1, #0x80
	bne     1b

	ldr     r1, =(0x5a000000 | (2 << 12))  @ div = 2.0
	str     r1, [r0, #CM_PWMDIV]
	ldr     r1, =0x5a000211                   @ src = osc, enable=true
	str     r1, [r0, #CM_PWMCTL]

	@set PWM
	ldr	r0,	=PWM_BASE
	ldr	r1,	=(1 << PWM_PWEN2 | 1 << PWM_MSEN2)
	str	r1,	[r0, #PWM_CTL]

	ldr	r2,	=GtoG
	mov	r3, 	#0

on:
	ldr	r4,	[r2, r3, lsl #2]
	str	r4,	[r0, #PWM_RNG2]
	lsr	r4,	r4,	#1
	str	r4,	[r0, #PWM_DAT2]
	ldr	r5,	=0xfffff
1:
	subs	r5,	r5,	#1
	bne	1b

	add	r3,	r3,	#1
	cmp	r3, 	#9
	bne 	on

	mov	r6,	#0
	ldr	r6,	[r0, #PWM_CTL]

loop:	b	loop
	

	.section	.data
GtoG:
	.word 21818, 19433, 18355, 16354, 14567, 13753, 12244, 10909
	
