/* 3. Escriba un fragmento de código assembler que usando registros r0 y r1: */

.data
    dato0: .int 2147483647
    dato1: .int 1

    dato2: .int -2147483647
    dato3: .int 1
.text
.global main
    main:
        ldr r0, =dato0
        ldr r0, [r0]

        ldr r1, =dato1
        ldr r1, [r1]

        add r0, r0, r1  @ a. sume dos valores positivos tal que se produzca un overflow

        ldr r2, =dato2
        ldr r2, [r2]

        ldr r3, =dato3
        ldr r3, [r3]

        sub r2, r2, r3  @ b. sume dos valores negativos tal que se produzca un overflow

        adds r4, r0, r1  @ c. agregar un salto condicional para detectar el overflow y almacenar en el registro r2 si hubo o no overflow.
        bvs salto

        mov r4, #00

        subs r4, r2, r3
        bvs salto

        bal end

    salto:                           
        mov r2,r5
        bal end
    
	end:
		mov r7, #1
		swi 0