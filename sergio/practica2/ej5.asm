/*
5. Suponiendo que la etiqueta TEXTO define una secuencia de caracteres ASCII, escriba
programas que resuelvan los siguientes problemas:
a. calcular en r0 la longitud de dicha secuencia.
b. calcular en r1 la cantidad de letras 'A' que aparecen en el texto.
c. encontrar la posición dentro del texto del primer salto de línea, asumiendo que el
primer caracter está en la posición 0.
d. recorrer el texto reemplazando cada aparición de la letra 'a' por un caracter arroba
(@).
*/


.data
    TEXTO: .asciz "hola mundo\nchau mundo"

 .text
 .global main
 main:
    ldr r2,=TEXTO           @r2 apunta a la doreccion del primer byte del texto (primer caracter)
    mov r0,#0               @limpio el registro r0 donde guardo la longitud de la cadena
    mov r1,#0               @limpio el registro r1 donde guardo la cantidad de 'a'
    mov r4,#0               @guardo la posicion del primer salto de linea
    mov r3,#0               @limpio el registro r3 donde voy a ir cargando los caracteres de la cadena

    ciclo:
        ldrb r3,[r2]        @cargo en r3 el siguietne caracter de la cadena
        cmp r3,#00          @si es null
        beq end             @termino de recorrer
        add r0,#1           @sumo 1 al contador de caracteres

        cmp r3,#'a'         @si es 'a'
        beq es_a            @salto a es_a

        cmp r3,#'A'         @si es 'A'
        beq es_A            @salto a es_A

        cmp r3,#'\n'        @si es salto de linea
        beq es_salto

        add r2,#1           @apunto al siguiente caracter
        bal ciclo

    es_a:
        add r1,#1           @sumo 1 al contador de 'a'
        mov r6,#'@'
        strb r6,[r2]

        add r2,#1           @apunto al siguiente caracter
        bal ciclo
    
    es_A:
        add r1,#1           @sumo 1 al contador de 'a'
        mov r6,#'@'
        strb r6,[r2]

        add r2,#1           @apunto al siguiente caracter
        bal ciclo
    
    es_salto:
        cmp r4,#0
        addeq r4,r0         @sumo 1 al contador de 'a'
        add r2,#1           @apunto al siguiente caracter
        bal ciclo
        
 end:
    mov r7,#1
    swi 0