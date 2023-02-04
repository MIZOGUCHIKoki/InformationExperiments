	section .text
	global average

average:
	push esi
	push edi
	push edx
	push ecx
	push ebx
	mov edi, ecx
	mov eax, 0

	
loop0:
	cmp ecx, 0
	je shift
	add eax, [ebx]
	add ebx, 4
	dec ecx
	jmp loop0

shift:
	mov edx, eax
	shl eax, 24
	sar edx, 8
	idiv edi

	pop ebx
	pop ecx
	pop edx
	pop edi
	pop esi
	ret
	
	
