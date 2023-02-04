  section .text
  global  mul_10k

mul_10k:
  push  edi
  push  esi
  push  edx
  push  ecx
  push  ebx


mov ebx,  eax
mov ecx,  eax
mov edx,  eax
shl eax,  13
shl ecx,  10
add eax,  ecx

mov ecx,  ebx
shl ecx,  9
add eax,  ecx

mov ecx,  ebx
shl ecx,  8
add eax,  ecx

mov ecx,  ebx
shl ecx,  4
add eax,  ecx

endp:
  pop ebx
  pop ecx
  pop edx
  pop esi
  pop edi
  ret
