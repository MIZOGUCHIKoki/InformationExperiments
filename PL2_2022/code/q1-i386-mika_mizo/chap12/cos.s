	section .text
	global cos

cos:
	push  esi
	push  edi
	push  edx
	push  ecx
	push  ebx

  ;abs|in|
  mov esi,  0x01000000
  cmp eax,  0
  jge pr
  not eax
  inc eax
  
pr:
  ;; |in| > pi/2 ? 
  mov ebx,  half_pi
  mov ecx,  pi
  cmp eax,  ebx
  jle pr1
  mov edi,  1
  push  edi
  sub ecx,  eax   ; pi - x
  mov eax,  ecx   ; eax = pi - x :: in'
  jmp cos_eax
pr1:
  mov edi,  0
  push  edi

cos_eax:
  ;; in' / 2
  shr eax,  1   ; eax / 2 :: in' / 2
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

  ;; 2 * cos(in'/2)
  mov eax,  esi ; eax = cos(in' / 2)
  mul eax       ; cos(in'/2) ^ 2
  ;; edx eax (16.48 -> 8.24)    ; 2 * cos(in/2)
  mov ebx,  0x00800000  ; 0.5 [8.24]
  div ebx
  mov ebx,  0x01000000  ; 1 [8.24]
  sub eax,  ebx

  pop edi
  cmp edi,  1
  jne endp
  not eax
  inc eax
endp:
  pop ebx
  pop ecx
  pop edx
  pop edi
  pop esi
  ret

  section .data
half_pi:	equ	0x01921fb5  ;pi/2
pi:	equ	0x03243f6a        ;pi
