  .section  .text
  .global   _start
  .equ  N,  37
_start:
  mov r4, #N
  mov r5, #0  @;n0
  mov r1, #1  @;n1
  mov r2, #1  @;n2
  sub r4, r4, #2

loop:
  add r0, r1, r2
  add r0, r0, r5
  bl  print_r0
  mov r5, r1
  mov r1, r2
  mov r2, r0
  subs  r4, r4, #1
  bne   loop

endp:
  mov r7, #1
  mov r0, #0
  swi #0 
