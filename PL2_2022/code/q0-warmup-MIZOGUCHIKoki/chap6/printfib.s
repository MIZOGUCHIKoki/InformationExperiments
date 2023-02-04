  ;; "N"$B$r=PNO(B
  section .text
  global  _start
_start:
loop: ; $BA4BN$N%k!<%W(B
  mov esi, fib
  mov ecx, [esi + 8]
  cmp ecx, 1
  je endp 

; $B%U%#%\%J%C%A7W;;(B
  sub [esi + 8], dword 1

  mov ebx, [esi]        ; f(0)
  mov ecx, [esi + 12]   ; f(n)
  mov edi, [esi + 4]    ; f(1)

; f(0), f(1), n, f(n)
  mov ecx,  0
  add ecx, [esi]
  add ecx, [esi + 4]
  
  mov ebx,  edi
  mov edi,  ecx

  mov [fib + 12], ecx
  mov [fib], ebx
  mov [fib + 4], edi

    
  ; N$B$N7e?t$r%+%&%s%H(B
  mov edi,  10   ; $B3d$k?t(B
  mov esi,  1    ; $B7e?t(B
  mov eax,  [fib + 12]  ; (1932)
countK:
  mov edx,  0     
  div edi         ; edx eax / edi = eax 1932 / 10 = 193
  cmp eax,  0
  je endcountK
  inc esi          ; $B7e?t(B++
  jmp countK

endcountK:
  mov esi,  esi   ; $B7e?t$r3NDj(B $B!J$$$i$J$$!K(B

writeProcess:
  mov ecx,  buf + 4
  mov edi,  10
  mov eax,  [fib + 12]
loop0:
  mov edx,  0
  dec ecx                 ; $B<!$N=q$-9~$_@h(B
  div edi                 ; N / 10 = eax, mod edx
  add dl, '0'
  mov [ecx], dl           ; $B=q$-9~$_(B
  cmp eax,  0
  jne loop0

  mov eax,  4             ; write $B%7%9%F%`%3!<%kHV9f(B
  mov ebx,  1             ; $B=PNO@hHV9f!J(B1=$BI8=`=PNO!K(B
  add esi,  1             ; $B2~9T$r4^$a$?D9$5(B
  mov edx,  esi           ; $B2~9T$r4^$a$?D9$5(B
  int 0x80
jmp loop
endp:
  mov eax,  1
  mov ebx,  0
  int 0x80

 section .data
buf:  times 4  db  0     ; ndigit$B%P%$%HNN0h(B(2^32$B$N7e?t(B)
      db  0x0a            ; $B2~9T(B
fib: dd   0,1,20,0           ; $B%U%#%\%J%C%A?t$r3JG<$9$k%a%b%j(B
; f(0), f(1), n, f(n)
