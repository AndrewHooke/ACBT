.686
.model flat, c
.stack 100h

.data
    X       dw 0E773h
    Y       dw 0717Fh
    Z       dw 026AAh

    X_prime dw 0
    M       dw 0
    R       dw 0
    result  dw 0

    nums    dw 4 dup(0)

.code

main PROC
    ; X увеличить на 1
    mov ax, X
    add ax, 1
    mov X_prime, ax

    ; nums = {X, X', Y, Z}

    mov ax, X
    mov nums[0], ax

    mov ax, X_prime
    mov nums[2], ax

    mov ax, Y
    mov nums[4], ax

    mov ax, Z
    mov nums[6], ax

    xor bx, bx

    mov esi, OFFSET nums
    mov ecx, 4

SUM_LOOP:

    add bx, word ptr [esi]

    add esi, 2

    loop SUM_LOOP

    mov M, bx

    ; Если M > 0

    cmp bx, 0
    jg CALL_SUB1
    jmp CALL_SUB2

; R = M*2 xor Y
CALL_SUB1:

    call SUB1
    jmp CHECK_OVERFLOW

SUB1 PROC

    mov ax, M

    shl ax, 1

    xor ax, Y

    mov R, ax

    ret

SUB1 ENDP

; R = M - (Z & 00FF)
CALL_SUB2:

    call SUB2
    jmp CHECK_OVERFLOW

SUB2 PROC

    mov ax, Z

    and ax, 00FFh

    mov bx, M

    sub bx, ax

    mov R, bx

    ret

SUB2 ENDP

; Проверка переполнения
CHECK_OVERFLOW:

    jo CALL_ADDR1
    jmp CALL_ADDR2

; Если переполнение - R = R + 0F91
CALL_ADDR1:
    call ADDR1
    jmp FINISH

ADDR1 PROC

    mov ax, R

    add ax, 0F91h

    mov result, ax

    ret

ADDR1 ENDP

; Если переполнения нет - R = R xor D1F1
CALL_ADDR2:

    call ADDR2
    jmp FINISH

ADDR2 PROC

    mov ax, R

    xor ax, 0D1F1h

    mov result, ax

    ret

ADDR2 ENDP

; Завершение программы
FINISH:

    nop
    jmp $

main ENDP

END main