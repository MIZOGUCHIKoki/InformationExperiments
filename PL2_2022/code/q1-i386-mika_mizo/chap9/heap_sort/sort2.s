  section .text
  global  sort2
sort2:
	push esi
	push edi
	push edx
	push eax
	push ecx
	push ebx
	
push_heap:
	add [size], dword 1	        ;size++
	mov eax, [size]		          ;int k = size
	mov edi, [ebx + eax*4]	    ;data[size] = x
	mov esi, 2
	cmp ecx, 1		              ;データの数繰り返し
	je end
	dec ecx

while:
	cmp eax, 1		              ;k > 1
	jle push_heap
	mov edx, 0
	div esi			                ;k = k/2
	cmp edi, [ebx + eax*4]	    ;data[k] > data[k/2]
	jle push_heap
	mov edx, edi		            ;int i = data[l]
	mov edi, [ebx + eax*4]	    ;data[k] = data[k/2]
	mov [ebx + eax*4], edx	    ;data[k/2] = i
	jmp while
	
end:	
	pop ebx
	pop ecx
	pop eax
	pop edx
	pop edi
	pop esi
	ret

	section .data
size:	dd 0
