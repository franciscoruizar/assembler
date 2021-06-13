/*
1. Escriba fragmentos de código assembler para realizar las siguientes operaciones:
a. Las etiquetas N1 y N2 definen dos words . Obtenga en r0 el máximo entre N1 y N2.
b. Las etiquetas N1 y N2 definen dos bytes . Obtenga en r0 el máximo entre N1 y N2.
c. Las etiquetas E1 y E2 definen dos números enteros de 32 bits en complemento a
2 . Obtenga en r0 el máximo entre E1 y E2.
*/

.data
    N1: .word 8
    N2: .word 9

    M1: .byte 8
    M2: .byte 9
    

 .text
 .global main
 main:
    ldr r1,=N1
    ldr r1,[r1]

    ldr r2,=N2
    ldr r2,[r2]

    cmp r1,r2       @comparo N1 con n2
    addgt r0,r1,#0
    addlt r0,r2,#0

    //segunda parte
    mov r1,#0
    mov r2,#0

    ldr r1,=M1
    ldrb r1,[r1]

    ldr r2,=M2
    ldrb r2,[r2]

    cmp r1,r2       @comparo N1 con n2
    addgt r0,r1,#0
    addlt r0,r2,#0

 end:
    mov r7,#1
    swi 0