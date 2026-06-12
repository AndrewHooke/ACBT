$MOD51

ORG 0000h

START:
    MOV SCON, #90h
    MOV PCON, #80h

    MOV R0, #40h
    MOV R7, #20

RECV:
    JNB RI, $

    MOV A, SBUF
    MOV @R0, A

    INC R0
    CLR RI

    DJNZ R7, RECV

STOP:
    SJMP STOP

END