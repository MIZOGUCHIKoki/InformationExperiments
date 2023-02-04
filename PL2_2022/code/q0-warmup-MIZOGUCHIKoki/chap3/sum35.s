  ;1以上30以下の3または5の倍数の総和を計算して出力する
  section .text
  global  _start

_start:
  mov ebx, 0    ; sum = 0
  mov ecx, 0    ; i = 0
  mov esi, 3    ; esi = 3
  mov edi, 5    ; edi = 5

loop0:
  inc ecx       ; i++
  mov eax, 0    ;
  mov edx, 0    ;

  cmp ecx, 31   ; ecx ? 31
  jge endif     ; ecx >= 31 -> endif


  mov edx, 0    ; edx = 0
  mov eax, ecx  ; eax = ecx

  div esi       ; edx eax % 3 = edx
  cmp edx, 0    ; edx ? 0
  je  then      ; edx = 0 -> then
  cmp edx, 0    ; 
  jg  then2     ;

then:
  add ebx, ecx  ; ebx += ecx
  jmp loop0      

then2:
  mov edx, 0    ; edx = 0
  mov eax, ecx  ; eax = ecx

  div edi       ; edx eax % 5 = edx
  cmp edx, 0    ; edx ? 0
  jg  loop0     ; edx > 0 -> loop0

  add ebx, ecx  ; ebx += ecx
  jmp loop0
  
endif:
  mov eax, 1
  int 0x80
