/*
Funcion para extraer opcion de un input
*/
.data

input: .ascii "hola mundo;chau;"
opcion: .ascii " "

.text
.global main

main:
    ldr r0,=input       @cargo en r0 la direccion del texto
    ldr r1,=opcion      @cargo en r1 la direccion de la opcion
    mov r3,#0           @limpio el registro
    bl extrae_opcion    @llamo a la funcion que extrae la opcion

    mov r7,#1
    swi 0

/*
EXTRAE_OPCION
Input:
    r0: direccion del texto input original (ya la tiene cargada)
    r1: direccion de la OPCION de salida (ta la tiene cargada)
    r2: de uso para iterar
    r3: contador de ";"
Outputs:
    r0: no modifica
    r1: la modifica agregando el caracter
 */

extrae_opcion:
    .fnstart
        while:
        ldrb r2,[r0],#1     @cargo el siguiente byte (siguiente letra) del texto en r2
        cmp r2,#0x3b        @comparo r2 con el ascii ";"
        addeq r3,#1         @si el caracter es ";" le sumo 1 al contador
        beq while

        cmp r3,#2           @comparo el contador de ; con 2
        beq concateno       @si es igual a 2 concateno caracteres

        bal while           @si no es uno entro al while

        concateno:
        strb r2,[r1],#1     @guardo la letra en la variable
        bxgt lr             @si es mayor que 1 salgo de la funcion

    .fnend
