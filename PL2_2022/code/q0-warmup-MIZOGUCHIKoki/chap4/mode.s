  section .text 
  global  _start
_start:
  mov eax,  data1
  mov ecx,  ndata

  mov ebx,  255     ; mode
  mov edi,  1       ; max
loop:
  cmp ecx,  0     ; ndata == 0
  je  endp
  dec ecx         ; ndata--
  
  mov edx,  [eax]                 ; edx = data1[i]
  add [data2 + edx * 4], dword 1
  mov esi,  [data2 + edx * 4]     ; esi = data2[data1[i]]


  cmp esi,  edi     ; if(data2[data1[i]] == max) {
  je  blockif1      ;    mode > data1[i] --> mode = data1[i]
  jmp blockif2      ; }

   blockif1:
     cmp ebx,  [eax] ; mode <= data1[i]
     jle loopl       ; --> blockif2
     mov ebx,  [eax] ; mode = data1[i]
     jmp loopl

  blockif2:
     cmp esi,  edi   ; if(data2[data1[i]] > max )
     jg blockif3     ; 
     jmp loopl       ; 

     blockif3:
       mov ebx,  [eax]  ; mode = data1[i]
       inc edi          ; max++

  loopl:
  add eax,  4
  jmp loop

endp:
  mov eax,  1
  int 0x80

  section .data
data1:  dd  1
ndata:  equ ($ - data1)/4
data2:  times 256 dd  0
