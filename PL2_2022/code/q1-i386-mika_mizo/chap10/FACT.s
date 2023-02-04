  section .text
  global  FACT
  extern  MULT
 
FACT:   ; 階乗F(ebx)
  push  ebx
  push  edx
  mov   eax,  1
  sub   ebx,  1
  jg   NEXT2
  jmp   FIN2
NEXT2:
  mov   edx,  1
LP2:
  inc   edx
  call  MULT
  dec   ebx
  jnz   LP2
FIN2:
  mov   esi,  eax
  mov   eax,  edx
  mov   eax,  esi
  pop   edx
  pop   ebx
  ret
