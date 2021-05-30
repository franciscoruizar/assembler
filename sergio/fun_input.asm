/*
Funcion ingreso por teclado
*/
.data

input: .ascii "                                                            "


.text
.global main

main:

    ldr r3,=input     @cargo en r3 la direccion de memoria donde se guarda el input
    mov r4,#60              @cargo la cantidad de caraceteres que debe leerse
    bl ingreso_teclado

    mov r7,#1
    swi 0
/*
INGRESO_TECLADO
Input:
    r3: DIRECCION DE MEMORIA DONDE SE VA A GUARDAR
    r4: cantidad de carateres de la cadena
Outputs:

 */

ingreso_teclado:
    .fnstart
        mov r7,#3       @indico que en la interrupcion, se va a leer el teclado
        mov r0,#0       @ingreso una cadena
        mov r2,r4       @cargo la cantidad de caracteres a leer (36)
        mov r1,r3     @cargo la direccion de memoria donde se va a guardar
        swi 0
        bx lr
    .fnend
