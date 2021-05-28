.data
    values:   .word 500, 36, -23
    total:    .byte 0
    iterator: .byte 1
.text
.global main
	main:
        ldr r0, =values    @cargo en r0 la direccion de values
		ldr r1, [r0] 	   @cargo en r1  el valor de la direccion de memoria de r0

        ldr r0, =total 	   @cargo en r0 la direccion de total
		ldr r2, [r0] 	   @cargo en r1  el valor de la direccion de memoria de r0

        ldr r0, =iterator  @cargo en r0 la direccion de total
		ldr r3, [r0] 	   @cargo en r1  el valor de la direccion de memoria de r0
        
        bal loop

        loop:
            cmp r3, #3
            beq end

            add r3, r3, #1

            ldrb r4, [r2]
            add r2, r2, r4

            bal end
        
		end:
            mov r7, #4         @saldia por pantalla
            mov r0, #1         @salida cadena
            mov r2, #35        @tamaño de la cadena
            ldr r1, =total
            swi 0              @ swi, software interrupt

			mov r7, #1
			swi 0