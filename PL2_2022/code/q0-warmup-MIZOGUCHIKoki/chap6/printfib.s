  ;; "N"を出力
  section .text
  global  _start
_start:
loop: ; 全体のループ
  mov esi, fib
  mov ecx, [esi + 8]
  cmp ecx, 1
  je endp 

; フィボナッチ計算
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

    
  ; Nの桁数をカウント
  mov edi,  10   ; 割る数
  mov esi,  1    ; 桁数
  mov eax,  [fib + 12]  ; (1932)
countK:
  mov edx,  0     
  div edi         ; edx eax / edi = eax 1932 / 10 = 193
  cmp eax,  0
  je endcountK
  inc esi          ; 桁数++
  jmp countK

endcountK:
  mov esi,  esi   ; 桁数を確定 （いらない）

writeProcess:
  mov ecx,  buf + 4
  mov edi,  10
  mov eax,  [fib + 12]
loop0:
  mov edx,  0
  dec ecx                 ; 次の書き込み先
  div edi                 ; N / 10 = eax, mod edx
  add dl, '0'
  mov [ecx], dl           ; 書き込み
  cmp eax,  0
  jne loop0

  mov eax,  4             ; write システムコール番号
  mov ebx,  1             ; 出力先番号（1=標準出力）
  add esi,  1             ; 改行を含めた長さ
  mov edx,  esi           ; 改行を含めた長さ
  int 0x80
jmp loop
endp:
  mov eax,  1
  mov ebx,  0
  int 0x80

 section .data
buf:  times 4  db  0     ; ndigitバイト領域(2^32の桁数)
      db  0x0a            ; 改行
fib: dd   0,1,20,0           ; フィボナッチ数を格納するメモリ
; f(0), f(1), n, f(n)
