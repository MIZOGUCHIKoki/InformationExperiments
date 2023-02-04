  section .text
  global  sort
sort:
  
  ;; ---processing input data---
  mov edx,  [esp + 4] ; data
  mov ecx,  [esp + 8] ; length
  mov eax,  [esp + 12]; sot       ; width
  push  esi
  push  edi
  push  ebx
  push  esp
  push  ebp
  mov ebx,  edx
  mov esi,  4
  mov edx,  0
  div esi   ; edx eax / esi = eax
  mov esi,  eax
  ;; ---
  ;; ebx  : header address.
  ;; ecx  : number of data in array.
  ;; esi  : number of data in struct.

  ;; ecx = data.length
  push  ebx
  mov eax,  ecx   ;
  mov edx,  0
  mov edx,  esi   ; length * width/4
  mul esi         ; eax * ecx = edx eax
  mov ebx,  1
  div ebx         ; edx eax / 1 = eax
  mov ecx,  eax   ; ecx = data.length
  pop ebx
  
  mov   eax,  0 ; max_index
  mov   edx,  0 ; max
  sub   ecx,  esi   ; i = length - sot
loop0:
  cmp   ecx,  0 ; ecx :: i
  jle   endp    ; if ecx <= 0 then jmp to endp
  mov   edx,  [ebx]   ; max = data[0]
  mov   eax,  0       ; max_indent = 0

  mov   edi,  esi ; edi = sot :: j

  loop1:
    cmp   edi,  ecx   ; j <= i?
    jg    swap        ; j > i -> swap
    
    push  esi
    mov   esi,  [ebx + edi*4] ; data[j]
    cmp   esi,  edx       ; data[j] >= max
    jge   then
    jmp   endif

    then:
      mov edx,  [ebx + edi*4] ; max = data[j]
      mov eax,  edi           ; max_index = j
    endif:
      pop esi
      add edi,  esi
      jmp loop1

  swap:
    push edi
    push edx
    push ebx
    mov edx,  0
    sub ebx,  4
    swap_loop:
      cmp edx,  esi
      jge endswap   ; if k >= sot then jmp to endswap
      push esi
      add ebx,  4
      mov   esi,  [ebx + eax*4]   ; m = data[max_index]
      mov   edi,  [ebx + ecx*4]   ; edi = data[i]
      mov   [ebx + eax*4],  edi   ; data[max_index],  data[i]
      mov   [ebx + ecx*4],  esi   ; data[i] = m
      pop esi
      inc edx
      jmp swap_loop
    endswap:
      pop ebx
      pop edx
      pop edi
    sub ecx,  esi
    jmp   loop0
	
endp:
  pop ebp
  pop esp
  pop ebx
  pop edi
  pop esi
  ret
