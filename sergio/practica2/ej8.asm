/*
8. Escriba un procedimiento que calcule el cociente entre dos valores definidos en las
etiquetas N1 y N2 solamente si N1 es mayor que N2 y N2 es distinto de 0. Defina una
etiqueta RESULTADO para almacenar el cociente. Si no se cumplen las condiciones
mencionadas almacenar el valor 0.
*/

.data
    RESULTADO: .word 0
    N1: .word   10
    N2: .word   3

 .text
    @recibe en r0 la direccion de N1
    @recibe en r1 la direccion de N2
    @recibe en r3 la direccion de memoria de RESULTADO
    calculo:
        .fnstart
            mov r2,#0       @limpio el registro r2
            ldr r0,[r0]     @cargo en r0 el valor de N1
            ldr r1,[r1]     @cargo en r1 el valor de N2

            cmp r0,r1       @comparo N1 con N2
            cmpgt r1,#0     @si n1 es mayor a n2, comparo n2 con 0

            push {lr}
            blne divide     @si se dan las condiciones, divido
            pop {lr}
            
            str r2,[r3]
            bx lr

        .fnend
    
    @recibe en r0 el numerador
    @recibe en r1 el denominador
    @devuelve en r2 el resultado
    @devuelve en r0 el resto
    divide:
        .fnstart
            mov r2,#0   @limpio el registro r2 donde guardo el resultado

            ciclo:
            cmp r0,r1       @si r0 es menor a r1
            bxlt lr         @salgo

            sub r0,r0,r1
            add r2,#1
            bal ciclo

        .fnend

 .global main
 main:
        ldr r0,=N1
        ldr r1,N2
        ldr r3,=RESULTADO

        bl calculo
         

 end:
    mov r7,#1
    swi 0