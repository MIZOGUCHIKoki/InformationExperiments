	section .text
	global isprime

isprime:
	push ebp
	push esi
	push edi
	push ebx

	mov eax, [esp+20]
	mov ebx, eax
	mov ecx, 5000
	cmp eax, 2
	jl notprime
loop0:
	cmp ecx, 0
	je nextstep
	mov edx, 0
	mov edi, eax
	mul eax
	add eax, ebx
	shl edi, 1
	div edi
	dec ecx
	jmp loop0

nextstep:
	mov ecx, eax
	jmp loop1

loop1:
	mov eax, ebx
	cmp ecx, 1
	je prime
	mov edx, 0
	div ecx
	cmp edx, 0
	je notprime
	dec ecx
	jmp loop1

notprime:
	mov eax, 0
	jmp pop

prime:
	mov eax, 1
	jmp pop

pop:
	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
	
