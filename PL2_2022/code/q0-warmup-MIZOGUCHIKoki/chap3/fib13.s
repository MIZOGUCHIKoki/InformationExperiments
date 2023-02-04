  ;フィボナッチ数列（f13）まで求めよ．
  section .text
  global  _start

_start:
  mov ebx, 0    ; ebx = 0(fn-2)
  mov edi, 1    ; edi = 1(fn-1)

  mov ecx, 2    ; ecx = 0(n)

loop0:
  mov esi, 0    ; esi = 0(fn)
  add esi, ebx  ; ecx += ebx (fn = fn-1 + fn-2)
  add esi, edi  ; ecx += edi

  mov ebx, edi  ; ebx = edi (fn-2 = fn-1)
  mov edi, esi  ; edi = esi (fn-1 = fn)

  inc ecx       ; n++

  cmp ecx, 14   ; ecx ? 13
  jle loop0     ; ecx < 13 -> loop0

  mov eax, 1    ;
  int 0x80      ;
