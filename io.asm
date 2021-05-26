.data
    mensaje: .ascii "Ingresar texto de 4 caracteres!: \n"
    cadena:  .ascii " "
.text
.global main

main:

    // Salida por pantalla
    mov r7, #4         @saldia por pantalla
    mov r0, #1         @salida cadena
    mov r2, #35        @tamaño de la cadena
    ldr r1, =mensaje
    swi 0              @ swi, software interrupt

    // Leer por teclado
    mov r7, #3      @lectura por teclado
    mov r0, #0      @ingreso de cadena
    mov r2, #4      @leer cant caracteres
    ldr r1, =cadena @donde se guarda lo ingresado
    swi 0           @ swi, software interrupt

    // Salida por pantalla
    mov r7, #4         @saldia por pantalla
    mov r0, #1         @salida cadena
    mov r2, #35        @tamaño de la cadena
    ldr r1, =cadena
    swi 0              @ swi, software interrupt
    
    mov r7, #1
    swi 0
