/**
9. Usando la instrucción AND modifique el registro r0 poniendo en cero los 4 bits menos
significativos preservando el valor de los 28 bits más significativos. Por ejemplo, si el número
contenido en r0 es ( 00000000 00000000 00000000 01111010 binario), debe quedar (00000000
00000000 00000000 01110000 binario).
 */


 .data
    auxiliar: .word 0xFFFFFFF0

 .text
 .global main
 main:
    mov r0,#0xaa
    ldr r2,=auxiliar
    ldr r2,[r2]

    and r1,r0,r2


 end:
    mov r7,#1
    swi 0