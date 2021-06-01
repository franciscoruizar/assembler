/*
Funcion para extraer clave de un input
*/
.data

input: .ascii "hola mundo;chau;d"
clave: .ascii " "

.text
.global main

main:
    ldr r0,=input       @cargo en r0 la direccion del texto
    ldr r1,=clave       @cargo en r1 la direccion del texto clave
    mov r3,#0           @limpio el registro
    bl extrae_clave     @llamo a la funcion que extrae el clave

    mov r7,#1
    swi 0

/*
EXTRAE_CLAVE
Input:
    r0: direccion del texto input original (ya la tiene cargada)
    r1: direccion de la clave de salida (ta la tiene cargada)
    r2: de uso para iterar
    r3: contador de ";"
Outputs:
    r0: no modifica
    r1: modifica la variable en la funcion agregando la clave caracter por caracter
 */

extrae_clave:
    .fnstart
        while:
        ldrb r2,[r0],#1     @cargo el siguiente byte (siguiente letra) del texto en r2
        cmp r2,#0x3b        @comparo r2 con el ascii ";"
        addeq r3,#1         @si el caracter es ";" le sumo 1 al contador
        beq while

        cmp r3,#1           @comparo el contador de ; con 1
        beq concateno       @si es igual a 1 concateno caracteres
        bxgt lr             @si es mayor que 1 salgo de la funcion

        bal while           @si no es uno entro al while

        concateno:
        strb r2,[r1],#1     @guardo la siguiente letra a continuacion de la anterior
        bal while           @vuelvo a ciclar

    .fnend
