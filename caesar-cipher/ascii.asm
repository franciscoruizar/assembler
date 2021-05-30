.data
    character: .ascii "a"
    clave:     .ascii "2"
.text
.global main

main:
    ldr r0, =character
    ldr r1, =clave
    mov r3, #0
    add r3, r0, r1

    cmp r3, #90
    blt return_aux

    sub r9, r3, #26

    mov r7, #4         @saldia por pantalla
    mov r0, #1         @salida cadena
    mov r2, #35        @tamaño de la cadena
    mov r1, r9
    swi 0              @ swi, software interrupt

    bal end

    return_aux:
        mov r0, r3

    end:
        mov r7, #1
        swi 0
