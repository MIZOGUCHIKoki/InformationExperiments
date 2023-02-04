  section .text
  global  sort3

sort3:
	push esi
	push edi
	push edx
	push eax
	push ecx
	push ebx
  push eax

  mov edx,  var           ; 変数格納
  dec ecx 
  ; ecx = data.length - 1
  ; ebx = data
insertdata:
  mov esi,  [ebx+ecx*4]   ; esi = x
  cmp ecx,  0
  je  endp
  dec ecx
  jmp pushheap

pushheap:
  add [edx],  dword 1         ; size++
  mov [ebx+edx],  esi         ; data[size] = 0
  mov edi,  [edx]
  mov [edx+4],  edi           ; int k = size

  while:
    mov edi,  [edx+4]         ; edi = k
    cmp edi,  1
    jng endp
    push eax
    push esi
    push ecx
    mov eax,  [ebx+edi*4]     ; eax = data[k]
    mov esi,  [ebx+edi*2]     ; esi = data[k/2]
    cmp eax,  esi             
    jle endw
    pop ecx
    pop esi
    pop eax

  ;  ; swap(data[k], data[k/2])
  ;  mov edi,  [ebx + edi*4]   ; edi = data[k]
  ;  mov [edx+8],  edi         ; i = data[k]
  ;  mov edi,  [ebx + edi*2]   ; edi = data[k/2]
  ;  mov [ebx + edi*4],  edi
  ;  mov edi,  [edx + 8]       ; edi = i
  ;  mov [ebx + edi*2],  edi   ; data[k/2] = i

  ;  push  ecx
  ;  push  esi
  ;  push  eax
  ;  push  edx
  ;    mov edx,  0
  ;    mov eax,  edi
  ;    mov ecx,  2
  ;    div ecx
  ;    mov [var+4],  eax
  ;  pop  edx
  ;  pop  eax
  ;  pop  esi
  ;  pop  ecx
  ;  jmp   while


    endw:
      pop ecx
      pop esi
      pop eax
      jmp endp

endp:
  pop eax
	pop ebx
	pop ecx
	pop eax
	pop edx
	pop edi
	pop esi
	ret

  section .data
var:  dd  0,0,0 ; size, k, i
