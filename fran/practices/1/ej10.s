.data
.text
.global main
    main:
        /* 
        
            10. Usando AND, determine si el bit más significativo del registro r0 está encendido (1). Aclare cuál
            es la condición (flag) que indica si dicho bit vale 0 o 1.
        
        */

        mov r0,#0          @1111010  en binario
        mov r1,#0          @1110000  en binario


        ands r2, r0, r1  @Lo identifico con el flag z (zero)
        
        bal end
            
	end:
		mov r7, #1
		swi 0
