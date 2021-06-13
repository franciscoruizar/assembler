/*
2. Escriba un programa que calcule en el registro r1 la suma de los números del 1 al 100.
*/


.data

 .text
 .global main
 main:
    mov r0,#0   @limpio el registro r0
    mov r1,#0   @limpio el registro r1

    ciclo:
        cmp r1,#100     @comparo el auxiliar con el 100
        beq end
        add r1,#1       @incremento 1 al registro auxiliar
        add r0,r0,r1    @acumulo la suma en r0
        bal ciclo

 end:
    mov r7,#1
    swi 0