	.equ GPIO_BASE, 0x3f200000
	.equ GPFSEL0, 0x00
	.equ GPFSEL1, 0x04
	.equ GPFSEL2, 0x08
	.equ GPSET0, 0x1c
	.equ GPCLR0, 0x28

	.equ GPFSEL_VEC1, 0x00000001
	.equ LED_PORT, 10

	.section .init
	.global _start
_start:
	ldr r0, =GPIO_BASE

	ldr r1, =GPFSEL_VEC1
	str r1, [r0,#GPFSEL1]
	mov r3, #10


loop0:	
	mov r1, #(1 << LED_PORT)
	str r1, [r0, #GPSET0]
	mov r2, #0x1f0000

1:	subs r2, r2, #1
	bne 1b

	mov r1, #(1 << LED_PORT)
	str r1, [r0, #GPCLR0]
	mov r2, #0x1f0000

2:	subs r2, r2, #1
	bne 2b

	sub r3, r3, #1
	cmp r3, #0
	bne loop0

loop:	b loop
