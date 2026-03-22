.686
.model flat,stdcall
.stack 100h

.data
    X dt 121
    Y dt 35
    Z dt 4
    M dt ?

.code
ExitProcess PROTO STDCALL :DWORD

Start:
    ; Инвертирование младшего бита X
    mov eax, dword ptr X    ; младшие 4 байта X
    xor eax, 1
    mov ebx, eax
    
    ; Инвертирование младшего бита Y
    mov eax, dword ptr Y    ; младшие 4 байта Y
    xor eax, 1
    mov ecx, eax
    
    ; Вычисление (X' & Y')
    and ebx, ecx
    
    ; Вычисление Z*5
    mov eax, dword ptr Z    ; младшие 4 байта Z
    mov edx, 5
    mul edx
    
    ; Вычисление M = Z*5 + (X' & Y')
    add eax, ebx
    
    ; Сохраняем результат
    mov dword ptr M, eax    ; запись в младшие 4 байта M
    
exit_program:
    invoke ExitProcess, 0

end Start
