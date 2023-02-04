  section .text
  global  print_eax_frac
  ndigit  equ 34
  extern print_eax

print_eax_frac:
  push  eax
  push  ebx
  push  ecx
  push  edx
  push  edi
  push  esi

  mov   esi,  1 ; 桁数
  
  mov ebx,  eax
  shr ebx,  24
  cmp ebx,  128
  jl then
  not eax
  inc eax
  mov edx,  0
  push  edx
  push  eax
  jmp D_Part

  then:
    mov edx,  1
    push  edx
    push  eax

D_Part: ; 少数出力
  mov ecx,  buf
  add ecx,  8         ; 小数部アドレス先頭番地
  and eax,  0x00ffffff
  mov ebx,  eax

loopD:
  mov eax,  0
  shl ebx,  1
  add eax,  ebx
  shl ebx,  2
  add eax,  ebx    ;  eax * 10

  mov ebx,  eax
  and ebx,  0x00ffffff
  shr eax,  24
  inc ecx
  add al, '0'
  mov [ecx],  al
  inc esi
  cmp ebx,  0
  jne loopD

  inc ecx
  inc esi
  mov dl, 0x0a
  mov [ecx], dl

  mov dl, '.'
  mov [buf + 8], dl
  inc esi

Z_Part:
  mov ecx,  buf
  add ecx,  8     ; 開始番地指定
  pop eax
  shr eax,  24
  push  eax
  mov edi,  10
countK:
  mov edx,  0
  div edi
  cmp eax,  0
  je writeProcess
  inc esi
  jmp countK
writeProcess:
  pop eax
loop0:
  mov edx,  0
  dec ecx
  div edi
  add dl, '0'
  mov [ecx],  dl
  cmp eax,  0
  jne loop0

  pop edx
  cmp edx, 0
  jne  wp
  mov dl, '-'
  mov [ecx - 1], dl
  dec ecx
  inc esi

wp:
  mov eax,  4
  mov ebx,  1
  mov edx,  esi   ; 桁数　
  int 0x80

  pop esi
  pop edi
  pop edx
  pop ecx
  pop ebx
  pop eax
  ret
  section .data
buf:  times 34  db  0
