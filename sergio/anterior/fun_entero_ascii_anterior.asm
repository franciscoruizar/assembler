/*
Pasa de numero en ascii a entero (hasta el numero 99)
*/
/*
Pseudocodigo:
entero=12;
letras="  ";


for(int i=0;i<letras.length();i++){
    
    ascii=(entero/10)+0x30;
    letra[i]=ascii;
    entero=enero%10;
    }
*/

.data

numero_int: .word 12 //permite hasta el numero 99
numero_ascii: .ascii "        "


.text
.global main

main:
    ldr r1,=numero_int
    ldr r0,[r1]
    ldr r3,=numero_ascii
    mov r2,#2

    bl int_to_ascii

    mov r7,#1
    swi 0

/*
INT A ASCII
Input:
    R0: el valor del numero entero
    r3: la direccion de la "variable" donde se guarda el numero en ascii
Uso:
    
Outputs:
    r1: devuelve el entero
 */


int_to_ascii:
        .fnstart

                mov r2,#10              @cargo en r2 el divisor "10" para separar la decena de la unidad

                PUSH {lr}
                bl division             @llamo a la funcion division
                POP {lr}
                //r1 tiene el resultado (decena)
                //r0 tiene ahora el resto (unidad)
                
                add r0,r0,#0x30         @paso a ascii la unidad (primera posicion)
                add r1,r1,#0x30         @paso a ascii la decena (segunda posicion)

                strb r1,[r3],#1         @cargo el siguiente byte (siguiente letra) del texto en r2
                strb r0,[r3],#1         @cargo el siguiente byte (siguiente letra) del texto en r2
                bx lr                   @salgo de la funcion

        .fnend

/*
    input:
        r0: numerador
        r2: denominador
    output:
        r0: resto
        r1: resultado
 */
division:
        mov r1,#0               @limpio el registro r1 donde guardo el resultado
        .fnstart
            cicla:
        	cmp  r0,r2	        @comparo divisor con dividendo
	        bxlt lr		        @si r0 < r1 entonces sale del ciclo
	        add r1,r1,#1	    @le sumo uno al contador de resultado por cada ciclo
	        sub r0,r0,r2	    @hago la resta r0-r1 y lo pongo en r0
	        bal cicla	        @entra denuevo a la etiqueta cicla
        .fnend