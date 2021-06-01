/*
Pasa de numero en ascii a entero hasta el numero 99)
*/
/*
Pseudocodigo:
letras="12";
entero=0;

    num=letras[0]-0x30;
    entero=num*10
    num=letras[1]-0x30;
    entero=entero+num;
*/

.data

clave_ascii: .ascii "12" //hasta el numero 99
clave_int: .word 0

.text
.global main

main:
    ldr r0,=clave_ascii
    ldr r3,=clave_int

    bl ascii_to_int

    mov r7,#1
    swi 0

/*
ASCII A INT
Input:
    R0: direccion de memoria donde esta el ascii
    R3: direccion donde se guarda el numero en entero
Uso:
    r2: registro se usa como auxiliar
Outputs:
    r1: devuelve el entero
 */


ascii_to_int:
        .fnstart
                PUSH {r3}
                mov r3,#10              @caro 10 en r3 (auxiliar) para correr a decena
                mov r1,#0               @limpio el registro r1 (numero-output)

                ldrb r2,[r0],#1         @cargo el primer byte (primer numero ascii) en r2 (aux)
                sub r2,#0x30            @convierto a numero int
                mul r1,r2,r3            @cargo la decene en el registro de salida corriendo numero unlugar hacia adelante (10**n) ej: 2--->20 

                ldrb r2,[r0]            @cargo el segundo byte (segundo numero ascii) en r2 (aux)
                sub r2,#0x30            @convierto a numero int
                add r1,r1,r2            @suno la unidad al resultado de salida
                POP {r3}

                str r1,[r3]             @guardo en la direccion de memoria el numero en int
                bxeq lr                 @ssalgo de la funcion
        .fnend
