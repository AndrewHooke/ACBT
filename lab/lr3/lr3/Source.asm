.686
.model flat, stdcall
.stack 4096

ExitProcess PROTO :DWORD

.data

N       EQU 10

arr     SWORD 25, 11, 44, 17, 33, 8, 121, 50, 22, 5

sum11   DWORD ?
tmp     DWORD ?

.code

main PROC

; Сортировка массива по возрастанию (пузырьком)

    mov ecx, N-1

outer_loop:

    push ecx

    mov esi, OFFSET arr
    mov ecx, N-1

inner_loop:

    mov ax, [esi]
    cmp ax, [esi+2]
    jle no_swap

    xchg ax, [esi+2]
    mov [esi], ax

no_swap:

    add esi, 2
    loop inner_loop

    pop ecx
    loop outer_loop

; Суммирование элементов, делящихся на 11
; через математический сопроцессор-

    finit

    fldz                    ; ST(0)=0

    mov esi, OFFSET arr
    mov ecx, N

sum_loop:

    movsx eax, WORD PTR [esi]

    cdq
    mov ebx, 11
    idiv ebx

    cmp edx, 0
    jne not_divisible

    movsx eax, WORD PTR [esi]
    mov tmp, eax

    fiadd DWORD PTR tmp

not_divisible:

    add esi, 2
    loop sum_loop

    fistp DWORD PTR sum11

    push 0
    call ExitProcess

main ENDP

END main