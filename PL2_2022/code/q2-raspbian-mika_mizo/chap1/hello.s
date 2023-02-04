	.section .text
        .global _start
_start:
        @ write
        mov   r7, #4           
        mov   r0, #1           
        ldr   r1, =msg         
        ldr   r2, =msglen       
        swi   #0

        @ exit
        mov   r7, #1            
        mov   r0, #0            
        swi   #0

        .section .data
msg:
        .ascii "I'm fine.\n"
        .equ msglen, . - msg
