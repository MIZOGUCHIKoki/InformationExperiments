	.section .text
	.global _start

_start:
	ldr r1, =N
	ldr r2, =ndata-1
	ldr r3, =data1

loop0:
	ldr r4, [r3, r2, lsl #2]
	eor r5, r4, r4, asr #31
	sub r6, r5, r4, asr #31  @r6 = abs
	cmp r1, r6
	addcs r0, r0, #1
	subs r2, r2, #1
	bpl loop0

	mov r7, #1
	swi #0
	
	


	.section .data
data1:	.word -1, -123, 54, 39, 32, -2147483647
.equ    ndata, 6
.equ    N, 2147483646
