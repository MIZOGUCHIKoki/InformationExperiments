  section .text
  global  MULT
 
 MULT:
  push  ebx
  push  edx
  mov   ebx,  eax
  mov   eax,  0

LP1:
  test  edx,  1
  jz   CONT1
  add   eax,  ebx
CONT1:
  shl   ebx,  1
  shr   edx,  1
  jnz   LP1
FIN1:
  pop   edx
  pop   ebx
  ret
