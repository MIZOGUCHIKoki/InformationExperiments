  ;; "N"を16進数で出力
N: equ 2595
ndigit: equ 8

  section .text
  global  _start
_start:
  mov esi, ndigit

writeProcess:
  mov ecx,  buf + ndigit
  mov edi,  16
  mov eax,  N
loop0:
  cmp esi, 0
  je writeP
  dec esi

  mov edx,  0
  dec ecx                 ; 次の書き込み先
  div edi                 ; N / 10 = eax, mod edx
  cmp edx,  9
  jle skip
    sub dl, 10
    add dl, 'a'
    jmp endl
  skip:
    add dl, '0'
  endl:
    mov [ecx], dl           ; 書き込み
    jmp loop0

writeP:
  mov eax,  4             ; write システムコール番号
  mov ebx,  1             ; 出力先番号（1=標準出力）
  mov edx,  ndigit + 1    ; 改行を含めた長さ
  int 0x80
  mov eax,  1
  mov ebx,  0
  int 0x80

 section .data
buf:  times ndigit  db  0     ; ndigitバイト領域(2^32の桁数)
      db  0x0a            ; 改行
