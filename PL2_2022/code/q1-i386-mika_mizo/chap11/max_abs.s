  section .text
  global  max_abs
max_abs:
  push  esi
  push  edi
  push  edx
  push  ecx
  push  ebx


  mov eax,    0       ; 最大値
  mov edi,    ebx
loop0:
  cmp ecx,    0       ; esi ? 0
  je  endp            ; esi == 0 -> endp
  dec ecx

  mov esi,  [ebx]
  cmp esi,  0
  jge  then
  mov edx,  0x00000000
  sub edx,  esi
  mov esi,  edx       ; not esi , inc esi

then:
  cmp eax,    esi  ; ebx ? esi
  jl maxx            ; ebx >= [data1]
  add ebx,    4
  jmp loop0
  maxx:
    mov eax,    esi
    mov edi,    ebx
    add ebx,    4
    jmp loop0

endp:
  mov eax,  [edi]
  pop ebx
  pop ecx
  pop edx
  pop edi
  pop esi
  ret
