.data
    dato: .byte 1
.text
.global main
    main:
        ldr r1, =dato    @cargo en r1 la direccion de memoria dato
        ldrb r0, [r1]    @Obtengo el bit mas significativo de la direccion de memoria ubicado en r1
        mov r7, #1
		swi 0
		