.data
    mensaje: .ascii "Ingresar texto: \n"
    string:  .ascii " "
.text
.global main
	main:
        bal print_mensaje
        bal scan
        bal print_string

        bal loop        

        bal end

        scan:
            mov r7, #3      @lectura por teclado
            mov r0, #0      @ingreso de cadena
            mov r2, #4      @leer cant caracteres
            ldr r0, =string @donde se guarda lo ingresado
            swi 0           @ swi, software interrupt

        print_mensaje:
            mov r7, #4         @saldia por pantalla
            mov r0, #1         @salida cadena
            mov r2, #35        @tamaño de la cadena
            ldr r1, =mensaje
            swi 0              @ swi, software interrupt

        print_string:
            mov r7, #4         @saldia por pantalla
            mov r0, #1         @salida cadena
            mov r2, #35        @tamaño de la cadena
            ldr r1, =r4
            swi 0              @ swi, software interrupt

        loop:
            ldrb r4, [r0]
            cmp r4, #0
            beq print_string
            cmp r4, #122
            subls r4, r4, #32
            cmp r4, #65
            addlt r4, r4, #32
            strb r4, [r0], #1

            bal loop

		end:
			mov r7, #1
			swi 0
