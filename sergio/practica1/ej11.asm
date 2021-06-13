/**
11. Muestre cómo usar la instrucción AND para apagar el bit más significativo del registro r0.
 */

 .data
    auxiliar: .word 0x7FFFFFFF
    dato: .word 0xF0000000
 .text
 .global main
 main:
    ldr r0,=auxiliar
    ldr r0,[r0]

    ldr r1,=dato
    ldr r1,[r1]

    ands r2,r0,r1       


 end:
    mov r7,#1
    swi 0