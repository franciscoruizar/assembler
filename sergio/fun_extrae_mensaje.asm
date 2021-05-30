/*
Funcion para extraer mensaje de un input
*/
.data

input: .ascii "hola mundo;chau;"
mensaje: .ascii " "

.text
.global main

main:
    ldr r0,=input       @cargo en r0 la direccion del texto
    ldr r1,=mensaje     @cargo en r1 la direccion del texto nuevo

    bl extrae_mensaje   @llamo a la funcion que extrae el mensaje

    mov r7,#1
    swi 0


