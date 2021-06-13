.data
    string:  .ascii "pepe"
.text
.global main
	main:
        ldr r0, =string
        bl ucase
        bal end 

        ucase:
            push {r4}
            bal loop

        loop:
            ldrb r4, [r0]

            cmp r4, #0
            beq end_loop

            cmp r4, #122
            subls r4, r4, #32

            cmp r4, #65
            addlt r4, r4, #32

            strb r4, [r0], #1

            b loop


        end_loop:
            pop {r4}

		end:
			mov r7, #1
			swi 0