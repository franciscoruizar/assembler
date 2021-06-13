/*
10. Escribir un procedimiento que reciba en r0 el offset de un texto’, y que reemplace en dicho
texto todas las letras mayúsculas por minúsculas.
*/

.data
    TEXTO: .asciz "HoLa mUNdo"


 .text

    @en r0 recibe el desplazamiento del texto 32
    @en r1 recibe la direccion de memoria del texto
    procedimiento:
        .fnstart
            mov r2,#0   @limpio r2

            ciclo:
            ldrb r2,[r1]        @cargo el primer caracter en r2
            cmp r2,#00          @si es null
            bxeq lr               @salgo de la funcion

            cmp r2,#' '  
            beq noLower

            cmp r2,#'Z'
            blt lower
            bal noLower
            

            noLower:
                strb r2,[r1],#1
                bal ciclo

            lower:
                addne r2,r2,r0      @convierto en minuscula
                strb r2,[r1],#1
                bal ciclo

        .fnend


 .global main
 main:
        mov r0,#32
        ldr r1,=TEXTO

        bl procedimiento



 end:
    mov r7,#1
    swi 0