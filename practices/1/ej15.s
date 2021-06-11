.data
    valores: .word
    length_valores: .word 8
    suma: .word
    promedio: .word
.text
.global main
    main:
        /* 
            Suponiendo que la etiqueta VALORES define una secuencia de cuatro números enteros sin
            signo, escriba las instrucciones necesarias para calcular el promedio (truncado a un número
            entero) de esos cuatro números. Defina una etiqueta PROMEDIO para almacenar el valor
            calculado.
        */

        bal VALORES

    VALORES:
        ldr r0, =valores
        ldr r1, =length_valores
        ldr r1, [r1]
        mov r2, #0

        bal VALORES_loop

    VALORES_loop:
        
        cmp r2, r1
        beq PROMEDIO

        mov r3, #5

        str r3, [r0, r2]
        add r2, r2, #1
        bal VALORES_loop

    PROMEDIO:
        ldr r5, =suma
        mov r2, #0
        mov r4, #0
        bal PROMEDIO_loop

    PROMEDIO_loop:
        cmp r2, r1
        beq division

        ldr r3, [r0, r2]

        add r4, r4, r3

        str r4, [r5]

        add r2, r2, #1
        bal PROMEDIO_loop

    division:
        add r4, r4, #1      // quotient = quotient + 1;
        sub r0, r0, r1      // a = a - b;
        cmp r0, r1          // if (a > b)
        bge division        //  division();
        mov r2, r4          // else result = quotient
        ldr r6, =promedio
        str r2, [r6]
        bal end             // end();
            
	end:
		mov r7, #1
		swi 0
