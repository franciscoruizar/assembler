.data
.text
.global main
    main:
        /* 5. Escriba una sola instrucción que encienda el flag Z. */
        mov r0, #0xffffffff
        mov r1, #0x1
        adds r0, r1
        bal end
            
	end:
		mov r7, #1
		swi 0
