/*
    NOMENCLATURAS:
        - Parametros para subrutinas: r0 a r3
        - Retornos para subrutinas: r0 a r1
        - Cada subrutina debe tener docs de parametros, retornos y funcion
        - Dentro de global main utilizar los registros r4, r5, r6, r8, r9, r10, r11, r12
        - MAX caracteres de input y output: 200
 */


.data
    cadena_input_usuario: .ascii "                                                                                                                                                                                                        "
    mensaje: .ascii "                                                                                                                                                                                                        "
    clave: .ascii "    "
    opcion: .ascii "    "
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
            
            mov r7, #4               @salida por pantalla
            mov r0, #1               @salida cadena
            mov r1, r3               @copiamos a r1 la direccion de memoria de r3 y hara el output
            swi 0                    @swi, software interrupt
            
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
                cmp r0,#0x3b		                    @ comparo con ';'

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
                cmp  r0, #0x3b		                  @ comparo con ';'

                bleq agregarnulo	                  @Agrega el caracter nulo si la cadena termina con ';'
                beq  return_extraerclave				  @ Si el caracter en r0 es igual a ';' salgo de la funcion
                
                strb r0,[r3],#1		                  @ guardo en la direccion de memoria de r3 el caracter de r0
                bal  loopclave		                  @ vuelvo a iterar

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

            pop {r3}
            pop {r1}
            pop {lr}
            bx  lr
        .fnend


.global main
    main:
        @Entrada de datos
        bl input_usuario

        @Proceso y parseo de datos ingresados
        bl parsear_input_usuario


        bal end
    end:
        mov r7, #1
        swi 0
