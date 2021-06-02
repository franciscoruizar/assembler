/*
Pasa de numero en ascii a entero
*/


.data

clave_ascii: .ascii "125\000    " // "\000" es el caracter null 0x00 en ascii hexa
clave_int: .byte 0

.text
.global main

main:
    ldr r0,=clave_ascii         @cargo en r0 la direccion de memoria del input
    mov r2,#8                   @cantidad de caracteres que tiene la variable

    bl ascii_to_int             @llamo a la funcion ascii a int
    
    ldr r0,=clave_int           @cargo la direccion de memoria donde se guarda la clave en int
    strb r1,[r0]                @guardo la clava que esta en r1, en la direccion de memoria

    mov r7,#1
    swi 0

/*
ASCII A INT
Input:
    R0: direccion de memoria donde esta el ascii
    r2: cantidad de letras
Uso:
    r3: registro se usa como auxiliar
Outputs:
    r1: devuelve el entero
 */


ascii_to_int:
        .fnstart
                mov r3,#0               @limpio el registro r3 (auxiliar)
                mov r1,#0               @limpio el registro r1 (numero-output)

            while:
                cmp r2,#0               @comparo las posiciones que quedan por procesar con 0
                bxeq lr                 @si no quedan letras por procesar salgo de la funcion

                ldrb r3,[r0],#1         @cargo el siguiente byte (siguiente numero ascii) del texto en r3 (aux)
                cmp r3,#0x00            @comparo el caracter con el caracter null
                bxeq lr                 @si es el caracter null, salgo de la funcion

                PUSH {r0,r3}            @guardo en la pila los valores de r0 y r3 porque necesito usar mas registros
                mov r0,#10              @cargo 10 en r0 porque lo necesito para hacer el mul
                mov r3,r1               @cargo el valor de r1 en r3 para hacer el mult
                mul r1,r3,r0            @corro el numero unlugar hacia adelante (10**n) ej: 2--->20 
                POP {r0,r3}             @retorno los valores de la pila a los registros originales

                sub r3,#0x30            @convierto a numero int
                add r1,r3               @sumo el numero a la salida ej: 20 + 3

                sub r2,r2,#1            @posiciones que quedan por procesar

                bal while               @vuelvo a ciclar
        .fnend
