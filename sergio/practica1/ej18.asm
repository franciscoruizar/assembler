/*
18. Suponiendo que la etiqueta X apunta a la representación en texto ASCII de un número de 3
dígitos en base 10 (un carácter para cada dígito), obtenga en r0 el valor de ese número. Tener
en cuenta que los caracteres ‘0’ a ‘9’ tienen código ASCII 30h a 39h.
*/

.data
    DIGITO : .ascii "851"

 .text
 .global main
 main:
    mov r0,#0
    mov r2,#100
    mov r6,#10
    mov r3,#0
    ldr r1,=DIGITO

    ldrb r3,[r1],#1
    sub r3,r3,#0x30        
    mul r0,r3,r2

    ldrb r3,[r1],#1
    sub r3,r3,#0x30        
    mul r5,r3,r6
    add r0,r0,r5

    ldrb r3,[r1],#1
    sub r3,r3,#0x30
    add r0,r0,r3

 end:
    mov r7,#1
    swi 0