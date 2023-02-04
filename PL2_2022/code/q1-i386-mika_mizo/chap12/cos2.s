	section .text
	global cos

cos:
	push  esi
	push  edi
	push  edx
	push  ecx
	push  ebx

  ;abs|eax|
  mov esi,  0x01000000
  cmp eax,  0
  jge pr
  not eax
  inc eax
  
pr:
  ; x^2/2!
  mul eax      ; in * in = edx eax
  mov ebx,  0x02000000  ; 
  div ebx      ; edx eax / ebx = eax
  sub esi,  eax
  push  eax
  
  ; x^4/4!
  mul eax     ; (in ^ 2 / 2!) ^ 2
  mov ebx,  0x06000000  ; in ^ 4 / 4! 
  div ebx     ; edx eax / ebx = eax
  add esi,  eax
 
  ; x^6/6!
  mov ecx,  eax ; ecx = in ^ 4 / 4! 
  pop eax       ; eax = in ^ 2 / 2!

  mul ecx       ; eax * ecx = edx eax
  mov edi,  0x0f000000 ; edx = 15
  div edi       ; edx eax / edi = eax
  sub esi,  eax

endp:
  mov eax,  esi
  pop ebx
  pop ecx
  pop edx
  pop edi
  pop esi
  ret
