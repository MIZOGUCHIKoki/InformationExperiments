  .section  .text
  .global   _start

_start:
  mov r0, #10
  mov r1, #11
  mov r2, #12
  mov r3, #13
  mov r4, #14
  mov r5, #15
  mov r6, #16
  mov r7, #17
  mov r8, #18
  mov r9, #19
  mov r10, #110
  mov r11, #111
  mov r12, #112
  mov r14, #114

  ldr r0, =4294967295
  bl  print_r0
  bl  print_r0
  mov r0, r1
  bl  print_r0
  mov r0, r2
  bl  print_r0
  mov r0, r3
  bl  print_r0
  mov r0, r4
  bl  print_r0
  mov r0, r5
  bl  print_r0
  mov r0, r6
  bl  print_r0
  mov r0, r7
  bl  print_r0
  mov r0, r8
  bl  print_r0
  mov r0, r9
  bl  print_r0
  mov r0, r10
  bl  print_r0
  mov r0, r11
  bl  print_r0
  mov r0, r12
  bl  print_r0
  mov r0, r14
  bl  print_r0

  mov r7, #1
  mov r0, #0
  swi #0
