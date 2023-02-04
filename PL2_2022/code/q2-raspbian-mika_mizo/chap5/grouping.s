	.section .text
	.global grouping

grouping:
	

call:
	str r14, [sp, #-4]!
	str r1, [sp, #-4]!
	str r2, [sp, #-4]!
	str r3, [sp, #-4]!
	str r4, [sp, #-4]!
	str r6, [sp, #-4]!

	
	cmp r2, #1
	moveq r0, #1
	beq end
	cmp r1, r2
	movcc r0, #0
	bcc end

	sub r1, r1, #1
	sub r2, r2, #1
	bl call          @S(n-1, g-1)
	mov r3, r0


	add r2, r2, #1
	bl call          @S(n-1, g)

	mul r6, r2, r0
	add r0, r6, r3

	
end:
	ldr r6, [sp], #4
	ldr r4, [sp], #4
	ldr r3, [sp], #4
	ldr r2, [sp], #4
	ldr r1, [sp], #4
	ldr r14, [sp], #4
	bx r14




