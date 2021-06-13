.data
    cadena1: .ascii "AAAa"
    cadena2: .ascii "zzz"
    cadena3: .ascii "Hola, soy Jhon Connor, no estás solo"
.text
    /* 
        @param r1: direccion de memoria de la cadena
        @return r0: cantidad de caracteres en mayuscula
    */
    contar_cantidad_de_mayusculas:
        .fnstart
            push {lr}
            push {r2}
            push {r3}
            
            mov r0, #0  @Limpiamos el registro - contador de letras mayusculas
            mov r2, #0  @Limpiamos el registro - Iteraciones
            mov r3, #0  @Limpiamos el registro
            
            b contar_cantidad_de_mayusculas_loop

            contar_cantidad_de_mayusculas_loop:
                ldrb r3, [r1, r2]               @r3 = r0[r2]

                cmp r3, #0                                         @r3 == NULL
                beq return_contar_cantidad_de_mayusculas           @Retornamos

                cmp r3, #0x41                                      @Comparamos r3 con 'A'
                bge validar_si_es_mayuscula                        @r3 >= 'A'


                b iterar_contar_cantidad_de_mayusculas_loop

            validar_si_es_mayuscula:
                cmp r3, #0x5A                                      @Comparamos r3 con 'Z'
                addle r0, r0, #1                                   @Si es r3 <= 'Z', sumamos 1 al contador

                b iterar_contar_cantidad_de_mayusculas_loop

            iterar_contar_cantidad_de_mayusculas_loop:
                add r2, r2, #1
                b contar_cantidad_de_mayusculas_loop

            return_contar_cantidad_de_mayusculas:
                pop {r3}
                pop {r2}
                pop {lr}
                bx lr
        .fnend

.global main
    main:
        ldr r1, =cadena1
        bl contar_cantidad_de_mayusculas

        ldr r1, =cadena2
        bl contar_cantidad_de_mayusculas

        ldr r1, =cadena3
        bl contar_cantidad_de_mayusculas

        bal end
	end:
		mov r7, #1
		swi 0
