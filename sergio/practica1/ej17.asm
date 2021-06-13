/*
17. La siguiente etiqueta contiene un caracter ASCII que es un dígito decimal.
DIGITO : .byte '8'
Escriba un programa que almacene el valor numérico correspondiente al dígito decimal en el
registro r0.
*/


.data
    DIGITO : .byte '8'

 .text
 .global main
 main:
    mov r0,#0
    ldr r1,=DIGITO
    ldrb r0,[r1]        @r1 contiene '8' en codigo ascii

    sub r0,r0,#0x30     @convierto de ascii a entero

 end:
    mov r7,#1
    swi 0