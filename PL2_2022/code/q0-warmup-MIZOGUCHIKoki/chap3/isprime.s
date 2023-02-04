  ;12379が素数であるかどうか
  section .text
  global  _start

_start:
  mov ebx, 12379    ; Test value
  mov ecx, 2        ; counter

loop0:
  mov eax, 0
  mov edx, 0
  
  ;; 2 is prime number
  cmp ebx, 2        ; Text value ? 2
  je  return0       ; return0 (2 is prime number)

  mov eax, ebx      ; eax = 12379
  div ecx           ; edx eax % ecx = edx

  cmp edx, 0        ; edx ? 0
  je  return1       ; edx = 0 -> endp

  inc ecx           ; counter++
  cmp ecx, ebx      ; ecx ? ebx
  jge return0       ; counter >= Test value -> endp

  jmp loop0

return0:
  mov ebx, 0        ;return 0
  jmp endp

return1:
  mov ebx, 1        ;return 1
  jmp endp
  
endp:
  mov eax, 1
  int 0x80
