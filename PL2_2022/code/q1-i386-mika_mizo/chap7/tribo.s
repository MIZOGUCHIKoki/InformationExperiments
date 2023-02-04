  section .text
  global  _start
  extern  print_eax

N: equ 7

_start:
  mov ebx,  0 ; n-3
  mov ecx,  1 ; n-2
  mov edx,  1 ; n-1
  mov eax,  0 ; Tn
  mov edi,  N ; n
  sub edi,  2

loop:
  cmp edi,  0
  je  endp
  dec edi


  mov eax,  0

  add eax,  ebx
  add eax,  ecx
  add eax,  edx

  mov ebx,  ecx
  mov ecx,  edx
  mov edx,  eax

  call  print_eax
  jmp loop

endp:
  mov ebx,  eax
  mov eax,  1
  int 0x80
