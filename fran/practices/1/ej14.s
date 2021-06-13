.data
    N1:     .word 10
    N2:     .word 11
    N3:     .word 0
.text
.global main
    main:
        /* 
        
            14. Las etiquetas N1, N2 y N3 representan números sin signo. Escriba fragmentos de código assembler para almacenar en N3:
            a. la suma de N1 y N2.
            b. el producto de N1 por N2.
            c. el cociente N1 dividido el valor constante 2 (explorar las operaciones de desplazamiento).
        */

        ldr r1, =N1
        ldr r2, =N2
        ldr r3, =N3

        /* a. la suma de N1 y N2. */

        ldr r4, [r1]
        ldr r5, [r2]
        add r4, r4, r5
        str r4, [r3]

        /*  b. el producto de N1 por N2. */

        ldr r4, [r1]
        ldr r5, [r2]
        mul r4, r4, r5
        str r4, [r3]

        /* c. el cociente N1 dividido el valor constante 2 (explorar las operaciones de desplazamiento). ??????????*/
        ldr r4, [r1]
        mov r5, #2
        mul r4, r4, r5

        bal end
            
	end:
		mov r7, #1
		swi 0
