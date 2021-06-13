/**
12. Muestre cómo usar la instrucción OR para encender el bit más significativo del registro r0.
 */

 .data
    auxiliar: .word 0x80000000
    dato: .word 0x70000000
 .text
 .global main
 main:
    ldr r0,=auxiliar
    ldr r0,[r0]

    ldr r1,=dato
    ldr r1,[r1]

    orr r2,r0,r1       


 end:
    mov r7,#1
    swi 0