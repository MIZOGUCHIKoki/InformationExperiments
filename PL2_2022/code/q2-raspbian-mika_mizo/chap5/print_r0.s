  .section  .text
  .global   print_r0

print_r0:

operate_stack:
  str r7, [sp, #-4]!
  str r6, [sp, #-4]!
  str r4, [sp, #-4]!
  str r3, [sp, #-4]!
  str r2, [sp, #-4]!
  str r1, [sp, #-4]!
  str r0, [sp, #-4]!

  mov r7, #10 @; $B3d$k?t(B
  mov r2, #1  @; $B7e?t(B
  mov r6, r0
countK: @; $B7e?t(BCounter
  udiv  r3, r0,  r7    @;  1932 / 10 = 193
  movs  r0, r3
  addne r2, r2, #1      @;  $B7e?t(B++
  bne   countK
@; r2  :: $B7e?t(B
@; r6 :: $BF~NO?tCM(B
writeProcess:
  ldr   r1,   =buf+99      @; r1 = buf + ndigit - 1 $BKvHxHVCO(B(Return)
wloop:
  udiv  r4, r6,  r7        @; N / 10 = r4
  @; A divid by B = R mod Q <=> A - BR = Q
  mul   r3, r7,   r4       @; BR
  sub   r3, r6,  r3        @; r5 = N % 10
  add   r3, r3,   #'0'
  strb  r3, [r1], #-1      @;  [r1] <- r5 (0$B3HD%(B); r2--
  movs  r6, r4
  bne   wloop
  
write:
  add r1, r1, #1  @; $B@hF,HVCO(B
  add r2, r2, #1  @; $B7e?t(B
  mov r7, #4
  mov r0, #1
  swi #0

endp:
  ldr r0, [sp], #4
  ldr r1, [sp], #4
  ldr r2, [sp], #4
  ldr r3, [sp], #4
  ldr r4, [sp], #4
  ldr r6, [sp], #4
  ldr r7, [sp], #4
  bx  r14         @;  back to test.s

  .section  .data
buf:  .space 100     @;  100Byte
      .ascii "\n"    @;  Return Code
