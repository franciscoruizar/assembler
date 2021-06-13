.data
    dato0:     .int 18
    dato1:     .int 34
    resultado: .int 0 
.text
.global main
    main:
        /* 
        
            13. Escriba un fragmento de código para obtener el producto entre los números 18 y 34. ¿Dónde queda almacenado el resultado?
        
        */

        ldr r0, =dato0
        ldr r1, =dato1
        ldr r2, =resultado
        
        ldr r3, [r0]
        ldr r4, [r1]

        mul r5, r3, r4
        str r5, [r2]
        bal end
            
	end:
		mov r7, #1
		swi 0
