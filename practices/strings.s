.data
    mensaje: .asciz "aa promocione orga"
.text
.global main
main:
    ldr r4, =mensaje
    mov r5, #0x40
    mov r0, #0         @length de mensaje
    mov r1, #0         @cantidad de 'A'
    mov r2, #0         @Posicion de salto de linea 
    bal loop

    loop:
        ldrb r3, [r4, r0]

        cmp r3, #0
        beq end


        cmp r3, #0x41
        addeq r1, r1, #1


        cmp r3, #0x0A
        cmpeq r2, #0
        moveq r2, r0

        cmp r3, #0x61
        beq reemplazar_letra

        add r0, r0, #1
        bal loop

    reemplazar_letra:
        strb r5, [r4, r0]

        add r0, r0, #1
        bal loop

    end:
        mov r7, #1
        swi 0