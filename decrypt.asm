; Part 1: Decrypt

extern printf
extern scanf
extern exit

global main

section .text

decryptText:
    mov rax, 0
    mov rbx, 0

    mov al, [A]
    mov ah, [Z]

startOfKey:
    mov rsi, key

decrypt:
    mov bl, [rdi]
    cmp bl, 0
    je endOfText

    mov bh, [rsi]
    cmp bh, 0
    je startOfKey

    sub bh, al
    sub bl, bh
    cmp bl, al
    jb wrap

    mov [rdi], bl
    jmp nextChar

wrap:
    sub bl, al
    add bl, 1
    add bl, ah
    mov [rdi], bl

nextChar:
    inc rdi
    inc rsi
    jmp decrypt

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
    call decryptText
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
    promptText   db "Enter the encrypted message: ", 0
    inputFormat  db "%s", 0

    outputFormat db "Decrypted message: %s", 0ah, 0dh, 0

    A db 'A'
    Z db 'Z'

section .bss
    key  resb 100
    text resb 100
