@README---
@ Find out if a switch is pressed.
@ Return register is { r1 }
@ If switch 1 is pressed, then r1 value is "0001".
@ If switch 1 and 2 are pressed, then r1 value is "0011".
@---------
  .include  "common.s"
  .section  .text
  .global   read_switch

read_switch:
  @ test switch 1
  push  {r0, r2, r3}
  mov   r1, #0
  ldr   r0, =GPIO_BASE
  ldr   r3, [r0,  #0x0034]
  mov   r0, #1
  and   r2, r3, r0, lsl #SW_1
  cmp   r2, #0
  movne r1, #1


  @ test switch 2
  and   r2, r3, r0, lsl #SW_2
  cmp   r2, #0
  orrne r1, r1, r0, lsl #1

  @ test switch 3
  and   r2, r3, r0, lsl #SW_3
  cmp   r2, #0
  orrne r1, r1, r0, lsl #2
  
  @ test switch 4
  and   r2, r3, r0, lsl #SW_4
  cmp   r2, #0
  orrne r1, r1, r0, lsl #3
  
  pop   {r0, r2, r3}
  bx    r14
