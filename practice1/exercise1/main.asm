.data
    dato1: .byte 1 
    dato2: .byte 'A'
    var4:  .word 0xB12A
.text
.global main
    main:
        mov r1, #4
        mov r0, #5
        add r1, r1, r0
        bal end
            
	end:
		mov r7, #1
		swi 0
