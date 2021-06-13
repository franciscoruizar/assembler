.data
.text
.global main
    main:
        /*
            16. Escriba un código assembler para obtener en r0 la cantidad de unos de la representación binaria
            del número contenido en r1 aplicando las operaciones de shift.
        */
        mov r0, #0         @Acumulador resultado
        mov r1, #0x07A     @00000000 00000000 00000000 01111010  en binario
        mov r2, #1         @Iteraciones
        bal loop

    loop:
        
        cmp r2, #31                     @iteraciones == 31
        beq end                         @   end()

        ror r3, r1, r2                  @Desplaza hacia la derecha, los bits contenidos en el registro en base a las iteraciones (r2)

        ands r5, r3, #0x80000000        @r3 and 10000000 00000000 00000000 00000000
        cmp r5, #0                      @ SI es distinto cero
        addne r0, r0, #1                @ Acumulo

        add r2, r2, #1                  @Itero
        bal loop
        
            
	end:
		mov r7, #1
		swi 0
