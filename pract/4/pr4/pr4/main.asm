
$MOD51

org 00h
jmp start

org 30h

start:
    mov TMOD, #01h
    mov P1, #00h

main:

    mov P1, #11h
    mov R2, #64h         
    call delay_long

    mov P1, #22h
    mov R2, #50h
    call delay_long

    mov P1, #44h
    mov R2, #3Ch
    call delay_long

    mov P1, #88h
    mov R2, #28h
    call delay_long

    jmp main

delay_base:
    mov TH0, #03Ch      
	mov TL0, #0AFh      
    clr TF0
    setb TR0
wait_base:
    jnb TF0, wait_base
    clr TR0
    ret

delay_long:
d1:
    call delay_base
    djnz R2, d1
    ret

END