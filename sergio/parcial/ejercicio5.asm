/*
Procedimientos, Interrupciones, Saltos e Instrucciones de Pila (30 puntos)

b. (25 puntos) Escriba un programa en lenguaje ensamblador que recorra una cadena ascii y 
sume en el registro r0 la cantidad de letras mayúsculas encontradas. 
Por ejemplo, si la cadena es: “Hola, soy Jhon Connor, no estás solo” en el 
registro r0 debe quedar el valor 3. Escribir su programa en forma de subrutina y 
aplicarla a tres cadenas diferentes en el main.

 */

 .data
    TEXTO1: .asciz "Hola, soy Jhon Connor, no estás solo"
    TEXTO2: .asciz "Hola MunDo, ChaU Mundo"
    TEXTO3: .asciz "Esta CadeNa es Diferente"

 .text
@recibe en r1 la direccion de memoria del primer caracter
@devuelve en r0 la cantidad de letras minusculas

contador_minusculas:
        .fnstart
                mov r0,#0           @limpio el registro r0
                ciclo:
                ldrb r2,[r1]        @cargo en r3 el siguietne caracter de la cadena
                cmp r2,#00          @si es null
                bxeq lr             @si es null salgo de la funcion

                cmp r2,#'Z'
                bgt noMayuscula

                cmp r2,#'A'
                blt noMayuscula
                
                bal Mayuscula
            

            noMayuscula:
                add r1,#1           @apunto al siguiente caracter
                bal ciclo

            Mayuscula:
                add r0,#1           @sumo 1 al contador de mayusculas
                add r1,#1           @apunto al siguiente caracter
                bal ciclo

        .fnend




 .global main
 main:
        ldr r1,=TEXTO1
        bl contador_minusculas

        ldr r1,=TEXTO2
        bl contador_minusculas

        ldr r1,=TEXTO3
        bl contador_minusculas


        
 end:
    mov r7,#1
    swi 0