/**
1. Escriba un código para obtener en r0 la suma de los números contenidos en r1, r2, r3 y r4. Con
ayuda de gdb ejecute paso por paso y verifique cómo se actualizan los valores contenidos en los
registros.
 */

 .data

 .text
 .global main

 main:
        mov r0,#0   @limpio el registro r0
        mov r1,#1
        mov r2,#2
        mov r3,#3
        mov r4,#4

        add r0,r1,r2    @en r0 guardo la suma r1+r2
        add r0,r0,r3    @al resultado le sumo r3
        add r0,r0,r4    @al resultado le sumo r4

 end:
    mov r7,#1
    swi 0