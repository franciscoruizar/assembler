.data
    N1: .word 18
    N2: .word 33
    N3: .word 40
.text
.global main
    main:
        ldr r0, =N1
        ldr r1, [r0]

        ldr r0, =N2
        ldr r2, [r0]

        ldr r0, =N3
        ldr r3, [r0]

        mov r0, #00

        add r0, r1, r2
        sub r0, r0, r3      @ a. obtener en r0 el resultado de la operación N1 + N2 - N3.

        ldr r1, =N1
        ldr r4, [r1]

        ldr r2, =N2
        ldr r5, [r2]

        ldr r3, =N3
        ldr r6, [r3]

        str r0, [r1]        @ b. hacer el mismo cálculo, almacenando el resultado en N1.

        
        str r5, [r1]        @ c. intercambiar los valores asignando a N1 el valor de N2, a N2 el de N3 y a N3 el de N1.
        str r6, [r2]
        str r4, [r3]
        
        bal end
            
	end:
		mov r7, #1
		swi 0
