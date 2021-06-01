/*
Pasa de numero en ascii a entero
*/
/*
Pseudocodigo:
letras="12";
entero=0;

for(int i=0;i<letras.length();i++){
    entero=entero*10;
    num=letras[i]-0x30;
    entero=entero+num;
    }
*/

.data

clave_ascii: .ascii "12"
clave_int: .byte 0

.text
.global main

main:
    ldr r0,=clave_ascii
    mov r2,#2

    bl ascii_to_int

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

                PUSH {r0,r3}            @guardo en la pila los valores de r0 y r3 porque necesito usar mas registros
                mov r0,#10              @cargo 10 en r0 porque lo necesito para hacer el mul
                mov r3,r1               @cargo el valor de r1 en r3 para hacer el mult
                mul r1,r3,r0            @corro el numero unlugar hacia adelante (10**n) ej: 2--->20 
                POP {r0,r3}             @retorno los valores de la pila a los registros originales

                ldrb r3,[r0],#1         @cargo el siguiente byte (siguiente numero ascii) del texto en r3 (aux)
                sub r3,#0x30            @convierto a numero int
                add r1,r3               @sumo el numero a la salida ej: 20 + 3

                sub r2,r2,#1            @posiciones que quedan por procesar

                bal while               @vuelvo a ciclar
        .fnend
