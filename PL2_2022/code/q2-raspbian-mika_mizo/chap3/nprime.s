  .equ  N,  2
  .section  .text
  .global   _start

_start:
  ldr r1, =N
  mov r0, #0
  cmp r1, #0

  cmp r1, #1
  bls endp

  mov r0, #1
  add r1, r1, #1
nprime:
  subs  r1, r1, #1
  cmp r1, #2
  beq endp
  mov r2, #2
sqrt:     @; sqrt(N) = r2
	mul r3, r2, r2
	cmp r1, r3
	addpl r2, r2, #1
	bpl sqrt
isprime:
	subs r2, r2, #1
	cmp r2, #1
	addeq r0, r0, #1  @; prime
	beq nprime
	udiv r4, r1, r2
	mul r5, r2, r4
	subs r6, r1, r5
	bne isprime
  b nprime

endp:
  mov r7, #1
  swi #0
