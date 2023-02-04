  section .text
  global  _start
  extern  sort3, print_eax

_start:
  mov ebx,  data
  mov ecx,  ndata
  call  sort3      ; ソート
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
data:  dd  8, 9, 1, 2, 3, 4, 5
ndata  equ ($ - data) / 4
