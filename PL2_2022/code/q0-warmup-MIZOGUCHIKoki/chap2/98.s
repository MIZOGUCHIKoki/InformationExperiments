; 演習1.2-2
; 98 + 7 - (6 * 5) + (4 * 3 * 2) + 1
    section   .text
    global    _start
_start:
    
    mov   ebx, 98
    add   ebx, 7    ; 98 + 7 = 105

    mov   ecx, 6    ; 6
    mov   eax, 5    ; 5
    mul   ecx       ; eax * ecx  = edx eax
    sub   ebx, eax  ; ebx - eax (105 - 30)

    mov   eax, 4
    mov   edi, 3
    mul   edi       ; eax * edi = edx eax
    mov   ecx, 2    ; ecx = 2

    mul   ecx       ; esi * eax = edx eax
    add   ebx, eax  ; ebx + eax

    add   ebx, 1    ;

    mov   eax, 1    ; system call number
    int   0x80      ; exit system call
