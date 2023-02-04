	section .text
	global _start
	extern print_eax

N:	equ 10

_start:
	mov ebx, N
	mov esi, 0
	mov ecx, 1

loop0:
	mov edx, 0
	mov eax, ecx
	cmp ecx, ebx
	jg end
	mul ecx
	inc ecx
	add eax, esi
	mov esi, eax
	call print_eax
	jmp loop0

	

end:
	mov eax, 1
	int 0x80
	
	
