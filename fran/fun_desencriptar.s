.data
    mensaje: .asciz "cc cc"
.text
    /*
        @param r0: caracter encriptado
        @param r1: clave
        @return r0: caracter 
    */
    desencriptar_caracter:
        .fnstart
            push {lr}
            push {r1}
            push {r2}

            cmp r0, #0x20
            moveq r2, r0
            beq return_caracter_desencriptado

            sub r2, r0, r1                       @desencripto el caracter en base a la clave (caracter encriptado + clave) en r0

            cmp r0, #0x61
            bge verificar_caracter_encriptado_si_esta_dentro_del_rango_minusculas
            b verificar_caracter_encriptado_si_esta_dentro_del_rango_mayusculas

            verificar_caracter_encriptado_si_esta_dentro_del_rango_minusculas:
                cmp r0, #0x7A
                ble verificar_caracter_desencriptado_overflow_minuscula
                b return_caracter_desencriptado

            verificar_caracter_encriptado_si_esta_dentro_del_rango_mayusculas:
                cmp r0, #0x41
                blt return_caracter_desencriptado
                cmpge r0, #0x5A
                ble verificar_caracter_desencriptado_overflow_mayuscula
                b return_caracter_desencriptado

            verificar_caracter_desencriptado_overflow_minuscula:
                cmp r2, #0x61
                blt convertir_caracter_desencriptado_overflow
                b return_caracter_desencriptado

            verificar_caracter_desencriptado_overflow_mayuscula:
                cmp r2, #0x41
                blt convertir_caracter_desencriptado_overflow
                b return_caracter_desencriptado

            convertir_caracter_desencriptado_overflow:
                add r2, r2, #26                                    @r2 = r2 + 26
                b return_caracter_desencriptado                      

            return_caracter_desencriptado:
                mov r0, r2

                pop {r2}
                pop {r1}
                pop {lr}
                bx lr  

        .fnend

    /*
        @param r0: direccion de memoria del mensaje encriptado
        @param r1: clave

        @return cadena desencriptada
    
    */
    encriptar:
        .fnstart
            push {lr}
            push {r2}
            push {r3}

            mov r2, r0                         @auxilio la direccion de memoria en r2 
            desencriptar_loop:
                ldrb r3, [r2]                  @obtengo el mas signficativo y lo guardo en r3
                
                cmp r3, #0                     
                beq end_desencriptar_loop         @Si r3 == 0, termina la funcion
                
                push {r2}

                mov r0, r3                     @Guardo en r0 el caracter 
                bl desencriptar_caracter           

                pop {r2}
                strb r0, [r2], #1              @cambio en la posicion del bit mas significativo el caracter encriptado al comun

                b desencriptar_loop

            end_desencriptar_loop:
                mov r0, r2

                pop {r3}
                pop {r2}
                pop {lr}
                bx lr 
        .fnend


.global main
main:
    ldr r0, =mensaje
    mov r1, #2

    bl encriptar

    bal end
    
    end:

        mov r7, #1
        swi 0