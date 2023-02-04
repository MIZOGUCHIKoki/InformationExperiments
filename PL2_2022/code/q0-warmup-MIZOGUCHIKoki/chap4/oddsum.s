  section .text
  global  _start

_start:
    mov   esi,  data1     ; 開始番地
    mov   ecx,  ndata     ; データ数
    mov   ebx,  0         ; 和
    mov   edi,  2         ; 割る数


loop0:
   cmp   ecx,  0         ; 残りデータ数 ? 0
   je    endp            ; 残りデータ数 == 0 -> endp
   dec   ecx             ; 残りデータ数--

   mov   edx,  0
   mov   eax,  [esi]     ; eax = [data1 + i]

   div   edi             ; edx eax % edi = edx
   cmp   edx,  0         ; edx ? 0
   je    even            ; eax == 0 -> then1 （偶数処理）
   ;奇数処理
   add   ebx,  [esi]     ; ebx += [esi + i]
   add   esi,  4
   jmp   loop0
   ;偶数処理
even:                  
   add   esi,  4
   jmp   loop0

endp:
  mov eax, 1
  int 0x80

data1:    dd    1, 2, 3, 4, 5, 6, 7, 8, 9
ndata:    equ   ($ - data1)/4
