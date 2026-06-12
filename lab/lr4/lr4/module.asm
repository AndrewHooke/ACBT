.586
.model flat, c

option casemap:none

includelib legacy_stdio_definitions.lib

extern CalcFunc:proc
extern printf:proc

.data

fmtX db "x = %.4lf   y = %.6lf", 10, 0

currentX dq 0.0
result dq 0.0
stepVal dq 0.0

.code

public CalcValues

CalcValues proc

    push ebp
    mov ebp, esp

    push esi

    ; n
    mov esi, [ebp+8]

    ; currentX = startX
    fld qword ptr [ebp+12]
    fstp qword ptr currentX

    ; stepVal = step
    fld qword ptr [ebp+20]
    fstp qword ptr stepVal

loop_start:

    cmp esi, 0
    jle loop_end

    ; CalcFunc(currentX)

    sub esp, 8

    fld qword ptr currentX
    fstp qword ptr [esp]

    call CalcFunc

    fstp qword ptr result

    add esp, 8

    ; printf

    push dword ptr [result+4]
    push dword ptr [result]

    push dword ptr [currentX+4]
    push dword ptr [currentX]

    push offset fmtX

    call printf

    add esp, 20

    ; currentX += step

    fld qword ptr currentX
    fadd qword ptr stepVal
    fstp qword ptr currentX

    dec esi
    jmp loop_start

loop_end:

    pop esi

    mov esp, ebp
    pop ebp

    ret

CalcValues endp

end