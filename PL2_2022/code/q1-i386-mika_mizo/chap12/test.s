  section .text
  global  _start
  extern  cos, print_eax_frac

_start:
  mov eax, 0x03000000
  call cos
  call print_eax_frac
  mov eax,  1
  mov ebx,  0
  int 0x80
