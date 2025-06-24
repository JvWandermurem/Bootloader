; bootloader.s - Mini Shell 

org 0x7c00
bits 16

; --- Ponto de Entrada ---
start:
    mov ax, 0
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7c00

    
    call clear_screen

    jmp main        ; Pula para a nossa lógica principal

; --- Funções (sem alterações) ---

print_string:
    mov ah, 0x0e
.loop:
    lodsb
    cmp al, 0
    je .done
    int 0x10
    jmp .loop
.done:
    ret

clear_screen:
    mov ah, 0x00
    mov al, 0x03
    int 0x10
    ret

wait_for_key:
    mov ah, 0x00
    int 16h
    ret

; --- Dados  ---

msg_titulo:   db "--- Meu Mini Shell Wander---", 13, 10, 13, 10, 0
msg_op1:      db "1. Mostrar mensagem", 13, 10, 0
msg_op2:      db "2. Mudar fundo para Azul", 13, 10, 0
msg_op3:      db "3. Reiniciar shell", 13, 10, 13, 10, 0
msg_prompt:   db "Escolha uma opcao: ", 0
msg_secreta:  db "Final de Semestre acaba logoo", 13, 10, 0
msg_invalida: db "Opcao invalida!", 13, 10, 0
msg_continue: db "Pressione qualquer tecla para voltar ao menu...", 0
enter:        db 13, 10, 0

; --- Lógica Principal ---

main:

    mov si, msg_titulo
    call print_string
    mov si, msg_op1
    call print_string
    mov si, msg_op2
    call print_string
    mov si, msg_op3
    call print_string

main_loop:
    mov si, msg_prompt
    call print_string

    call wait_for_key
    push ax

    mov si, enter
    call print_string

    pop ax

    cmp al, '1'
    je handle_op1

    cmp al, '2'
    je handle_op2

    cmp al, '3'
    je handle_op3

    mov si, msg_invalida
    call print_string
    jmp main_loop

; --- Rotinas de Manipulação das Opções ---

handle_op1:
    call clear_screen ; Limpa a tela para mostrar a mensagem
    mov si, msg_secreta
    call print_string
    jmp end_action

handle_op2:
    mov ah, 0x06
    mov al, 0
    mov bh, 0x1F    ;
    mov cx, 0
    mov dx, 0x184F
    int 10h
    jmp main        
handle_op3:
    jmp 0xFFFF:0x0000

end_action:
    mov si, msg_continue
    call print_string
    call wait_for_key
    jmp main            ; Volta para o menu 

; --- Assinatura do Bootloader ---
times 510 - ($ - $$) db 0
dw 0xAA55