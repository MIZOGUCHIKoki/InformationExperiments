  section .text
  global  qsort
  extern  qsort

qsort:
  push  esi
  push  edi
  push  edx
  push  eax
  push  ecx
  push  ebx

  mov   eax,  var ; def var
  mov   esi, :esi ; right
  mov   edi,  edi ; left
  cmp   esi,  edi
  jge   endp      ; left >= right

  mov   [var],  esi ; r = right
  mov   [var+4],  edi ; l = left


endp:
  pop ebx
  pop ecx
  pop eax
  pop edx
  pop edi
  pop esi
  ret 

  section .data
var:  dd  0, 0, 0, 0
; r, l, p, tmp
