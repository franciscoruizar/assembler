.data
    mensaje: .asciz "aa aa"
.text
    /*
        @param r0:   caracter
        @param r1:   clave
        @return r0:  caracter encriptado
    */
    encriptar_caracter:
        .fnstart
            push {lr}
            push {r1}
            push {r2}

            cmp r0, #0x20
            moveq r2, r0
            beq return_caracter_encriptado

            add r2, r0, r1                                        @Encripto el caracter en base a la clave (caracter + clave) en r0

            cmp r0, #0x61                                         @Compara r0(caracter) con la letra 'a' en hexadecimal
            bge verificar_caracter_si_esta_dentro_del_rango_minusculas
            b verificar_caracter_si_esta_dentro_del_rango_mayusculas

            verificar_caracter_si_esta_dentro_del_rango_mayusculas:
                cmp r0, #0x41                                     @Compara r0(caracter) con la letra 'A' en hexadecimal
                bge verificar_caracter_overflow_mayuscula
                b return_caracter_encriptado

            verificar_caracter_overflow_mayuscula:
                cmp r2, #0x5A                                     @Verifica si hay overflow -> r2 > Z
                bgt convertir_caracter_encriptado_overflow        @Si el caracter encriptado esta overflow, lo convierte
                ble return_caracter_encriptado                    @Si el caracter encriptado(r2) esta dentro del rango del abecedario en minuscula, lo retorno

            verificar_caracter_si_esta_dentro_del_rango_minusculas:
                cmp r0, #0x7A                                     @Compara r0(caracter) con la letra 'z' en hexadecimal
                ble verificar_caracter_overflow_minuscula
                b return_caracter_encriptado
                
            verificar_caracter_overflow_minuscula:
                cmp r2, #0x7A                                     @Verifica si hay overflow -> r2 > z
                bgt convertir_caracter_encriptado_overflow        @Si el caracter encriptado esta overflow, lo convierte
                ble return_caracter_encriptado                    @Si el caracter encriptado(r2) esta dentro del rango del abecedario en minuscula, lo retorno

            convertir_caracter_encriptado_overflow:
                sub r2, r2, #26                                   @r2 = r2 - 26
                b return_caracter_encriptado                      

            return_caracter_encriptado:
                mov r0, r2
                pop {r2}
                pop {r1}
                pop {lr}
                bx lr             

        .fnend


    /*
        @param r0: direccion de memoria del mensaje
        @param r1: clave

        @return cadena encriptada
    
    */
    encriptar:
        .fnstart
            push {lr}
            mov r2, r0                         @auxilio la direccion de memoria en r2 
            encriptar_loop:
                ldrb r3, [r2]                  @obtengo el mas signficativo y lo guardo en r3
                
                cmp r3, #0                     
                beq end_encriptar_loop         @Si r3 == 0, termina la funcion
                
                push {r2}

                mov r0, r3                     @Guardo en r0 el caracter 
                bl encriptar_caracter           

                pop {r2}
                strb r0, [r2], #1              @cambio en la posicion del bit mas significativo el caracter comun al encriptado 

                b encriptar_loop

            end_encriptar_loop:
                mov r0, r2
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