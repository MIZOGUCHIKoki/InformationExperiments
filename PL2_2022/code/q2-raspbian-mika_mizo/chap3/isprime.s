	.equ N, 0
	
	.section .text
	.global _start

	
_start:
	ldr r1, =N
	mov r2, #1
	mov r0, #1
	cmp r1, #2
	bcc end

loop0: 
	mul r3, r2, r2
	cmp r1, r3
	add r2, r2, #1
	bpl loop0
	
loop1:
	subs r2, r2, #1
	cmp r2, #2
	moveq r0, #0
	beq end
	udiv r4, r1, r2
	mul r5, r2, r4
	subs r6, r1, r5
	bne loop1

end:
	mov r7, #1
	swi #0
