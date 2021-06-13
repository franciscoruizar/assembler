.data
    cadena_input_usuario: .ascii "                                                                                                                                                                                                                                                               "
    mensaje: .ascii "                                                                                                                                                                                                                                                               "
    clave: .ascii "                                                                                                                                                                                                                                                               "
    clave_int: .word 0
    opcion: .ascii "                                                                                                                                                                                                                                                               "
    caracteres_procesados: .skip 255
    palabra_encriptada_actual: .skip 255
    mensaje_error: .asciz "No se pudo obtener la clave"
    mensaje_usuario_clave: .asciz "La clave de desplazamiento es: "
    mensaje_usuario_caracteres_procesados: .asciz "La cantidad de caracteres procesados fueron: "
    mensaje_clave: .skip 255
    mensaje_usuario_input: .asciz "Ingrese la entrada a encriptar en formato {mensaje a enciptar/desencriptar};{clave ó palabra ayuda};{opcion c(encriptar) - d(desencriptar) - b(descriptar con palabra ayuda)}: "
    mensaje_usuario_output: .asciz "El mensaje devuelto es: "
    salto_linea: .asciz "\n"
.text

    /*
        Imprime por consola el valor de r3  

        @param r2 length del output
        @param r3 direccion de la cadena a imprimir

        @return: void
    */
    print:
        .fnstart
            push {lr}               
            push {r7}                @Auxilio registro de uso
            push {r0}                @Auxilio registro de uso
            push {r1}                @Auxilio registro de uso

            mov r0, r3
            bl length
            mov r2, r0
            
            mov r7, #4               @salida por pantalla
            mov r0, #1               @salida cadena
            mov r1, r3               @copiamos a r1 la direccion de memoria de r3 y hara el output
            swi 0                    @swi, software interrupt
            
            mov r2, #1
            mov r7, #4               
            mov r0, #1
            ldr r1, =salto_linea               
            swi 0                    

            pop {r1}                 @Auxilio registro de uso
            pop {r0}                 @Auxilio registro de uso
            pop {r7}                 @Auxilio registro de uso
            pop {lr}

            bx lr
        .fnend

    
    /*
        Lee la entrada por consola 200 caracteres

        Return
        r1: direccion de memoria de la entrada del usuario
    */

    input_usuario:
        .fnstart
            push {lr}
            push {r7}                       @Auxilio registro de uso
            push {r0}                       @Auxilio registro de uso
            push {r2}                       @Auxilio registro de uso

            mov r7, #3				        @Entrada por teclado
            mov r0, #0				        @Entrada de cadena
            mov r2, #200			        @Longitud de 200
            ldr r1, =cadena_input_usuario	@r1 <- se guarda direccion de memoria de la entrada del usuario
            swi 0

            pop {r2}                        @Auxilio registro de uso
            pop {r0}                        @Auxilio registro de uso
            pop {r7}                        @Auxilio registro de uso
            pop {lr}
            bx lr
        .fnend
    
    /*
        Parametros
        r1 <- direccion de memoria de la entrada del usuario
        r3 <- direccion de memoria de donde se va a guardar el mensaje

        Return
        r1 <- direccion de memoria de la ultima posicion del mensaje
    */
    extraermensaje:
        .fnstart
            push {lr}                                   @Auxilio registro de uso
            push {r0}                                   @Auxilio registro de uso
            
            loopmensaje:
                ldrb r0,[r1],#1		                    @ cargo en r0 un caracter de la entrada del usuario y preparo para el siguiente caracter
                cmp r0,#';'		                        @ comparo con ';'

                bleq agregarnulo	                    @Agrega el caracter nulo si la cadena termina con ';'
                beq return_extraermensaje				@ Si el caracter en r0 es igual a ';' salgo de la funcion
                
                strb r0,[r3],#1		                    @ guardo en la direccion de memoria de r3 el caracter de r0
                bal loopmensaje		                    @ vuelvo a iterar
            
            return_extraermensaje:
                pop {r0}
                pop {lr}
                bx lr
        .fnend

    /*

        Parametros

        r1 <- direccion de memoria de stringentrada
        r3 <- direccion de memoria de clave

        Output
        r1 <- direccion de memoria de la ultima posicion de clave

    */
    
    extraerclave:
        .fnstart
            push {lr}
            push {r0}                                 @Auxilio registro de uso

            mov r0, #0                                @Limpio registro

            loopclave:
                ldrb r0, [r1],#1		                  @cargo en r0 un caracter de la entrada del usuario y preparo para el siguiente caracter
                cmp  r0, #';'		                      @ comparo con ';'

                bleq agregarnulo	                      @Agrega el caracter nulo si la cadena termina con ';'
                beq  return_extraerclave				  @ Si el caracter en r0 es igual a ';' salgo de la funcion
                
                strb r0,[r3],#1		                      @ guardo en la direccion de memoria de r3 el caracter de r0
                bal  loopclave		                      @ vuelvo a iterar

            return_extraerclave:
                pop {r0}
                pop {lr}
                bx lr
        .fnend

    /* ----------------------- extraeropcion -------------------------------

        Parametros

        r1 <- direccion de memoria de stringentrada
        r3 <- direccion de memoria de opcion

        Output
        r1 <- direccion de memoria de la ultima posicion de clave

    */
    extraeropcion:
        .fnstart
            push {lr}
            push {r0}                                 @Auxilio registro de uso

            mov r0, #0                                @Limpio registro
            loopopcion:
                ldrb r0,[r1],#1		                  @cargo en r0 un caracter de la entrada del usuario y preparo para el siguiente caracter
                cmp r0, #';'		                  @ comparo con ';'

                bleq agregarnulo	                  @Agrega el caracter nulo si la cadena termina con ';'
                beq return_extraeropcion			  @ Si el caracter en r0 es igual a ';' salgo de la funcion
                
                strb r0,[r3],#1		                  @ guardo en la direccion de memoria de r3 el caracter de r0
                bal loopopcion		                  @ vuelvo a iterar

            return_extraeropcion:
                pop {r0}
                pop {lr}
                bx lr
        .fnend

    /*
        Agrega el caracter nulo en la direccion de memoria pasada en r3

        Parametros
        r3 <- direccion de memoria donde se ingresara el caracter nulo

    */
    agregarnulo:
		.fnstart
            push {lr}
            push {r0}

			mov  r0, #0		@caracter null
			strb r0, [r3]

            pop {r0}
            pop {lr}
			bx lr
		.fnend

    /*
        ASCII A INT
        Input:
            R0: direccion de memoria donde esta el ascii
            R1: direccion de memoria donde se guardara el entero
        Uso:
            r2: registro se usa como auxiliar
            r3: registro se usa como auxiliar
    */
    ascii_to_int:
        .fnstart
            push {lr}
            push {r2}
            push {r3}
            
            
            mov r2, #0                                    @limpio el registro r2 (numero-output)
            mov r3, #0                                    @limpio el registro r3 (auxiliar)

            ascii_to_int_loop:
                ldrb r3,[r0], #1                          @cargo el siguiente byte (siguiente numero ascii) del texto en r3 (aux)
                cmp  r3, #0x00                            @comparo el caracter con el caracter null
                beq  return_ascii_to_int                  @si es el caracter null, salgo de la funcion

                push {r0,r3}                              @guardo en la pila los valores de r0 y r3 porque necesito usar mas registros
                mov r0, #10                               @cargo 10 en r0 porque lo necesito para hacer el mul
                mov r3, r2                                @cargo el valor de r2 en r3 para hacer el mult
                mul r2, r3, r0                            @corro el numero unlugar hacia adelante (10**n) ej: 2--->20 
                pop {r0,r3}                               @retorno los valores de la pila a los registros originales

                sub r3, #0x30                            @convierto a numero int
                add r2, r3                               @sumo el numero a la salida ej: 20 + 3

                bal ascii_to_int_loop                   @vuelvo a ciclar

            return_ascii_to_int:
                str r2, [r1]            

                pop {r2}
                pop {r3}
                pop {lr}
                bx lr
        .fnend

    /*
    INT A ASCII
    Input:
        R0: el valor del numero entero
    Uso:
        r1: auxiliar para el resto de la division
        r2: euxiliar para separar las decenas
        r3: el registro donde se van cargando los caracteres
    Outputs:
        r3: salida registro con los caracteres guardados (3 caracteres+null)
    */


    int_to_ascii:
        .fnstart
            mov r2,#10          @cargo en R2 el numero 10 para separa unidades/decenas/centenas
            mov r3,#0           @limpio el registro (null/null/null/null)

            int_to_ascii_loop:
                PUSH {lr}
                bl division         @llamo a la funcion division, devuelve el resto en R0 y el resultado en R1
                POP {lr}

                push {r0}           @intercambio los valores de r1 y r0. R0 tiene el resultado y R1 el resto
                push {r1}
                pop {r0}
                pop {r1}

                add r1,#0x30        @convierto el resto a ascii
                add r3,r1           @cargo el resto en el registro (null/null/null/"resto")32 bits
                ror r3,r3,#24       @corro 1 byte a la izquierda para hacer lugar al siguiente caracter (null/null/"resto"/null)32 bits
                
                cmp r0,#10          @comparo el resultado con 10
                addlt r0,#0x30      @si es menor a 10, convierto el resto a ascii
                addlt r3,r0         @si es menor a 10 cargo el resto en el registro y salgo ("null"-"null"-"resto"-"resto2")32 bits
                bxlt lr             @si es menor a 10 salgo

                b int_to_ascii_loop           @vuelvo a ciclar
        

        .fnend

        /*
            input:
                r0: numerador
                r2: denominador
            output:
                r0: resto
                r1: resultado
        */
        division:
            .fnstart

                mov r1,#0               @limpio el registro r1 donde guardo el resultado
                division_loop:
                    cmp  r0,r2	        @comparo divisor con dividendo
                    bxlt lr		        @si r0 < r1 entonces sale del ciclo
                    add r1,r1,#1	    @le sumo uno al contador de resultado por cada ciclo
                    sub r0,r0,r2	    @hago la resta r0-r1 y lo pongo en r0
                    b division_loop     @entra denuevo a la etiqueta cicla

            .fnend

    /* 
        Parsea y extrar las partes del input del usaurio

        cadena_input_usuario={mensaje};{clave};{opcion};

        mensaje={mensaje}
        clave={clave}
        opcion={opcion}
    */
    parsear_input_usuario:
        .fnstart
            push {lr}
            push {r1}
            push {r3}

            /*Cargo parametros a la funcion extraermensaje*/
            ldr r1,=cadena_input_usuario
            ldr r3,=mensaje
            bl  extraermensaje 	@Se extrae el mensaje del usuario del input
            
            /*Cargo parametros a la funcion extraerclave*/
            ldr r3,=clave
            bl extraerclave		@Se extrae la clave del usuario del input
            
            /*Cargo parametros a la funcion extraeropcion*/
            ldr r3,=opcion
            bl extraeropcion

            /*Pasamos la clave de ascii a entero y la alojamos en clave_int*/
            ldr r0, =clave
            ldr r1, =clave_int
            bl ascii_to_int

            pop {r3}
            pop {r1}
            pop {lr}
            bx  lr
        .fnend

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

            cmp r0, #' '                                         @Comparamos si r0 es ' '
            moveq r2, r0                                         @Si lo es, no lo encriptamos
            beq return_caracter_encriptado

            add r2, r0, r1                                        @Encripto el caracter en base a la clave (caracter + clave) en r0

            cmp r0, #'a'                                         @Compara r0(caracter) con la letra 'a' en hexadecimal
            bge verificar_caracter_si_esta_dentro_del_rango_minusculas
            b verificar_caracter_si_esta_dentro_del_rango_mayusculas

            verificar_caracter_si_esta_dentro_del_rango_mayusculas:
                cmp r0, #'A'                                     @Compara r0(caracter) con la letra 'A' en hexadecimal
                bge verificar_caracter_overflow_mayuscula
                b return_caracter_encriptado

            verificar_caracter_overflow_mayuscula:
                cmp r2, #'Z'                                      @Verifica si hay overflow -> r2 > Z
                bgt convertir_caracter_encriptado_overflow        @Si el caracter encriptado esta overflow, lo convierte
                ble return_caracter_encriptado                    @Si el caracter encriptado(r2) esta dentro del rango del abecedario en minuscula, lo retorno

            verificar_caracter_si_esta_dentro_del_rango_minusculas:
                cmp r0, #'z'                                     @Compara r0(caracter) con la letra 'z' en hexadecimal
                ble verificar_caracter_overflow_minuscula
                b return_caracter_encriptado
                
            verificar_caracter_overflow_minuscula:
                cmp r2, #'z'                                      @Verifica si hay overflow -> r2 > z
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

        @return r0: cadena encriptada
    
    */
    encriptar:
        .fnstart
            push {lr}
            push {r2}
            push {r3}
            push {r4}
            
            mov r2, r0                         @auxilio la direccion de memoria en r2 
            mov r4, #0                         @caracteres procesados
            encriptar_loop:
                ldrb r3, [r2]                  @obtengo el mas signficativo y lo guardo en r3
                
                cmp r3, #00                    
                beq return_encriptar          @Si r3 == 0, termina la funcion

                cmp r3, #' '                  @Comparamos  r3 con ' '
                addne r4, r4, #1              @Si no es un ' ', sumamos 1 al contador de caracteres procesados
                
                push {r2}

                mov r0, r3                     @Guardo en r0 el caracter 
                bl encriptar_caracter

                pop {r2}
                strb r0, [r2], #1              @cambio en la posicion del bit mas significativo el caracter comun al encriptado 

                b encriptar_loop

            return_encriptar:
                mov r0, r2
                push {r1}

                mov r1, r4
                bl convertir_caracteres_procesados_a_ascii

                pop {r1}
                pop {r4}
                pop {r3}
                pop {r2}
                pop {lr}
                bx lr 
        .fnend


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

        @return r0 cadena desencriptada

    */
    desencriptar:
        .fnstart
            push {lr}
            push {r2}
            push {r3}
            push {r4}

            mov r2, r0                         @auxilio la direccion de memoria en r2 
            mov r4, #0                         @caracteres procesados
            desencriptar_loop:
                ldrb r3, [r2]                  @obtengo el mas signficativo y lo guardo en r3
                
                cmp r3, #00                     
                beq end_desencriptar_loop      @Si r3 == 0, termina la funcion

                cmp r3, #' '                  @Comparamos  r3 con ' '
                addne r4, r4, #1              @Si no es un ' ', sumamos 1 al contador de caracteres procesados
                
                push {r2}

                mov r0, r3                     @Guardo en r0 el caracter 
                bl desencriptar_caracter

                pop {r2}
                strb r0, [r2], #1              @cambio en la posicion del bit mas significativo el caracter encriptado al comun

                b desencriptar_loop

            end_desencriptar_loop:
                mov r0, r2

                push {r1}

                mov r1, r4
                bl convertir_caracteres_procesados_a_ascii
                
                pop {r1}

                pop {r4}
                pop {r3}
                pop {r2}
                pop {lr}
                bx lr 
        .fnend

    /*
        @param r0: direccion de memoria de palabra

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
    
        @param r0: direccion de memoria del string a limpiar 
    */

    limpiar_texto:
        .fnstart
            push {lr}
            push {r1}
            push {r2}
            push {r3}

            mov r2, #0          @Iteraciones

            limpiar_texto_loop:
                ldrb r3, [r0, r2]

                cmp r3, #00                     @Comparamos si r3 == ""
                beq return_limpiar_texto        @Si lo es, termina la cadena

                mov r3, #0                      @Limpiamos el caracter obtenido r3 = ""
                strb r3, [r0, r2]               @r0[r2] = r3 -> r0[r2] = ""
                add r2, r2, #1                  @Iteramos...
                b limpiar_texto_loop

            return_limpiar_texto:
                pop {r3}
                pop {r2}
                pop {r1}
                pop {lr}

                bx lr
        .fnend

    /*
        @param r0: direccion de memoria mensaje_encriptado (mensaje)
        @param r1: direccion de memoria ayuda (clave)
        
        @return r0: clave, si es 0 no se obtener la clave
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
 
 @AGREGADO
                cmp r5, #0                                                      @Comparamos r5 con null
                beq verificar_length_palabra_actual_con_clave                   @Si es null, verificaciones si palabra_encriptada_actual.length == palabra_ayuda.length                                 

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
                push {r0}
                mov  r0, r2

                bl limpiar_texto

                pop {r0}

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

@COMENTARIO AGREGADO
                sub r7, r6, r5                                                  @cantidad_posiciones = caracter_palabra_encriptada - caracter_palabra_ayuda  { (B-X) = (66-88)=-22 (F-B) 4}      }

@AGREGADO
                cmp r7,#0
                addlt r7,r7,#26                                                 @si es negativo sumo 26

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

    print_mensaje_usuario_input:
        .fnstart
            push {lr}
            push {r2}
            push {r3}

            mov r2, #10
            ldr r3, =mensaje_usuario_input
            bl print

            pop {r3}
            pop {r2}
            pop {lr}
            bx lr
        .fnend

    print_mensaje_error:
        .fnstart
            push {lr}
            push {r2}
            push {r3}

            mov r2, #10
            ldr r3, =mensaje_error
            bl print

            pop {r3}
            pop {r2}
            pop {lr}
            bx lr
        .fnend

    print_mensaje_usuario_output:
        .fnstart
            push {lr}
            push {r2}
            push {r3}

            mov r2, #10
            ldr r3, =mensaje_usuario_output
            bl print

            pop {r3}
            pop {r2}
            pop {lr}
            bx lr
        .fnend

    print_mensaje:
        .fnstart
            push {lr}
            push {r2}
            push {r3}

            mov r2, #10
            ldr r3, =mensaje
            bl print

            pop {r3}
            pop {r2}
            pop {lr}
            bx lr
        .fnend

    print_mensaje_clave:
        .fnstart
            push {lr}
            push {r0}
            push {r1}
            push {r2}
            push {r3}
        
            ldr r0, =clave_int
            ldr r0, [r0]

            bl int_to_ascii

            mov r0, r3
            ldr r3, =mensaje_clave
            str r0, [r3]

            mov r2, #10
            bl print

            pop {r3}
            pop {r2}
            pop {r1}
            pop {r0}
            pop {lr}

            bx lr
        .fnend

    print_mensaje_usuario_clave:
        .fnstart
            push {lr}
            push {r2}
            push {r3}

            mov r2, #10
            ldr r3, =mensaje_usuario_clave
            bl print

            pop {r3}
            pop {r2}
            pop {lr}
            bx lr
        .fnend

    print_caracteres_procesados:
        .fnstart
            push {lr}
            push {r2}
            push {r3}

            mov r2, #10
            ldr r3, =caracteres_procesados
            bl print

            pop {r3}
            pop {r2}
            pop {lr}
            bx lr
        .fnend

    print_mensaje_usuario_caracteres_procesados:
        .fnstart
            push {lr}
            push {r2}
            push {r3}

            mov r2, #10
            ldr r3, =mensaje_usuario_caracteres_procesados
            bl print

            pop {r3}
            pop {r2}
            pop {lr}
            bx lr
        .fnend

    print_salto_linea:
        .fnstart
            push {lr}
            push {r2}
            push {r3}

            mov r2, #2
            ldr r3, =salto_linea
            bl print

            pop {r3}
            pop {r2}
            pop {lr}
            bx lr
        .fnend

    print_output:
        .fnstart
            push {lr}

            bl print_salto_linea
            bl print_mensaje_usuario_output
            bl print_mensaje
            bl print_salto_linea
            bl print_mensaje_usuario_clave
            bl print_mensaje_clave
            bl print_salto_linea
            bl print_mensaje_usuario_caracteres_procesados
            bl print_caracteres_procesados

            pop {lr}
            bx lr
        .fnend

    /* 
        r1: valor de caracteres procesados 
    */
    convertir_caracteres_procesados_a_ascii:
        .fnstart
            push {lr}
            push {r0}
            push {r2}
            push {r3}

            mov r0, r1
            bl int_to_ascii

            ldr r2, =caracteres_procesados
            str r3, [r2]

            pop {r3}
            pop {r1}
            pop {r0}
            pop {lr}
            bx lr
        .fnend

    encriptacion:
        .fnstart
            push {lr}

            ldr r0, =mensaje
            ldr r1, =clave_int
            ldr r1, [r1]
            
            bl encriptar

            bl print_output      

            pop {lr}
            bx lr
        .fnend

    desencriptacion:
        .fnstart
            push {lr}

            ldr r0, =mensaje
            ldr r1, =clave_int
            ldr r1, [r1]

            bl desencriptar
            
            bl print_output

            pop {lr}
            bx lr
        .fnend

    desencriptacion_con_palabra_ayuda:
        .fnstart
            push {lr}

            ldr r0, =mensaje
            ldr r1, =clave

            bl obtener_clave_con_ayuda

            cmp r0, #0
            bleq print_mensaje_error
            popeq {lr}
            bxeq lr

            mov r1, r0
            mov r2, r0
            ldr r0, =mensaje

            bl desencriptar
            
            ldr r3, =clave_int
            str r2, [r3]
            
            bl print_output

            pop {lr}
            bx lr
        .fnend

.global main
    main:
        /*                Entrada de datos                     */
        bl print_mensaje_usuario_input

        @Entrada de datos
        bl input_usuario

        /*        Proceso y parseo de datos ingresados         */
        bl parsear_input_usuario

        /*          Validacion de las opciones                */

        ldr r0, =opcion
        ldrb r0, [r0]

        cmp r0, #'c'
        bleq encriptacion

        cmp r0, #'d'
        bleq desencriptacion

        cmp r0, #'b'
        bleq desencriptacion_con_palabra_ayuda 

        bal end
        
    end:
        mov r7, #1
        swi 0
