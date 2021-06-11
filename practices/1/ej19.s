.data
    caracter: .int 0
.text
.global main
    main:
        /*        
            19. Suponiendo que el registro r0 contiene un número entre 0 y 9, efectúe las operaciones
                necesarias para obtener el caracter ASCII que representa el dígito decimal correspondiente a
                dicho valor.
        */

        mov r0, #6

        add r0, r0, #0x30

        ldr r1, =caracter

        str r0, [r1]
            
	end:
		mov r7, #1
		swi 0
