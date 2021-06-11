/* 4. Escriba un programa en assembler para cada uno de los siguientes problemas */

.data
    VECTOR1: .word 10, 10, 10, 10, 10, 10, 10, 10, 10, 10
    VECTOR2: .word 128, 314, 1024, 127, 16000, 65000
.text
    /* @ La etiqueta VECTOR1 define 10 posiciones en memoria. Obtener en r0 la suma de esas 10 posiciones. */
    loop1:
        .fnstart
            push {lr}
            push {r1}
            push {r2}
            push {r3}

            ldr r1, =VECTOR1

            mov r0, #0  @Acumulador
            mov r2, #0  @Iteraciones

            b loop1_loop

            loop1_loop:
                cmp r2, #10
                beq return_loop1

                ldrb r3, [r1]
                add r0, r0, r3

                add r2, r2, #1

                b loop1_loop

            return_loop1:
                pop {r3}
                pop {r2}
                pop {r1}
                pop {lr}

                bx lr

        .fnend

    /* 
        Sumar en r1 los elementos definidos en VECTOR2 con la siguiente directiva 

        Tener en cuenta que cada elemento ocupa cuatro bytes (word)    
    */
    loop2:
        .fnstart
            push {lr}
            push {r0}
            push {r2}
            push {r3}

            ldr r0, =VECTOR2

            mov r1, #0  @Acumulador
            mov r2, #0  @Iteraciones

            loop2_loop:
                cmp r2, #6
                beq return_loop2

                ldr r3, [r0], #4         @Tener en cuenta que cada elemento ocupa cuatro bytes (word) 
                add r1, r1, r3  

                add r2, r2, #1   @Itero

                b loop2_loop

            return_loop2:
                pop {r3}
                pop {r2}
                pop {r0}
                pop {lr}

                bx lr

        .fnend

.global main
    main:
        bl loop1
        bl loop2   
	end:
		mov r7, #1
		swi 0
