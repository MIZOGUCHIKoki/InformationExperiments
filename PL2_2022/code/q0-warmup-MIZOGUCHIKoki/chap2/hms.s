; 演習1.2-3
; 123456秒を時分秒で出力
    section   .text
    global    _start
_start:
    
    mov   eax, 12356   ; ebx = 12356
    mov   edx, 0
    mov   ebx, 3600     ; ecx = 3600
    div   ebx           ; eax / ebx = eax, eax % ebx = edx
    mov   ebx, eax      ; "ebx"に時間を格納

    mov   eax, edx      ; eax <= edx
    mov   edx, 0
    mov   ecx, 60       ; ecx = 60
    div   ecx           ; eax / ecx = eax, eax % ecx = edx
    mov   ecx, eax      ; "ecx"に分を格納
    mov   esi, edx      ; esi <= edx

    mov   eax, ebx      ; ebx => eax
    mov   ebx, 10
    mul   ebx           ; ebx * eax = edx eax
    mov   ebx, eax      ; ebx <= eax

    mov   eax, ecx      ; eax <= ecx
    mov   ecx, 5
    mul   ecx           ; eax * ecx = edx eax
    mov   ecx, eax      ; ecx <= eax

    add   ebx, ecx
    add   ebx, esi

    mov   eax, 1
    int   0x80

   
