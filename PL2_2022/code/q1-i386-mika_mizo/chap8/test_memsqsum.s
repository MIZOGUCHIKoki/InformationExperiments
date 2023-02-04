  section .text
  global  _start
  extern  memsqsum

_start:
  mov ebx,  123
  mov edx,  123
  mov edi,  123
  mov esi,  123

Tdata1:
	mov eax, 0
	mov ebx, data1
	mov ecx, ndata1
	call memsqsum
	cmp eax, data1a
  jne nif


Tdata2:
	mov eax, 0
	mov ebx, data2
	mov ecx, ndata2
	call memsqsum
	cmp eax, data2a
  jne nif

Tdata3:
	mov eax, 0
	mov ebx, data3
	mov ecx, ndata3
	call memsqsum
	cmp eax, data3a
  jne nif

Tdata4:
	mov eax, 0
	mov ebx, data4
	mov ecx, ndata4
	call memsqsum
	cmp eax, data4a
  jne nif


accuracyOfReg:
  mov eax,  0
  mov ebx,  data3
  mov ecx,  ndata3
  call memsqsum
  cmp eax,  data3a
  jne nif
  cmp ebx,  data3
  jne nif
  cmp ecx,  ndata3
  jne nif
  cmp edx,  123
  jne nif
  cmp edi,  123
  jne nif
  cmp esi,  123
  jne nif

numberOfElement0:
  mov eax,  100
  mov ebx,  data1
  mov ecx,  0
  call  memsqsum
  cmp eax,  0
  jne nif
  cmp ebx,  data1
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

  


  section .data
data1:  dd  1, 1, 2, 4, 8, 13
ndata1: equ ($ - data1) / 4
data1a: equ 255
data2:  dd  0, 0, 0
ndata2: equ ($ - data2) / 4
data2a: equ 0
data3:  dd  65535
ndata3: equ ($ - data3) / 4
data3a: equ 4294836225
data4:  dd  0
ndata4: equ 0
data4a: equ 0
