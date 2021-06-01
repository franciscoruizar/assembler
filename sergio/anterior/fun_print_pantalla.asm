/*
Funcion ara imprimir por pantalla
*/
.data

indicacion: .ascii "introducir el mensaje;clave;opcion\n"


.text
.global main

main:

    ldr r3,=indicacion     @cargo en r3 la direccion de memoria del mensaje a imprimir
    mov r4,#36              @cargo la cantidad de caraceteres que debe leerse
    bl imprime_pantalla

    mov r7,#1
    swi 0
/*
IMPRIME EN PANTALLA
Input:
    r3: DIRECCION DE MEMORIA DE LA CADENA
    r4: cantidad de carateres de la cadena
Outputs:

 */

imprime_pantalla:
    .fnstart
        mov r7,#4       @indico que en la interrupcion, se va a imprimir un mensaje en pantalla
        mov r0,#1       @salida una cadena
        mov r2,r4       @cargo la cantidad de caracteres a leer (36)
        ldr r1,r3     @cargo la direccion de memoria del mensaje a imprimir
        swi 0
        bx lr
    .fnend
