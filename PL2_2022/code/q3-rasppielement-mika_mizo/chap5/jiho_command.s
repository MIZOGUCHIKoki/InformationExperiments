@ Current displayed number {r11}
	.equ			PWM_HZ,		9600*1000
	.equ			KEY_A4,		PWM_HZ/440
	.equ			KEY_A5,		PWM_HZ/880
	.include	"common.s"
	.section	.text
	.global		jiho_sound

jiho_sound:
	push	{r0 - r1, r14}
	cmp		r10,	#7
	beq		beap_0
	cmp		r10,	#8
	beq		beap_0
	cmp		r10,	#9
	beq		beap_0
	cmp		r10,	#0
	beq		beap_1
	b			endp
beap_0:
	ldr		r0,	=TIMER_BASE
	ldr		r1,	[r0, #GPFSEL1]
	cmp		r1,	r12			@ Current, Target
	bcs		off					@ Current >= Target
	on:
		ldr		r0,	=PWM_BASE
		ldr		r1,	=KEY_A4
		str		r1,	[r0, #PWM_RNG2]
		lsr		r1,	r1,	#1
		str		r1,	[r0, #PWM_DAT2]
		b			endp
	off:
		ldr		r0,	=PWM_BASE
		mov		r1,	#0
		str		r1,	[r0, #PWM_DAT2]
		b			endp
		
beap_1:
	ldr		r0,	=TIMER_BASE
	ldr		r1,	[r0, #GPFSEL1]
	cmp		r1,	r3
	bcs		off_1
	on_1:
		ldr		r0,	=PWM_BASE
		ldr		r1,	=KEY_A5
		str		r1,	[r0, #PWM_RNG2]
		lsr		r1,	r1,	#1
		str		r1,	[r0, #PWM_DAT2]
		b			endp
	off_1:
		ldr		r0,	=PWM_BASE
		mov		r1,	#0
		str		r1,	[r0, #PWM_DAT2]
		b			endp
endp:
	pop		{r0 - r1, r14}
	bx		r14
