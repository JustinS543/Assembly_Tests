; Compile: nasm -f elf helloworld2.asm
; Link: ld -m elf_i386 helloworld2.o -o helloworld2
; Run: ./helloworld2
 
SECTION .data
msg     db      'Hello World! This is a test of modifying string length.', 0Ah     
 
SECTION .text
global  _start
 
_start:
 
    mov     ebx, msg            ; move the address of msg into ebx
    mov     eax, ebx            ; make eax and ebx point to the same memory location

nextchar:

    cmp     byte [eax], 0       ; compare the byte at eax to zero, since the end of the string is a zero character
    jz      finished            ; jump to finished routine if the zero byte has been set/found
    inc     eax                 ; if zero flag has not been set/found, increment eax by 1
    jmp     nextchar            ; jump to nextchar

finished:

    sub     eax, ebx            ; subtract ebx from eax. eax was incremented for every character,
                                ; which gives us the final total of chars in the string.

    mov     edx, eax            ; move eax into edx. edx now holds number of bytes to write
    mov     ecx, msg            ; move the msg into ecx. ecx now holds the string.
    mov     ebx, 1              ; stdout
    mov     eax, 4              ; syscall write
    int     80h

    mov     ebx, 0              ; Returns zero errors
    mov     eax, 1              ; sys_exit opcode 1
    int     80h