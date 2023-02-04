  section .text
  global  _start
_start:
  mov edi,    ndata   ; データの個数
  mov esi,    data1   ; データ
  mov ebx,    0       ; 最大値

loop0:
  cmp edi,    0       ; esi ? 0
  je  endp            ; esi == 0 -> endp
  dec edi

  cmp ebx,    [esi]   ; ebx ? esi
  jl maxx            ; ebx >= [data1]
  add esi,    4
  jmp loop0

maxx:
  mov ebx,    [esi]   ;
  add esi,    4
  jmp loop0

endp:
  mov eax,    1
  int 0x80

data1: dd  3, 1, 4, 1, 5, 9, 2
ndata: equ ($ - data1) / 4

