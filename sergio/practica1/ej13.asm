/*
13. Escriba un fragmento de código para obtener el producto entre los números 18 y 34. 
¿Dónde queda almacenado el resultado?
 */

 .data

 .text
 .global main
 main:
    mov r0,#18
    mov r1,#34

    mul r2,r1,r0

 end:
    mov r7,#1
    swi 0