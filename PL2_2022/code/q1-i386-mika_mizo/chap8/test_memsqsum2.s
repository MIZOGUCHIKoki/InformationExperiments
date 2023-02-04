	section .text
	global _start
	extern memsqsum


_start:
  mov edx,  123
  mov edi,  345
  mov esi,  567

over32bit:
	mov eax, 0
	mov ebx, data1
	mov ecx, ndata1
	call memsqsum
	cmp eax, data1a
  jne nif



zerodata:
	mov eax, 0
	mov ebx, data2
	mov ecx, ndata2
	call memsqsum
	cmp eax, data2a
  jne nif

accuracyOfCaculation:
	mov eax, 0
	mov ebx, data3
	mov ecx, ndata3
	call memsqsum
	cmp eax, data3a
  jne nif

numberOfElemets:
	mov eax, 0
	mov ebx, data4
	mov ecx, ndata4
	call memsqsum
	cmp eax, data4a
  jne nif

zeroData:
	mov eax, 0
	mov ebx, data5
	mov ecx, ndata5
	call memsqsum
	cmp eax, data5a
  jne nif

accuracyOfReg:
  mov eax,  0
  mov ebx,  data3
  mov ecx,  ndata3
  call memsqsum
  call memsqsum
  cmp eax,  data3a
  jne nif
  cmp ebx,  data3
  jne nif
  cmp ecx,  ndata3
  jne nif
  cmp edx,  123
  jne nif
  cmp edi,  345
  jne nif
  cmp esi,  567
  jne nif

numberOfElement0:
  mov eax,  0
  mov ebx,  data2
  mov ecx,  0
  call  memsqsum
  cmp eax,  0
  jne nif

stack:
  mov eax,  0
  mov ebx,  data2
  mov ecx,  ndata2
  mov edx,  reg
  mov [edx],  esp
  call memsqsum
  cmp eax,  data2a
  jne nif
  cmp edx,  esp
  jne nif


if:	
  mov ebx, 0
	jmp end

nif:
  mov ebx,  1
  jmp end
	
end:	
	mov eax, 1
	int 0x80




data1:	dd 65535
ndata1:	equ ($ - data1) / 4
data1a: equ 4294836225
data2:	dd 0
ndata2:	equ ($ - data2) / 4
data2a: equ 0
data3:	dd 1, 1, 2, 4, 8 ,13
ndata3:	equ ($ - data3) / 4
data3a: equ 255
data4:  times 255 dd 1
ndata4:	equ ($ - data4) / 4
data4a: equ 255
data5:	dd 0, 0, 0
ndata5:	equ ($ - data5) / 4
data5a: equ 0
reg:  dd  0, 0
