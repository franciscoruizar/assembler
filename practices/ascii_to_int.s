.data
    mensaje: .asciz "Feliz 9 de julio de 2021!"
.text

    /* 
        @param r0:  direccion de memoria del mensaje
        @return r0: valor de cantidad de numeros del mensaje
    */
    contar_cantidad_de_numeros_en_mensaje:
        .fnstart
            push {lr}
            push {r1}
            push {r2}
            push {r3}

            mov r1, #00 @Limpiamos el registro - Acumulador
            mov r2, #00 @Limpiamos el registro - Iteraciones
            mov r3, #00 @Limpiamos el registro
            
            contar_cantidad_de_numeros_en_mensaje_loop:
                ldrb r3, [r0, r2]                                 @r3 = r0[r2]

                cmp r3, #0                                         @r3 == NULL
                beq return_contar_cantidad_de_numeros_en_mensaje   @Retornamos

                cmp r3, #0x30                                       @r3 >= '0'
                bge validar_si_esta_dentro_del_rango_de_los_numeros

                b iterar_contar_cantidad_de_numeros_en_mensaje_loop @Sino iteramos

            validar_si_esta_dentro_del_rango_de_los_numeros:
                cmp r3, #0x39                                          @r3 <= '9'
                ble acumular_numeros
                
                b iterar_contar_cantidad_de_numeros_en_mensaje_loop    @Iteramos

            acumular_numeros:
                push {r0}
                
                mov r0, r3                                             @r0 = 'numero'

                bl convertir_ascii_a_int

                add r1, r1, r0                                         @r1 = r1 + numero(r0)

                pop {r0}
                b iterar_contar_cantidad_de_numeros_en_mensaje_loop    @Iteramos

            
            iterar_contar_cantidad_de_numeros_en_mensaje_loop:
                add r2, r2, #1
                b contar_cantidad_de_numeros_en_mensaje_loop

            return_contar_cantidad_de_numeros_en_mensaje:
                mov r0, r1

                pop {r3}
                pop {r2}
                pop {r1}
                pop {lr}
                bx lr
        .fnend

    /* 
        @param r0:  valor del caracter
        @return r0: valor del caracter convertido
    */
    convertir_ascii_a_int:
        .fnstart
            push {lr}
            push {r1}

            mov r1, #0x30
            sub r0, r0, r1

            b return_convertir_ascii_a_int

            return_convertir_ascii_a_int:
                pop {r1}
                pop {lr}
                bx lr
        .fnend

.global main
    main:

        ldr r0, =mensaje

        bl contar_cantidad_de_numeros_en_mensaje


        bal end
            
	end:
		mov r7, #1
		swi 0
