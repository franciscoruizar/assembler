/*
Pasa de numero en ascii a entero
*/


.data

numero_int: .word 125 @permite trabajar hasta 3 cifras (999)
numero_ascii: .ascii "        "


.text
.global main

main:
    ldr r1,=numero_int
    ldr r0,[r1]

    bl int_to_ascii
    ldr r2,=numero_ascii
    str r3,[r2]

    mov r7,#1
    swi 0

/*
INT A ASCII
Input:
    R0: el valor del numero entero
Uso:
    r1: auxiliar para el resto de la division
    r2: euxiliar para separar las decenas
    r3: el registro donde se van cargando los caracteres
Outputs:
    r3: salida registro con los caracteres guardados (3 caracteres+null)
 */


int_to_ascii:
        .fnstart
            mov r2,#10          @cargo en R2 el numero 10 para separa unidades/decenas/centenas
            mov r3,#0           @limpio el registro (null/null/null/null)

            while:
            PUSH {lr}
            bl division         @llamo a la funcion division, devuelve el resto en R0 y el resultado en R1
            POP {lr}

            push {r0}           @intercambio los valores de r1 y r0. R0 tiene el resultado y R1 el resto
            push {r1}
            pop {r0}            
            pop {r1}

            add r1,#0x30        @convierto el resto a ascii
            add r3,r1           @cargo el resto en el registro (null/null/null/"resto")32 bits
            ror r3,r3,#24       @corro 1 byte a la izquierda para hacer lugar al siguiente caracter (null/null/"resto"/null)32 bits
            
            cmp r0,#10          @comparo el resultado con 10
            addlt r0,#0x30      @si es menor a 10, convierto el resto a ascii
            addlt r3,r0         @si es menor a 10 cargo el resto en el registro y salgo ("null"-"null"-"resto"-"resto2")32 bits
            bxlt lr             @si es menor a 10 salgo

            bal while           @vuelvo a ciclar
       

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