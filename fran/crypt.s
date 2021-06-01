.data
    character: .ascii ""
    clave:     .ascii ""
.text

    /*
        Valida si el caracter en r0 es mayuscula, si lo es retorna 1, sino 0 en r0
        @param r0: caracter
        @return r0: 1=True/2=False
     */
    es_mayuscula:
        .fnstart
            push {lr}

            cmp r0, #0x41                                      @Compara r0(caracter) con la letra 'A' en hexadecimal
            movlt r0, #0                                       @retorna False en r0 si es menor a 'A' en hexadecimal
            movlt pc, lr

            cmp r0, #0x5A                                      @Compara r0(caracter) con la letra 'Z' en hexadecimal
            movgt r0, #0                                       @retorna False en r0 si es mayor a 'Z' en hexadecimal 
            movgt pc, lr                                       @Si es mayor a 'Z' en hexadecimal volvemos a la subrutina que llamo la funcion es_mayuscula

            mov r0, #1                                         @Sino la validacion es verdadera y retorna 1 en r0
            
            pop {lr}
            bx lr                                         @Volvemos a la subrutina que llamo la funcion es_mayuscula
        .fnend
    
    /*
        Valida si el caracter en r0 es minuscula, si lo es retorna 1, sino 0 en r0
        @param r0: caracter
        @return r0: 1=True/2=False
    */
    es_minuscula:
        .fnstart
            push {lr}

            cmp r0, #0x61                                        @Compara r0(caracter) con la letra 'a' en hexadecimal
            movlt r0, #0                                         @retorna False en r0 si es menor a 'a' en hexadecimal
            movlt pc, lr

            cmp r0, #0x7A                                        @Compara r0(caracter) con la letra 'z' en hexadecimal
            movgt r0, #0                                         @retorna False en r0 si es mayor a 'z' en hexadecimal 
            movgt pc, lr                                         @Si es mayor a 'z' en hexadecimal volvemos a la subrutina que llamo la funcion es_minuscula

            mov r0, #1                                           @Sino la validacion es verdadera y retorna 1 en r0
            
            pop {lr}
            bx lr                                                @Volvemos a la subrutina que llamo la funcion es_minuscula
        .fnend

    /*
        @param r0: caracter
        @param r1: clave
        @return r0: caracter encriptado
    */
    encriptar_caracter:
        .fnstart
            push {lr}
            
            add r2, r0, r1                                        @Encripto el caracter en base a la clave (caracter + clave) en r0
            
            bl es_mayuscula                                       @Llamo a la funcion es_mayuscula y me aloja en r0 si es mayuscula o no
            
            mov r3, r0                                            @Auxilio r0 en r3
            cmp r3, #1                                            @Comparo r3 == 1 == True
            
            /*                                     ENCRIPTADO DE CARACTER MAYUSCULA                                          */
            cmpeq r2, #0x5A                                       @Compara r2(caracter + clave) con la letra 'Z' en hexadecimal
            bgt convertir_caracter_encriptrado_overflow           @Si hay overflow, lo convierto
            ble return_mensaje_encriptado                         @Sino retorno el caracter encriptado

            /*                                      ENCRIPTADO DE CARACTER MINUSCULA                                          */
            cmp r2, #0x7A                                         @Compara r2(caracter + clave) con la letra 'z' en hexadecimal
            bgt convertir_caracter_encriptrado_overflow           @Si hay overflow, lo convierto
            ble return_mensaje_encriptado                         @Sino retorno el caracter encriptado

            convertir_caracter_encriptrado_overflow:
                sub r2, r2, #26                                   @r2 = r2 - 26
                bl return_mensaje_encriptado                      

            return_mensaje_encriptado:
                mov r0, r2
                pop {lr}
                bx lr             

        .fnend

    /*
        @param r0:  caracter encriptado
        @param r1:  clave
        @return r0: caracter 
    */
    desencriptar_caracter:
        .fnstart
            push {lr}

            sub r2, r0, r1                                         @desencripto el caracter en base a la clave (caracter + clave) en r0            
            
            bl es_mayuscula                                        @Llamo a la funcion es_mayuscula y me aloja en r0 si es mayuscula o no
            
            mov r3, r0                                             @Auxilio r0 en r3
            cmp r3, #1                                             @Comparo r3 == 1 == True

            /*                                   DESENCRIPTADO DE CARACTER MAYUSCULA                                          */
            cmpeq r2, #0x41                                        @Compara r2(caracter - clave) con la letra 'A' en hexadecimal
            blt convertir_caracter_overflow                        @Si hay overflow, lo convierto
            bge return_mensaje_desencriptado                       @Sino retorno el caracter desencriptado


            /*                                     ENCRIPTADO DE CARACTER MINUSCULA                                          */
            cmp r2, #0x61                                          @Compara r2(caracter - clave) con la letra 'a' en hexadecimal
            blt convertir_caracter_overflow                        @Si hay overflow, lo convierto
            bge return_mensaje_desencriptado                       @Sino retorno el caracter desencriptado

            convertir_caracter_overflow:
                add r2, r2, #26                                    @r2 = r2 + 26
                bl return_mensaje_desencriptado                      

            return_mensaje_desencriptado:
                mov r0, r2
                pop {lr}
                bx lr    

        .fnend
.global main
main:

    mov r7, #4         @saldia por pantalla
    mov r0, #1         @salida cadena
    mov r2, #1         @tamaño de la cadena
    ldr r1, =character
    swi 0              @ swi, software interrupt

    mov r7, #4         @saldia por pantalla
    mov r0, #1         @salida cadena
    mov r2, #1         @tamaño de la cadena
    ldr r1, =clave
    swi 0              @ swi, software interrupt


    ldr r0, [character]
    ldr r1, [clave]

    bl encriptar_caracter

    bl desencriptar_caracter

    mov r7, #1
    swi 0


