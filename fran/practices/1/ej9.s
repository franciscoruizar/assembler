.data
    dato0: .int 
    dato1: .int 
.text
.global main
    main:
        /* 
        
            9. Usando la instrucción AND modifique el registro r0 poniendo en cero los 4 bits menos
               significativos preservando el valor de los 28 bits más significativos. Por ejemplo, si el número
               contenido en r0 es ( 00000000 00000000 00000000 01111010 binario), debe quedar (00000000
               00000000 00000000 01110000 binario).
        
        */

        mov r0,#0x07A          @1111010  en binario
        mov r1,#0xFFFFFFF0     @1110000  en binario

        and r2,r0,r1
        bal end
            
	end:
		mov r7, #1
		swi 0
