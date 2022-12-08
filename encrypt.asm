; Part 1: Encrypt

extern printf
extern scanf
extern exit

global main

section .text

encryptText:
    mov rax, 0
    mov rbx, 0

    mov al, [A]
    mov ah, [Z]

startOfKey:
    mov rsi, key

encrypt:
    mov bl, [rdi]
    cmp bl, 0
    je endOfText

    mov bh, [rsi]
    cmp bh, 0
    je startOfKey

    sub bh, al
    add bl, bh
    cmp bl, ah
    ja wrap

    mov [rdi], bl
    jmp nextChar

wrap:
    sub bl, ah
    sub bl, 1
    add bl, al
    mov [rdi], bl

nextChar:
    inc rdi
    inc rsi
    jmp encrypt

endOfText:
    ret


main:
    mov rdi, promptKey
    mov rax, 0
    push rbx
    call printf
    pop rbx

    mov rdi, inputFormat
    mov rsi, key
    mov rax, 0
    push rbx
    call scanf
    pop rbx

    mov rdi, promptText
    mov rax, 0
    push rbx
    call printf
    pop rbx

    mov rdi, inputFormat
    mov rsi, text
    mov rax, 0
    push rbx
    call scanf
    pop rbx


    mov rdi, text
    push rbx
    call encryptText
    pop rbx


    mov rdi, outputFormat
    mov rsi, text
    mov rax, 0
    push rbx
    call printf
    pop rbx

    ; exit(0)
    mov rax, 0
    call exit

section .data
    promptKey    db "Enter the key: ", 0
    promptText   db "Enter the message: ", 0
    inputFormat  db "%s", 0

    outputFormat db "Encrypted message: %s", 0ah, 0dh, 0

    A db 'A'
    Z db 'Z'

section .bss
    key     resb 100
    text    resb 100
