.data
    DIGITO: .byte '8'
.text
.global main
    main:
        /*        
            La siguiente etiqueta contiene un caracter ASCII que es un dígito decimal.
            DIGITO: .byte '8'
            Escriba un programa que almacene el valor numérico correspondiente al dígito decimal en el
            registro r0.
        */

        ldr r1, =DIGITO
        ldr r1, [r1]

        sub r0, r1, #0x30

        bal end        
            
	end:
		mov r7, #1
		swi 0
