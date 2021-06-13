.data
    dato0: .int -2147483647
    dato1: .int 1
.text
.global main
    main:
        /* 8. Efectúe una instrucción que encienda el flag N y deje apagado el flag C. */
        ldr r0, =dato0
        ldr r0, [r0]

        ldr r1, =dato1
        ldr r1, [r1]

        subs r0, r1
        bal end
            
	end:
		mov r7, #1
		swi 0
