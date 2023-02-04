  section .text
  global  sort
sort:
	push  esi
	push  edi
	push  edx
  push  ecx
  push  ebx
  push  eax

  mov   eax,  0 ; max_index
  mov   edx,  0 ; max
  dec   ecx
loop0:
  cmp   ecx,  0 ; ecx = i
  jle   endp
  mov   edx,  [ebx]   ; max = data[0]
  mov   eax,  0       ; max_indent = 0

  mov   edi,  1 ; edi = j

  loop1:
    cmp   edi,  ecx   ; j > i?
    jg    loop0l

    mov   esi,  [ebx + edi*4] ; data[j]
    cmp   esi,  edx       ; data[j] >= max
    jge   then
    jmp   endif

    then:
      mov edx,  [ebx + edi*4] ; max = data[j]
      mov eax,  edi           ; max_index = j
    endif:
      inc edi
      jmp loop1

  loop0l:
    push esi
    push edi
    mov   esi,  [ebx + eax*4]   ; m = data[max_index]
    mov   edi,  [ebx + ecx*4]   ; edi = data[i]
    mov   [ebx + eax*4],  edi   ; data[max_index],  data[i]
    mov   [ebx + ecx*4],  esi   ; data[i] = m
    pop edi
    pop esi
    dec   ecx
    jmp   loop0
	
endp:
  pop eax
  pop ebx
  pop ecx
	pop edx
	pop edi
	pop esi
	ret
