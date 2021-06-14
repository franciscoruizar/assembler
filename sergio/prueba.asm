
.data
    ART: .asciz " ██████ ██ ███████ ██████   █████  ██████   ██████       ██████ ███████ ███████  █████  ██████ \n██      ██ ██      ██   ██ ██   ██ ██   ██ ██    ██     ██      ██      ██      ██   ██ ██   ██ \n██      ██ █████   ██████  ███████ ██   ██ ██    ██     ██      █████   ███████ ███████ ██████  \n██      ██ ██      ██   ██ ██   ██ ██   ██ ██    ██     ██      ██           ██ ██   ██ ██   ██ \n ██████ ██ ██      ██   ██ ██   ██ ██████   ██████       ██████ ███████ ███████ ██   ██ ██   ██   \n"


.text

    /*
        Imprime por consola el valor de r3  

        @param r2 length del output
        @param r3 direccion de la cadena a imprimir

        @return: void
    */


.global main

main:
   

    //imprime_pantalla:
        mov r7,#4           @indico que en la interrupcion, se va a imprimir un mensaje en pantalla
        mov r0,#1           @salida una cadena
        mov r2,#600           @cargo la cantidad de caracteres a leer (1)
        ldr r1,=ART     @cargo la direccion de memoria del mensaje a imprimir
        swi 0

    
