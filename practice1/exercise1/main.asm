.data
    N1: .word 18
    N2: .word 33
    N3: .word 40
.text
.global main
    main:
        sub r1, N2, N3 // r1 = N2 - N3
        add r0, N1, r1 // r0 = N1 + r1

        ldr r1, =r0    //cargo en r1 la direccion de r0
		ldr N1, [r1]   // N1 = r0
 
        ldr r0, =N1
        ldr r2, [r0]
        ldr N1, r2

        ldr r0, =N2
        ldr r3, [r0]
        ldr N2, r3

        ldr r0, =N3
        ldr r4, [r0]
        ldr N3, r4

        
        bal end

	end:
		mov r7, #1
		swi 0