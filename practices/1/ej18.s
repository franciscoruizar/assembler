.data
    X: .ascii "123"
.text
.global main
    main:
        /*        
            18. Suponiendo que la etiqueta X apunta a la representación en texto ASCII de un número de 3
                dígitos en base 10 (un carácter para cada dígito), obtenga en r0 el valor de ese número. Tener
                en cuenta que los caracteres ‘0’ a ‘9’ tienen código ASCII 30h a 39h.
        */

        ldr r0, =X
        mov r1, #0

    loop:
        ldrb r2, [r0, r1]

        cmp r2, #00
        beq end

        sub r3, r2, #0x30

        strb r3, [r0, r1]

        add r1, r1, #1
        bal loop
            
	end:
		mov r7, #1
		swi 0
