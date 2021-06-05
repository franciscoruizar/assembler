.data
    mensaje_encriptado: .asciz "cc cc"
    palabra_ayuda: .asciz "aa"
    palabra_encriptada_actual: .skip 255
    test: .asciz "jxyj"
.text

    /*
        @param r0: direccion de memoria de palabra_ayuda

        @return r0: length
    */
    length:
        .fnstart
            push {lr}
            push {r1}
            push {r2}

            mov r1, #0                                                        @Limpiamos registro - Iteraciones
            mov r2, #0                                                        @Limpiamos registro - Utilizamos r2 como registro para asignar el bit mas significativo de la palabra
            length_loop:
                ldrb r2, [r0,r1]

                cmp r2, #00                                                   @Compara el bit mas significativo con nulo
                beq end_length_loop                                           @ r2 == null, termino el ciclo

                add r1, r1, #1                                              @Sino incremento e iteramos
                b length_loop

            end_length_loop:
                mov r0, r1
                b return_length

            return_length:
                pop {r2}
                pop {r1}
                pop {lr}
                bx lr
        .fnend

    /*
        @param r0: direccion de memoria mensaje_encriptado
        @param r1: direccion de memoria ayuda
        
        @return r0: clave
    */
    obtener_clave_con_ayuda:
        .fnstart
            push {lr}
            push {r1}
            push {r2}
            push {r3}
            push {r4}
            push {r5}
            push {r6}
            push {r7}
            push {r8}
            push {r9}
            
            ldr r2, =palabra_encriptada_actual                                  @Asignamos direccion de memoria de palabra_encriptada_actual
            mov r3, #0                                                          @Limpiamos registro - length de palabra_ayuda
            mov r4, #0                                                          @Limpiamos registro - Iteraciones
            mov r5, #0                                                          @Limpiamos registro - Utilizamos r5 como registro para asignar el bit mas significativo de mensaje_encriptado
            mov r6, #0                                                          @Limpiamos registro - contador para length de la palabra_encriptada_actual
            mov r7, #0                                                          @Limpiamos registro
            mov r8, #0                                                          @Limpiamos registro
            mov r9, #0                                                          @Limpiamos registro

            obtener_length_palabra_ayuda:
                mov r8, r0                                                      @Auxilio en r8 la direccion de memoria de mensaje_encriptado
                mov r0, r1                                                      @Movemos r1(palabra_ayuda) a r0(ya que es un parametro de length()) 

                bl  length                                                      @Obtenemos length de palabra_ayuda

                mov r3, r0                                                      @Guardamos el retorno(length palabra_ayuda) en r3
                mov r0, r8                                                      @Asignamos el auxilio a su registro base
                mov r8, #0                                                      @Limpiamos registro
            
            obtener_clave_con_ayuda_loop:
                ldrb r5, [r0, r4]                                               @Asignamos en r5 el bit mas significativo de r0(mensaje_encriptado)
                
                cmp r5, #0x20                                                   @Comparamos r5 con ' '
                beq verificar_length_palabra_actual_con_clave                   @Si es ' ', verificaciones si palabra_encriptada_actual.length == palabra_ayuda.length                                 
                bne concatenar_obtener_clave_con_ayuda                          @Sino, concatenamos

            verificar_length_palabra_actual_con_clave:
                cmp r3, r6                                                      @palabra_encriptada_actual.length y palabra_ayuda.length
                
                beq verificar_cantidad_posiciones
                bne reiniciar_palabra_encriptada_actual
            
            verificar_cantidad_posiciones:
                mov r7, r0                                                      @Auxilio r0(direccion de memoria mensaje_encriptado) en r7
                mov r8, r1                                                      @Auxilio r1(direccion de memoria ayuda) en r8
                mov r9, r2                                                      @Auxilio r1(direccion de palabra_encriptada_actual) en r9

                bl obtener_cantidad_de_posiciones

                cmp   r0, #1                                                    @Comparamos el resultado de la obtencion de cantidad de caracteres

                movne r0, r7                                                    @Si no es True (1), reinicio
                movne r1, r8
                movne r2, r9
                bne   reiniciar_palabra_encriptada_actual

                moveq r0, r1                                                    @Si es True(1), retorno la clave obtenida almacenada en r2
                beq   return_obtener_clave_con_ayuda 

            reiniciar_palabra_encriptada_actual:
                mov r5, #0                                                      @Asigno nulo a r5
                str r5, [r2]                                                    @palabra_encriptada_actual = ""
                add r4, r4, #1                                                  @Sumamos a las iteraciones
                mov r6, #0                                                      @Limpiamos el contado con el length de la palabra_encriptada_actual
                b obtener_clave_con_ayuda_loop                                  @Volvemos a iterar

            concatenar_obtener_clave_con_ayuda:
                strb r5, [r2, r6]                                               @Concatenamos el bit mas significativo en r2(palabra_encriptada_actual)
                add r4, r4, #1                                                  @Sumamos a las iteraciones
                add r6, r6, #1                                                  @Sumamos 1 al length de la palabra_encriptada_actual
                b obtener_clave_con_ayuda_loop                                  @Volvemos a iterar

            return_null_obtener_clave_con_ayuda:
                mov r0, #0
                b return_obtener_clave_con_ayuda

            return_obtener_clave_con_ayuda:
                pop {r9}
                pop {r8}
                pop {r7}
                pop {r6}
                pop {r5}
                pop {r4}
                pop {r3}
                pop {r2}
                pop {r1}
                pop {lr}
                bx lr
        .fnend

    /* 
        Si se puede obtener la cantidad de posiciones entre la palabra ayuda y la palabra encripta, retorna en r0: 1 y r1:cantidad_posiciones, sino r0: 0

        @param r1: direccion de memoria de la palabra ayuda
        @param r2: direccion de memoria de la palabra encriptada

        @return r0: 1=True/0=False
        @return r1: cantidad_posiciones
    */
    obtener_cantidad_de_posiciones:
        .fnstart
            push {lr}
            push {r3}
            push {r4}
            push {r5}
            push {r6}
            push {r7}

            mov r0, #0                                                          @Limpiamos registro
            mov r3, #0                                                          @Limpiamos registro - cantidad_posiciones_anterior
            mov r4, #0                                                          @Limpiamos registro - Iteraciones
            mov r5, #0                                                          @Limpiamos registro
            mov r6, #0                                                          @Limpiamos registro
            mov r7, #0                                                          @Limpiamos registro

            obtener_cantidad_de_posiciones_loop:
                ldrb r5, [r1, r4]                                               @Cargo en r5 el bit mas significante de r1(palabra ayuda)
                ldrb r6, [r2, r4]                                               @Cargo en r6 el bit mas significante de r2(palabra encriptada)

                cmp r5, #00
                beq return_true_obtener_cantidad_de_posiciones_loop             @Si llegamos al final de la cadena de las palabra, terminamos el loop y retornamos falso

                sub r7, r6, r5                                                  @cantidad_posiciones = caracter_palabra_encriptada - caracter_palabra_ayuda

                cmp   r4, #0                                                    @Comparamos si es la primera iteracion
                moveq r3, r7                                                    @si es la primera iteracion, cantidad_posiciones_anterior = cantidad_posiciones
                addeq r4, r4, #1                                                @Iteramos...
                beq   obtener_cantidad_de_posiciones_loop

                cmpne r3, r7
                addeq r4, r4, #1                                                @Si cantidad_posiciones_anterior == cantidad_posiciones, iteramos...
                beq   obtener_cantidad_de_posiciones_loop

                bne return_false_obtener_cantidad_de_posiciones_loop            @Sino finalizamos el loop y retonarmos false

            return_true_obtener_cantidad_de_posiciones_loop:
                mov r0, #1
                mov r1, r3
                b return_obtener_cantidad_de_posiciones_loop
            
            return_false_obtener_cantidad_de_posiciones_loop:
                mov r0, #0
                b return_obtener_cantidad_de_posiciones_loop

            return_obtener_cantidad_de_posiciones_loop:
                pop {r7}
                pop {r6}
                pop {r5}
                pop {r4}
                pop {r3}
                pop {lr}
                bx lr
        .fnend
.global main
main:
    ldr r0, =mensaje_encriptado
    ldr r1, =palabra_ayuda

    bl obtener_clave_con_ayuda

    bal end
    
    end:
        mov r7, #1
        swi 0