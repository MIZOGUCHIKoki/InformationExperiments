  ;255以下の素数の個数を計算して出力するアセンブリ言語
  section .text
  global  _start

_start:
  mov ebx, 255    ; test_value = 255
  mov ecx, 0      ; pn_counter = 0

  inc ebx

loop0:
  cmp ebx, 2      ; test_value ? 0
  je  endq        ; text_value = 0

  dec ebx         ; test_value --
  mov esi, 2      ; div_counter = 2

  loop1:
    cmp esi, ebx        ; test_value ? dvi_counter
    jge inc_pn_counter  ; test_value = div_counter

    mov eax, 0
    mov edx, 0
    
    mov eax, ebx  ; eax = test_value
    div esi       ; edx eax % esi = edx
    cmp edx, 0    ; edx ? 0

    je  loop0     ; edx = 0 -> loop0
    inc esi       ; div_counter ++
    jmp loop1

  inc_pn_counter:
    inc ecx       ; pn_counter ++
    jmp loop0     ; 

endq:
  mov ebx, ecx    ;
  mov eax, 1      ;
  int 0x80        ;
