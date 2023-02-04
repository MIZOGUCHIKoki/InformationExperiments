  section .text
  global  memsqsum

memsqsum:
  push  ebx
  push  ecx
  push  edx
  push  edi
  push  esi

  mov   esi,  0
  mov   eax,  0
loop:
  cmp   ecx,  0
  je    endp

  mov   eax,  [ebx]   ; 
  mul   eax           ; eax * eax =edx eax
  mov   edx,  0
  add   esi,  eax
  add   ebx,  4

  dec   ecx
  jz    endp
  jmp   loop

endp:
  mov   eax,  esi
  pop   esi
  pop   edi
  pop   edx
  pop   ecx
  pop   ebx
  ret
