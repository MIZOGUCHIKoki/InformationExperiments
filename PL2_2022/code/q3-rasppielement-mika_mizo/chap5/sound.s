	.include	"common.s"
	.section	.text
	.global		sound
sound:
	push	{r0-r12, r14}
	
	bl	settings

	ldr	r0,	=TIMER_BASE
	
	ldr	r2,	=soundData
	ldr	r3,	=sound_longData
	ldr	r4,	=sound2
	ldr	r5,	=sound_long

	ldr	r7,	=count
	ldrb	r6, 	[r7]

	ldr	r12,	=PWM_BASE

ON:
	ldrb	r7,	[r4, r6]
	ldrb	r8,	[r5, r6]		
	ldr	r9,	[r2, r7, lsl #2]	@sound
	ldr	r10,	[r3, r8, lsl #2]	@sound_long

	cmp	r9, 	#0
	streq	r9,	[r12, #PWM_DAT2]

	strne	r9,	[r12, #PWM_RNG2]
	lsrne	r9,	r9, 	#1
	strne	r9,	[r12, #PWM_DAT2]

	ldr	r7,	=time
	ldr	r1,	[r7]
	ldr	r11,	[r0, #GPFSEL1]
	
	cmp	r1,	r11
	addcc	r1,	r1,	r10
	strcc	r1,	[r7]
	ldrcc	r1,	[r7, #4]
	movcc	r8,	#0
	strcc	r8,	[r12, #PWM_DAT2]

	cmp	r1,	r11
	addcc	r6,	r6,	#1
	addcc	r1,	r1,	r10
	strcc	r1,	[r7, #4]
	cmp	r6,	#31
	moveq	r6,	#0
	ldr	r7,	=count
	strb	r6,	[r7]

	pop	{r0-r12, r14}
	bx	r14
	
	


	.section	.data
	.global		soundData, sound_longData, time, sound2, sound_long, count
soundData:
	.word	18355, 16354, 14567, 13753, 12244, 10909, 9726, 9177, 0

sound_longData:
	.word	700000, 230000, 120000, 350000

time:
	.word 	0x00, 0x00

sound2:
	.byte	2,2,2,1,1,1, 0,1,2,3,2,1, 2,3,4,5,7,5, 4,3,2,1,1,1, 2,2,2,2,0,2, 1
sound_long:
	.byte	3,2,1,1,1,1, 1,1,1,1,1,1, 1,1,1,1,1,1, 1,1,1,3,2,1, 3,2,1,1,1,1, 0

count:
	.byte	0
	
