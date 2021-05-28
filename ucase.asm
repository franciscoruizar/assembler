.data
    mensaje: .ascii "Ingresar texto: \n"
    string:  .ascii " "
.text
.global main
	main:
        // Salida por pantalla
        mov r7, #4         @saldia por pantalla
        mov r0, #1         @salida cadena
        mov r2, #35        @tamaño de la cadena
        ldr r1, =mensaje
        swi 0              @ swi, software interrupt

        // Leer por teclado
        mov r7, #3      @lectura por teclado
        mov r0, #0      @ingreso de cadena
        mov r2, #4      @leer cant caracteres
        ldr r1, =string @donde se guarda lo ingresado
        swi 0           @ swi, software interrupt

        bal loop        

        bal end

        print:
            mov r7, #4         @saldia por pantalla
            mov r0, #1         @salida cadena
            mov r2, #35        @tamaño de la cadena
            ldr r1, =string
            swi 0              @ swi, software interrupt

        loop:
            ldrb r4, [r0]
            cmp r4, #0
            beq print
            cmp r4, #122
            subls r4, r4, #32
            cmp r4, #65
            addlt r4, r4, #32
            strb r4, [r0], #1

            bal loop

        end_loop:
            pop {r4}

		end:
			mov r7, #1
			swi 0
