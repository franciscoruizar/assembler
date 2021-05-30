.data
    mensaje: .ascii "Ingresar texto de 4 caracteres!: \n"
    cadena:  .ascii " "
.text


    
    /*
    Imprime por consola el valor de r0  

    @ param r0
    @ return: void
    */
    print:
        .fnstart
            mov r7, #4         @salida por pantalla
            mov r0, #1         @salida cadena
            mov r2, #35        @tamaño de la cadena
            ldr r1, =mensaje
            swi 0              @ swi, software interrupt
            bx lr
        .fnend

    /*
    Lee por consola input ingresado por el usuario y retorna el valor en r0

    @ return: r0
    */
    input:
        mov r7, #3      @lectura por teclado
        mov r0, #0      @ingreso de cadena
        mov r2, #4      @leer cant caracteres
        ldr r0, =cadena @donde se guarda lo ingresado
        swi 0           @ swi, software interrupt
        bx lr

.global main
    main:

        // Salida por pantalla


        // Leer por teclado
        

        // Salida por pantalla
        mov r7, #4         @saldia por pantalla
        mov r0, #1         @salida cadena
        mov r2, #35        @tamaño de la cadena
        ldr r1, =cadena
        swi 0              @ swi, software interrupt
        
        bal end
        
    end:
        mov r7, #1
        swi 0
