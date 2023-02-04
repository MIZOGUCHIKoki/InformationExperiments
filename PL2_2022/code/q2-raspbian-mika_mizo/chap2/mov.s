	.section .text
	.global _start
_start:
	mov r7, #1
	mov r0, #123
	swi #0
