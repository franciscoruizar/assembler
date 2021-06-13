/**
4. Escriba un programa en assembler para cada uno de los siguientes problemas
a. La etiqueta VECTOR1 define 10 posiciones en memoria. Obtener en r0 la suma de esas
10 posiciones.
b. Sumar en r1 los elementos definidos en VECTOR2 con la siguiente directiva
vector2: .word 128, 314, 1024, 127, 16000, 65000
Tener en cuenta que cada elemento ocupa cuatro bytes (word)
 */

 .data
    vector2: .word 128, 314, 1024, 127, 16000, 65000

 .text
 .global main
 main:
    ldr r0,=vector2
    ldr r2,[r0]
    add r0,#4

    mov r1,r2

    ldr r2,[r0]
    add r0,#4

    add r1,r1,r2

    ldr r2,[r0]
    add r0,#4

    add r1,r1,r2

    ldr r2,[r0]
    add r0,#4

    add r1,r1,r2

    ldr r2,[r0]
    add r0,#4

    add r1,r1,r2

    ldr r2,[r0]
    add r0,#4

    add r1,r1,r2

 end:
    mov r7,#1
    swi 0