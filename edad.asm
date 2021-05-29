.data
    string:  .ascii "pepe"
    string2: .word  "asasa"

.text
.global main
	main:
        ldr r0, =string
        ldrb r1, [r0]

        ldr r0, =string2
        ldrb r2, [r0]

        bal end 

		end:
			mov r7, #1
			swi 0
