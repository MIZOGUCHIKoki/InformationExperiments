@------------------------------------
@------------------------------------
	.equ			count,	1000000		@ 1sec
	.equ			dpr,		1000      @ 0.0001sec
	.equ			sound5,	750000		@ 0.5sec
	.equ			sound1,	100000		@ 0.1sec
	.include	"common.s"
	.section 	.init
	.global 	_start
_start:
	mov		sp,		#STACK					@ initalize stack pointer
	bl		settings
	ldr		r1,		=frame_buffer
	push	{r1}
	ldr 	r9,		=TIMER_BASE
@ initialize target time
	ldr		r7,		[r9, #GPFSEL1]
	mov		r0,		#dpr
	add		r1,		r0,	r7	
	ldr		r0,		=count
	add		r7,		r0,	r7
@ setting loop variable
	mov		r11,	#0
	mov		r4,		#0
	mov		r5,		#0
loop:
@ Task: [ Struct strings ]
writeFrame_buffer:
	ldr		r6,		[r9, #GPFSEL1]	@ r6 current
	cmp		r6,		r7			@	Current, Target
	bcc		disp					@ Currnet < Target
	ldr		r0,		=count	
	add		r7,		r0,	r7	@ update target time
	ldr		r0,		=sound1
	add		r12,	r6,	r0	@ update sound target time
	ldr		r0,		=sound5
	add		r3,		r6,	r0
	@ Write Process
	mov		r2,		#7
	ldr		r0,		=nb_all
	ldr		r9,		[r0,	r11,	lsl	#2]					
	ldr		r8,		=nb_0
	multi:
		ldrb	r6,		[r8,	r2]
		lsl		r6,		#4
		ldrb	r0,		[r9,	r2]			
		pop		{r1}
		push	{r7}
		orr		r7,		r0,		r6
		strb	r7,		[r1,	r2]			@ store
		pop		{r7}
		push	{r1}
		subs	r2,		r2,		#1
		bpl		multi								@ 0以上
	mov		r10,	r11
	add		r11,	r11,	#1	
	add		r5,		r5,		#1
	cmp		r11,	#10
	moveq	r11,	#0
@ Task: [ display ]
disp:
	ldr		r9,		=TIMER_BASE
	ldr		r6,		[r9, #GPFSEL1]	@ r6 current
	cmp		r6,		r1			@	Current, Target
	bcc		sound					@ Currnet < Target
	mov		r0,		#dpr	
	add		r1,		r0,	r6	@ update target time
	add		r4,		r4,	#1
	cmp		r4,		#8
	moveq	r4,		#0

sound:
	cmp		r5,		#1
	beq		endp
	bl		jiho_sound
endp:
	bl	display_row
	b		loop
@	----- data base -----
nb_0:
	.byte	0x0,	0xe,	0xa,	0xa,	0xa,	0xe,	0x0,	0x0
nb_1:
	.byte	0x0,	0x4,	0xc,	0x4,	0x4,	0xe,	0x0,	0x0
nb_2:
	.byte	0x0,	0xe,	0x2,	0xe,	0x8,	0xe,	0x0,	0x0
nb_3:
	.byte	0x0,	0xe,	0x2,	0xe,	0x2,	0xe,	0x0,	0x0
nb_4:
	.byte	0x0,	0xa,	0xa,	0xe,	0x2,	0x2,	0x0,	0x0
nb_5:
	.byte	0x0,	0xe,	0x8,	0xe,	0x2,	0xe,	0x0,	0x0
nb_6:
	.byte	0x0,	0xe,	0x8,	0xe,	0xa,	0xe,	0x0,	0x0
nb_7:
	.byte	0x0,	0xe,	0xa,	0x2,	0x2,	0x2,	0x0,	0x0
nb_8:
	.byte	0x0,	0xe,	0xa,	0xe,	0xa,	0xe,	0x0,	0x0
nb_9:
	.byte	0x0,	0xe,	0xa,	0xe,	0x2,	0xe,	0x0,	0x0
nb_all:	
	.word	nb_0,	nb_1,	nb_2,	nb_3,	nb_4,	nb_5,	nb_6,	nb_7, nb_8,	nb_9
	@	4byte		nb_all + 0 = nb_0,	nb_all + 4 = nb_1
	@	nb_all + [byte] = ??

	.section	.data
	.global		frame_buffer
frame_buffer:
	.byte 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,0x0, 0x0
