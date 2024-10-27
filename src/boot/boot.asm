; boot.asm
section .text
    global _start

_start:
    ; Load the kernel (for now we just display a message)
    mov edx, message
    call print_message

    ; Loop forever
.loop:
    jmp .loop

print_message:
    mov eax, 4          ; sys_write
    mov ebx, 1          ; file descriptor (stdout)
    mov ecx, edx        ; message to write
    mov edx, message_length
    int 0x80            ; call kernel
    ret

section .data
message db 'Hello, Kernel!', 0x0A
message_length equ $ - message

