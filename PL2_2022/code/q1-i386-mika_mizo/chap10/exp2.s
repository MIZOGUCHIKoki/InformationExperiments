  section .text
  global  _start
  extern  print_eax
  extern  FACT

_start:
  mov ebx,  data2
  call  FACT
  call  print_eax


mov eax,  1
int 0x80

  section .data
data: equ 100
data2: equ 4
