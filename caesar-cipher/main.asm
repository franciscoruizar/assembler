/*
    NOMENCLATURAS:
        - Parametros para subrutinas: r0 a r3
        - Retornos para subrutinas: r0 a r1
        - Cada subrutina debe tener docs de parametros, retornos y funcion
        - Dentro de global main utilizar los registros r4, r5, r6, r8, r9, r10, r11, r12
        - MAX caracteres de input y output: 200
    ToDo:
        Backlog:
            - crear subrutina extraer_clave -> tambien extrae la palabra clave              -> Eze
            - crear subrutina extraer_opcion                                                -> Eze
            - crear subrutina codificar
            - crear subrutina decodificar
            - crear subrutina decodificar_con_palabra_clave
            - crear subrutina length                                                        -> Eze
            - crear subrutina convertir_ascii_entero                                        -> Sergio
            - crear subrutina convertir_entero_ascii                                        -> Sergio
            - crear subrutina es_minuscula                                                  -> Fran
            - crear subrutina es_mayuscula                                                  -> Fran
            - crear subrutina sumar_ascii_minus                                             -> Fran
            - crear subrutina sumar_ascii_mayus                                             -> Fran
            - crear logica de opciones
            - unir subrutinas
            
        Doing:
        Do:
            - crear subrutina extraer_mensaje
            - crear subrutina input
            - crear subrutina print

 */


.data
    output_usuario: .ascii "                                                                                                                                                                                                        "
    cadena:  .ascii "                                                                                                                                                                                                        "
    mensaje: .ascii "                                                                                                                                                                                                        "
.text

    /*
    Imprime por consola el valor de r3  

    @param r2 length del output
    @param r3 direccion de la cadena a imprimir

    @return: void
    */
    print:
        .fnstart
            mov r7, #4               @salida por pantalla
            mov r0, #1               @salida cadena
            mov r1, r3               @copiamos a r1 la direccion de memoria de r3 y hara el output
            swi 0                    @swi, software interrupt
            bx lr
        .fnend

    /*
    Lee por consola input ingresado por el usuario y retorna el valor en r0

    @return: r0 contenido del input
    */
    input:
        .fnstart
            mov r7, #3           @lectura por teclado
            mov r0, #0           @ingreso de cadena
            mov r2, #200         @leer cant caracteres
            ldr r1, =cadena      @donde se guarda lo ingresado
            swi 0                @swi, software interrupt
            bx lr
        .fnend
    
    /*
    
    A partir del input del usuario

    @param r0: direccion del texto input original (ya la tiene cargada)
    @param r1: direccion del mensaje de salida (ta la tiene cargada)
    
    @return r0: length del mensaje 
    @return r1: modifica la variable en la funcion agregando el mensaje caracter por caracter
    
    */
    extraer_mensaje:
        .fnstart
            mov r3, #0

            while:
                add r3, #1
                ldrb r2,[r0],#1      @cargo el siguiente byte (siguiente letra) del texto en r2
                cmp r2, #0x3b        @comparo r2 con el ascii ";"
                moveq r0, r3         @si la letra es ";" devuelve la logintud de la cadena en r0
                bxeq  lr             @si la letra es ";" sale de la funcion a la posicion donde apunta lr (continua el flujo)

                strb r2,[r1],#1     @guardo la siguiente letra a continuacion de la anterior
                bal while           @vuelvo a ciclar
        .fnend
    

.global main
    main:
        bl input

        ldr r0, =cadena 
        ldr r1, =mensaje 
        bl extraer_mensaje

        mov r2, r0
        ldr r3, =mensaje
        bl print

        bal end
    end:
        mov r7, #1
        swi 0
