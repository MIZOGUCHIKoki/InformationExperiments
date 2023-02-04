	.equ N, -255
	

	.section .text
	.global _start
_start:
	mov r1, #N
	eor r3, r1, r1, asr #31
	sub r0, r3, r1, asr #31
	

  @; EXIT system call
	mov r7, #1
	swi #0
 
