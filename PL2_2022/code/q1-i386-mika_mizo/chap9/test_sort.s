  section .text
  global  _start
  extern  sort, print_eax

_start:
  mov ebx,  data
  mov ecx,  ndata
  call  sort      ; ソート
  mov edi,  0      
loop:
  cmp edi,  ndata
  je  endp
  mov eax,  [data + edi * 4]
  call print_eax
  inc edi
  jmp loop


endp:
  mov eax,  1
  mov ebx,  0
  int 0x80

  section .data
data:  dd 1, 3, 5, 7, 9, 2, 4, 6, 8, 0, 1, 2
ndata  equ ($ - data) / 4
