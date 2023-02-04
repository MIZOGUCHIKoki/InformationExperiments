	section .text
	global fib

fib:
	push esi
	push edi
	push edx
	push ecx
	push ebx

	mov edi, eax
	cmp eax, 0
	jl not
	jmp set

not:
	not eax
	add eax, 1		;絶対値
	jmp set

set:
	shr eax, 1
	mov ebx, 0
	mov ecx, 1

loop0:
	cmp eax, 0
	jle mov0
	ADD EBX, ECX
	ADD ECX, EBX
	dec eax
	jmp loop0

mov0:	
	test edi, 1
	jnz mov
	mov eax, ebx
	jmp cmp
mov:
	mov eax, ecx
	jmp cmp

cmp:	
	cmp edi, 0		
	jl minus		;ediが負である
	jmp endif

minus:
	test edi, 1		
	jnz endif           
	not eax
	add eax, 1
	jmp endif

endif:
	pop ebx
	pop ecx
	pop edx
	pop edi
	pop esi
	ret
