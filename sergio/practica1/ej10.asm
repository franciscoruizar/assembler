/**
10. Usando AND, determine si el bit más significativo del registro r0 está encendido (1). Aclare cuál
es la condición (flag) que indica si dicho bit vale 0 o 1.
 */

 .data
    auxiliar: .word 0x80000000
    dato: .word 0xf0000000
 .text
 .global main
 main:
    ldr r0,=auxiliar
    ldr r0,[r0]

    ldr r1,=dato
    ldr r1,[r1]

    ands r2,r0,r1       @si se enciende el flag Z, es porque no estaba prendido el bit mas significativo


 end:
    mov r7,#1
    swi 0