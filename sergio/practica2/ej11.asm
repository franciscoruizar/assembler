/*
11. Dar un procedimiento que escriba en pantalla la representación decimal del contenido del
registro r0. Por ejemplo si r0=1Fh debe imprimir 031. Usar que al dividir por cien se
obtienen las centenas en el cociente, y en el resto el número sin las centenas.
*/

.data


 .text
        @r0 recibe un numero
        procedimiento:
            .fnstart
                mov r2,#0       @limpio r1
                mov r1,#100       @limpio r1
                push {lr}
                bl divide
                pop {lr}

                mul r3,r2,r1
                mov r2,r3

                mov r1,#10
                push {lr,r2}
                bl divide
                mul r3,r2,r1
                pop {lr,r2}

                add r2,r2,r3

                add r2,r2,r0

                mov r0,r2
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
       mov r0,#0x1F

       bl procedimiento

 end:
    mov r7,#1
    swi 0