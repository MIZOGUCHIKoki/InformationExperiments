  .equ  N,  3128
  .section  .text
  .global   _start

_start:
  ldr r10,=N  @; $BF~NO?tCM(B
  mov r9, #10 @; $B3d$k?t(B
  mov r2, #1  @; $B7e?t(B
  mov r6, r10
countK: @; $B7e?t(BCounter
  udiv  r3, r10,  r9    @;  1932 / 10 = 193
  movs r10, r3
  addne r2, r2, #1      @;  $B7e?t(B++
  bne   countK
@; r2  :: $B7e?t(B
@; r6 :: $BF~NO?tCM(B
writeProcess:
  ldr   r1,   =buf+99  @; r1 = buf + ndigit - 1 $BKvHxHVCO(B(Return)
wloop:
  udiv  r4, r6,  r9  @; N / 10 = r4
  @; A divid by B = R mod Q <=> A - BR = Q
  mul   r5, r9,   r4  @; BR
  sub   r5, r6,  r5  @; r5 = N % 10
  add   r5, r5,   #'0'
  strb  r5, [r1], #-1      @;  [r1] <- r5 (0$B3HD%(B); r2--
  movs  r6,r4
  bne   wloop
  
write:
  add r1, r1, #1  @; $B@hF,HVCO(B
  add r2, r2, #1  @; $B7e?t(B
  mov r7, #4
  mov r0, #1
  swi #0
endp:
  mov r7, #1
  mov r0, #0
  swi #0

  .section  .data
buf:  .space 100  @;  100Byte
      .ascii "\n"    @;  Return Code
