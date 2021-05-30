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

/*
EXTRAE_MENSAJE
Input:
    r0: direccion del texto input original (ya la tiene cargada)
    r1: direccion del mensaje de salida (ta la tiene cargada)
    r2: de uso para iterar
    r3: no usa
Outputs:
    r0: no modifica
    r1: modifica la variable en la funcion agregando el mensaje caracter por caracter
 */

extrae_mensaje:
    .fnstart
        while:
        ldrb r2,[r0],#1     @cargo el siguiente byte (siguiente letra) del texto en r2
        cmp r2,#0x3b        @comparo r2 con el ascii ";"
        bxeq lr             @si la letra es ";" sale de la funcion a la posicion donde apunta lr (continua el flujo)

        strb r2,[r1],#1     @guardo la siguiente letra a continuacion de la anterior
        bal while           @vuelvo a ciclar

    .fnend
