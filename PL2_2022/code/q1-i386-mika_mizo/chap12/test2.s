 section .text
  global  _start
	extern  average
	extern print_eax_frac

_start:
	mov ebx, data1
	mov ecx, ndata
	call average
	call print_eax_frac
  mov eax,  1
  mov ebx,  0
  int 0x80

  section .data
data1:  dd  1, 2, 3, 4
ndata:  equ ($ - data1) / 4
