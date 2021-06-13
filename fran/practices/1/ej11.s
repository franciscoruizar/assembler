.data
.text
.global main
    main:
        /* 
        
            11. Muestre cómo usar la instrucción AND para apagar el bit más significativo del registro r0.
        
        */

        mov r0, #1          @1110  en binario
        mov r1, #0          @0110  en binario

        and r2, r0, r1  @Lo identifico con el flag z (zero)
        
        bal end
            
	end:
		mov r7, #1
		swi 0
