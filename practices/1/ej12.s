.data
.text
.global main
    main:
        /* 
        
            12. Muestre cómo usar la instrucción OR para encender el bit más significativo del registro r0.
        
        */

        mov r0, #0          @1110  en binario
        mov r1, #1          @0110  en binario

        orr r2, r0, r1      
        
        bal end
            
	end:
		mov r7, #1
		swi 0
