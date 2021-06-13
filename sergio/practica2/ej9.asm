/*
9. Hacer un procedimiento que permita leer texto del teclado de a un caracter, almacenándolo
en un espacio reservado en memoria, hasta apretar la tecla ENTER (ASCII 13) o hasta que
se llene dicho espacio. Devolver en r0 la cantidad de caracteres leídos.
*/


.data
    
    TEXTO: .asciz "      "  //6 espacios

 .text

    @recibe en r1 la direccion de memoria del primer caracter
    @devuelve en r0 la cantidad de caracteres procesados
    procedimiento:
        .fnstart
            mov r0,#0       @limpio el registro r0
            ldr r3,=TEXTO

            ciclo:
            ldrb r4,[r3]
            
            cmp r0,#6
            bxeq lr

            push {r0}
            //ingreso por teclado
            mov r7,#3       @indico que en la interrupcion, se va a leer el teclado
            mov r0,#0       @ingreso una cadena
            mov r2,#1       @cargo la cantidad de caracteres a leer (36)
            mov r1,r3       @cargo la direccion de memoria donde se va a guardar
            swi 0

            pop {r0}
            add r0,#1

            ldrb r4,[r3]
            cmp r4,#10      @si r4 es "enter"
            bxeq lr         @salgo de la funcion

            add r3,#1
            bal ciclo

        .fnend


 .global main
 main:

    ldr r1,=TEXTO

    bl procedimiento

       

 end:
    mov r7,#1
    swi 0