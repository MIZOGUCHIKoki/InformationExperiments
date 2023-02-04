	.section .text
	.global _start
_start:
	mov r1, #123
	add r0, r1, #45   @r0 = r1 + 45
	sub r2, r0, #67   @r2 = r0 - 67
	add r0, r2, #8    @r0 = r2 + 8
	sub r2, r0, #9    @r2 = r0 - 9
	mov r0, r2

	mov r7, #1
	swi #0
	
