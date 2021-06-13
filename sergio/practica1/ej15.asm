/*
15. Suponiendo que la etiqueta VALORES define una secuencia de cuatro números enteros sin
signo, escriba las instrucciones necesarias para calcular el promedio (truncado a un número
entero) de esos cuatro números. Defina una etiqueta PROMEDIO para almacenar el valor
calculado.
 */


.data
    VALORES: .word 1,5,8,10

 .text
 .global main
 main:
    mov r4,#0
    mov r2,#0
    ldr r0,=VALORES
    ciclo:
    cmp r4,#3
    beq divide


    ldr r1,[r0],#4
    add r2,r2,r1
    add r4,#1
    bal ciclo

    divide:
        mov r3,#4
        mov r5,#0
        ciclo2:
        cmp r2,r3       @si R0 es menor a 2
        blt end
        sub r2,r3
        add r5,#1
        bal ciclo2

 end:
    mov r7,#1
    swi 0