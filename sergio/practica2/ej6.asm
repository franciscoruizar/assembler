/*
6. El cifrado XOR es un método de encriptación que consiste en aplicar a cada caracter de un
texto la operación XOR con una clave fija. Implemetar el método de cifrado con la clave
“U”. Agregar a cada línea comentarios indicando qué es lo que hace, indicar cómo se usa
el procedimiento (dónde recibe sus parámetros) y usarlo para encriptar un mensaje. Notar
que el método es reversible (aplicarlo dos veces produce el mensaje original).
*/

.data
    TEXTO: .asciz "hola mundo\000\n"


 .text
    @ en r0 recibe la direccion en memoria de la primera posicion del texto
    encriptacion:
        .fnstart
            mov r2,#'U'         @cargo en r2 la clave de encriptacion 'U'
            mov r1,#1           @limpio el registro r1 donde voy a guardar el caracter

            ciclo:
            ldrb r1,[r0]        @cargo el primer caracter en r1
            cmp r1,#00          @comparo r1 con el caracter null
            bxeq lr             @si es el null salgo de la funcion

            eor r3,r1,r2        @cargo en r3 el caracter encriptado
            strb r3,[r0]        @cambio el caracter por el encriptado
            add r0,#1           @apunto al siguiente caracter
            bal ciclo

        .fnend



 .global main
 main:
        //imprime_pantalla:
        mov r7,#4           @indico que en la interrupcion, se va a imprimir un mensaje en pantalla
        mov r0,#1           @salida una cadena
        mov r2,#10           @cargo la cantidad de caracteres a leer (1)
        ldr r1,=TEXTO     @cargo la direccion de memoria del mensaje a imprimir
        swi 0

        ldr r0,=TEXTO
        bl encriptacion

        //imprime_pantalla:
        mov r7,#4           @indico que en la interrupcion, se va a imprimir un mensaje en pantalla
        mov r0,#1           @salida una cadena
        mov r2,#10           @cargo la cantidad de caracteres a leer (1)
        ldr r1,=TEXTO     @cargo la direccion de memoria del mensaje a imprimir
        swi 0

        ldr r0,=TEXTO
        bl encriptacion

        //imprime_pantalla:
        mov r7,#4           @indico que en la interrupcion, se va a imprimir un mensaje en pantalla
        mov r0,#1           @salida una cadena
        mov r2,#10           @cargo la cantidad de caracteres a leer (1)
        ldr r1,=TEXTO     @cargo la direccion de memoria del mensaje a imprimir
        swi 0


        bal end
        
 end:
    mov r7,#1
    swi 0