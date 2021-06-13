.data
    A: .word 18
    B: .word 33
.text
.global main
    main:
        ldr r0, =A
        ldr r1, [r0]

        ldr r0, =B
        ldr r2, [r0]

        push r1
        push r2

        pop r1
        pop r2

        bal end

	end:
		mov r7, #1
		swi 0