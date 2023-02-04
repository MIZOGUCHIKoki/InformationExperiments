  ;; "N"$B$r(B16$B?J?t$G=PNO(B
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
  dec ecx                 ; $B<!$N=q$-9~$_@h(B
  div edi                 ; N / 10 = eax, mod edx
  cmp edx,  9
  jle skip
    sub dl, 10
    add dl, 'a'
    jmp endl
  skip:
    add dl, '0'
  endl:
    mov [ecx], dl           ; $B=q$-9~$_(B
    jmp loop0

writeP:
  mov eax,  4             ; write $B%7%9%F%`%3!<%kHV9f(B
  mov ebx,  1             ; $B=PNO@hHV9f!J(B1=$BI8=`=PNO!K(B
  mov edx,  ndigit + 1    ; $B2~9T$r4^$a$?D9$5(B
  int 0x80
  mov eax,  1
  mov ebx,  0
  int 0x80

 section .data
buf:  times ndigit  db  0     ; ndigit$B%P%$%HNN0h(B(2^32$B$N7e?t(B)
      db  0x0a            ; $B2~9T(B
