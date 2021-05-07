.data                         //Directiva de control: delimita seccion de datos

.al: .byte 1                  //tipo byte, se inicializa en 1 si le agrego .align rellena
var2: .byte 'A'               // tipo byte, caracter A
var3: .hword 25000            //tipo word 16bits a 2500
var4: .word 0xA2345678        //tipo de word de 32 bits
b1: .ascii "hola mundillo"    //definicion de cadena
b2: .asciz "hello 2"          // definicion de cadena que termina con null
dato1: .zero 300              //300 bytes de valor cero
dato2: .space 200, 4          //200 bytes del valor 4
.equ nada, 4                  //definimos constante nada con valor 4 tambien se puede negativos
.equ dividido, nada/2         //dividido=2
.equ dos, 2

.text                         //Directiva de control: delimita seccion del codigo
.global main
    main:
        nop                  //Esta inst no hace nada, consume 1 ciclo de reloj
        mov r7, #1           //Se carga en R7 el syscall para swi, si R7=1 swi sabe que debe salir al SO
        swi 0                //SWI, Software Input
