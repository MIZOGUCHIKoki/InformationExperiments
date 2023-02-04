  section .text
  global  _start

_start:
  mov eax,  data1
  mov ecx,  ndata
  mov edx,  data2

loop:
  cmp ecx,  0
  je  setdatap
  
  mov edi,  [eax]                 ; edi = data1[i]

  mov [edx + (ecx - 1)*4],  edi   ; data2[ndata-i] = data1[i]
  dec ecx
  add eax,  4
  jmp loop

setdatap:
  mov ecx,  ndata
  mov eax,  data1
  mov edx,  data2
setdata:
  cmp ecx,  0
  je endp
  dec ecx

  mov esi,          [edx]
  mov [eax],      esi
  add edx,  4
  add eax,  4
  jmp setdata

endp:
  mov eax,  1
  mov ebx,  0
  int 0x80
  

  section .data
data1:  dd    1,2,3,4,5,6,7,8,9
ndata:  equ   ($ -data1)/4
data2:  times ndata dd 0
