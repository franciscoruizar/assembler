/*
19. Suponiendo que el registro r0 contiene un número entre 0 y 9, efectúe las operaciones
necesarias para obtener el caracter ASCII que representa el dígito decimal correspondiente a
dicho valor.
*/

.data
    MENSAJE: .ascii " \n"
 .text
 .global main
 main:
    mov r0,#7
    add r0,r0,#0x30
    ldr r3,=MENSAJE
    strb r0,[r3]

    imprime_pantalla:
        mov r7,#4       @indico que en la interrupcion, se va a imprimir un mensaje en pantalla
        mov r0,#1       @salida una cadena
        mov r2,#1       @cargo la cantidad de caracteres a leer (1)
        ldr r1,=MENSAJE     @cargo la direccion de memoria del mensaje a imprimir
        swi 0


 end:
    mov r7,#1
    swi 0