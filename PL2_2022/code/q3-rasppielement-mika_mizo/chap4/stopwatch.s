@------------------------------------
@ subRutine : display, writeProcess, read_switch
@ target time : r7,	r4(LED_On), r3(LED_Off)
@ flag : r5
@------------------------------------
	.equ			count,	100000		@ 0.1sec
	.equ			led,		500000    @ 0.5sec
  .equ      sec,    1000000   @ 1sec
	.include	"common.s"
	.section 	.init
	.global 	_start, nb_all
_start:
	ldr r0, =GPIO_BASE
	ldr r9,	=TIMER_BASE
  mov r5, #0      @ flag

	ldr	r1, =GPFSEL_VEC0
	str	r1, [r0, #GPFSEL0 + 0]
	ldr	r1, =GPFSEL_VEC1
	str	r1, [r0, #GPFSEL0 + 4]
	ldr	r1, =GPFSEL_VEC2
	str	r1, [r0, #GPFSEL0 + 8]
@ initalize stack pointer and display
	mov	sp,		#STACK
  bl  clear
@ initialize target time
	ldr		r7,		[r9, #GPFSEL1]
	ldr		r1,		=led
	add		r4,		r1,	r7  @ r4 :: LED_ON
  mov 	r3,   #0      @ on -> 0, off -> 1
	ldr		r1,		=count
	add		r7,		r1,	r7  @ r7 :: count
	ldr		r1,		=disp
	add		r1,		r1,	r7
	push	{r1}
@ setting loop variable
	mov		r11,	#0
	mov		r12,	#0
	mov		r10,	#0
loop:
@ Task: [ Find out if a button is pressed ]
  bl    read_switch @ Overwriten register {r1}
  cmp   r1,   #2    @ pressed stop button
  moveq r5,   #1
  cmp   r1,   #1
  moveq r5,   #0
  
@ Task: [ Struct strings ]
structStrings:
	ldr		r6,		[r9, #GPFSEL1]	@ r6 current
	cmp		r6,		r7			@	Current, Target
	bcc 	LED_Flashing	@ Currnet < Target
	ldr		r1,		=count	
	add		r7,	r1,	r7	  @ update target time
  bl    writeProcess  @ Pushed register {r0 - r4, r6, r8}

@ Task: [ LED flashing ]
LED_Flashing:
  ldr   r8,   =led
  ldr   r0,   =GPIO_BASE
  mov   r1,   #(1 << LED_PORT)
  ldr   r6,   [r9, #GPFSEL1]  @ load current time
  cmp   r3,   #1  @ (if LED is off)
  beq   off
  on:
    cmp   r6,   r4
    strcc r1,   [r0, #GPSET0] @ ON
    addcs r4,   r6, r8
    movcs r3,   #1
    b     disp
  off:
    cmp   r6,   r4
    strcc r1,   [r0, #GPCLR0] @ OFF
    addcs r4,   r6, r8
    movcs r3,   #0
disp:
	pop		{r1}
	ldr		r6,		[r9, #GPFSEL1]	@ r6 current
	cmp		r6,		r1			@	Current, Target
	bcc		endp					@ Currnet < Target
	mov		r0,		#disp
	add		r1,		r0,	r6	@ update target time
	add		r10,	r10,	#1
	cmp		r10,	#8
	moveq	r10,	#0
endp:
	push	{r4}
	mov		r4,	r10
	bl		display_row
	pop		{r4}
	push	{r1}
	b	    loop
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
