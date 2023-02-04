  .section  .text
  .global   _start

_start:
  ldr r1, =data1
  ldr r2, =ndata
loop:
	ldr   r3,   [r1], #4
	cmp   r3,   r0
	movhi r0,   r3
	subs  r2,   r2,   #1
	bne loop
	
	mov r7,      #1
	swi #0

	.section  .data
data1:  .word 10,2,1,20
	.equ  ndata,  4
