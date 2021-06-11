.data
    dato1: .word 1
    dato2: .word 4
    dato3: .word 5
    dato4: .word 6
.text
.global main
    main:
        ldr r0, =dato1
        ldr r1, [r0]

        ldr r0, =dato2
        ldr r2, [r0]

        ldr r0, =dato3
        ldr r3, [r0]

        ldr r0, =dato4
        ldr r4, [r0]

        add r0, r1, r2
        add r0, r0, r3
        add r0, r0, r4

        bal end
            
	end:
		mov r7, #1
		swi 0
