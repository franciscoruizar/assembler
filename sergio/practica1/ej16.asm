/*
16. Escriba un código assembler para obtener en r0 la cantidad de unos de la representación binaria
del número contenido en r1 aplicando las operaciones de shift.
*/


.data
    VALOR: .word 0x758F1351

 .text
 .global main
 main:
    ldr r0,=VALOR
    ldr r0,[r0]

    mov r1,#0   @contador de unos
    mov r2,#0x01    @en binario 0000 0000 ... 0000 0001
    mov r5,#0       @contador de veltas

    ciclo:
    cmp r5,#32
    beq end

    and r3,r0,r2
    cmp r3,#0       @comparo r3 con 1
    addne r1,#1

    ror r2,r2,#1    @0000 0000 .... 0000 0010
    add r5,#1
    bal ciclo

 end:
    mov r7,#1
    swi 0