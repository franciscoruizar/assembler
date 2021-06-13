.data
    caracter: .asciz "pepe"
.text
.global main
    main:
        /*        
            20. Agregue al ejercicio anterior las instrucciones necesarias para que se muestre en la pantalla el
                dígito contenido en el registro r0.
        */

        mov r0, #5
        add r0, r0, #0x30

        ldr r1, =caracter
        str r0, [r1]

        // Salida por pantalla
        mov r7, #4         @saldia por pantalla
        mov r0, #1         @salida cadena
        mov r2, #35        @tamaño de la cadena
        ldr r1, =caracter
        swi 0              @ swi, software interrupt

        mov r7, #1
        swi 0
