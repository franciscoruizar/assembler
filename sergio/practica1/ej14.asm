/*
14. Las etiquetas N1, N2 y N3 representan números sin signo. Escriba fragmentos de código
assembler para almacenar en N3:
a. la suma de N1 y N2.
b. el producto de N1 por N2.
c. el cociente N1 dividido el valor constante 2 (explorar las operaciones de desplazamiento).
 */

 
 .data
    N1: .word 15
    N2: .word 20
    N3: .word 0
 .text
 .global main
 main:
    ldr r0,=N1
    ldr r0,[r0]

    ldr r1,=N2
    ldr, r1,[r1]

    ldr r2,=N3

    //a
    add r3,r0,r1
    str r3,[r2]

    //b
    mul r3,r0,r1
    str r3, [r2]

    //c
    mov r3,#2
    mov r4,#0
    ciclo:
    cmp r0,r3       @si R0 es menor a 2
    blt end
    sub r0,r3
    add r4,#1
    bal ciclo

 end:
    mov r7,#1
    swi 0