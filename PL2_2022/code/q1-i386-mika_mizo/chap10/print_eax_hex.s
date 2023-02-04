	section .text
	global print_eax_hex

print_eax_hex:
	push edi
	push esi
	push edx
	push ecx
	push ebx
	push eax

	mov ecx, buf + 8
	mov edi, 8
	mov ebx, edi
	mov esi, eax
	
loop0:
	dec ecx
	and eax, 0xf
	cmp eax, 10
	jb inc0
	sub eax, 10
	add al, 'a'
	mov [ecx], al
	jmp endif

inc0:
	add al, '0'
	mov [ecx], al
	jmp endif

endif:
	shr esi, 4
	mov eax, esi
	dec edi
	jnz loop0


	inc ebx
	mov edx, ebx
	mov eax, 4
	mov ebx, 1
	int 0x80

	pop eax
	pop ebx
	pop ecx
	pop edx
	pop esi
	pop edi
	ret

	section .data
buf:	times 8 db 0
	db 0x0a
	
	
