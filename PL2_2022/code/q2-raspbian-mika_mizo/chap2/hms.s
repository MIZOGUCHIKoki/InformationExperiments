  .section .text
  .global  _start

_start:
  ldr r1, =12356
  ldr r2, =3600
  mov r3, #60 
  
  @; A div B = Q mod R <=> R = A - BQ
  udiv  r4, r1, r2  @; r4 = r1 / r2 mod r6 <=> r6 = r1 - r2 * r4
  mul r5, r4, r2  @; r5 = r4 * r2
  sub r6, r1, r5  @; r6 = r1 - (r4 * r2)  ; r4[hour]

  udiv  r5, r6, r3  @; r5 = r6 / r3 = r5 mod r8
  mul r7, r5, r3
  sub r8, r6, r7    @; r5[minute], r8[second]

  mov r2, #10
  mov r3, #5

  mul r1, r4, r2
  mul r2, r5, r3

  add r3, r1, r2
  add r1, r3, r8

  mov r7, #1
  mov r0, r1
  swi #0
  
