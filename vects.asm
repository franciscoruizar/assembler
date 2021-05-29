.data
    values:   .word 500, 36, -23
    total:    .byte 0
    iterator: .byte 1
.text
.global main
	main:
        ldr r0, =values
		ldr r1, [r0] 

        ldr r0, =total 	   
		ldr r2, [r0] 	   

        ldr r0, =iterator  
		ldr r3, [r0] 	   
        
        bal loop

        loop:
            cmp r3, #3
            beq end

            add r3, r3, #1

            ldrb r4, [r2]
            add r2, r2, r4

            bal loop
        
		end:
            mov r7, #4         
            mov r0, #1         
            mov r2, #35        
            ldr r1, =total
            swi 0           

			mov r7, #1
			swi 0

