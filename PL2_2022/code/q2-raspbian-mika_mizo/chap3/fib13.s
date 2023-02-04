  .section  .text
  .global   _start

_start:
  mov r1, #1  @; n-1
  mov r3, #12 @; n
calc:
  subs  r3, r3, #1
  add r0, r1, r2
  mov r2, r1
  mov r1, r0
  bne calc
  @; EXET system call
endp:
  mov r7, #1
  swi #0
