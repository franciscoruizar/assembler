/*
Modos de Direccionamiento y Memoria (20 puntos)
a. (10 puntos) Explique al menos dos direccionamientos para recorrer los elementos de 
un vector teniendo en cuenta que elemento del vector ocupa 32 bits.
b. (10 puntos) Explique que es program counter (PC), cómo se modifica y 
que ocurre en el caso de un llamado a una subrutina.
*/

/*


 */


 .data
        N1: .word 21,35,70,60
.text
.global main
main:
        ldr r1,=N1
        ldr r0,[r1]
        add r1,r1,#4


    

end:
        mov r7,#1
        swi 0