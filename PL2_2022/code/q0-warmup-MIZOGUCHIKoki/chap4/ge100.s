  section .text
  global  _start
_start:
    mov esi,  data1          ; データ
    mov edi,  ndata          ; データの個数
    mov ebx,  0              ; 100以上のデータの個数
loop0:
    cmp edi,  0              ; 残りデータの個数 ? 0
    je  endp                 ; 残りデータの個数 == 0 -> endp
    dec edi                  ; 残りデータの個数 --

    cmp [esi], dword 100     ; [data1] ? 100
    jge over                 ; [data1] >= 1 -> over（100以上）
                             
    add esi,  4              ; [data1 + (+)]
    jmp loop0                ; loop（100未満）

;100以上のときの処理
over:
    inc ebx
    add esi,  4
    jmp loop0

endp:
    mov eax,  1
    int 0x80
    
data1: dd  3, 141, 592, 6, 53, 5, 897 
ndata: equ ($ - data1) / 4
