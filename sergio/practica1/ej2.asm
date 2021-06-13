/**
2. Teniendo en cuenta las siguientes definiciones
N1: .word 18
N2: .word 33
N3: .word 40
escriba fragmentos de código para:
a. obtener en r0 el resultado de la operación N1 + N2 - N3.
b. hacer el mismo cálculo, almacenando el resultado en N1.
c. intercambiar los valores asignando a N1 el valor de N2, a N2 el de N3 y a N3 el de N1.
 */

 .data
    N1: .word 18
    N2: .word 33
    N3: .word 40

 .text
 .global main

 main:
    ldr r1,=N1
    ldr r1,[r1]

    ldr r2,=N2
    ldr r2,[r2]

    ldr r3,=N3
    ldr r3,[r3]

    add r0,r1,r2
    add r0,r0,r3


    ldr r1,=N1
    str r2,[r1]

 end:
    mov r7,#1
    swi 0