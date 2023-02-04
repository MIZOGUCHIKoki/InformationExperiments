	section .text
	global mul_edx

mul_edx:
	push esi
	push edi
	push edx
	push ecx
	push ebx

	mov ebx, 1
	mov edi, 0
	mov esi, 32

loop0:
	test edx, ebx		;かける数のebxビットを見る
	jnz pressed
	jmp shift

pressed:
	add edi, eax
	jmp shift

shift:
	shl eax, 1
	shl ebx, 1
	dec esi
	cmp esi, 0
	jne loop0

	mov eax, edi

	pop ebx
	pop ecx
	pop edx
	pop edi
	pop esi
	ret
	
	
