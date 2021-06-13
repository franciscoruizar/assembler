/* 
    1. Escriba fragmentos de código assembler para realizar las siguientes operaciones:
        a. Las etiquetas N1 y N2 definen dos words. Obtenga en r0 el máximo entre N1 y N2.
        b. Las etiquetas N1 y N2 definen dos bytes. Obtenga en r0 el máximo entre N1 y N2.
        c. Las etiquetas E1 y E2 definen dos números enteros de 32 bits en complemento a
        2. Obtenga en r0 el máximo entre E1 y E2.


*/


.data
    N1: .word "10"
    N2: .word "20"

    
.text
.global main
    main:

        bal end
            
	end:
		mov r7, #1
		swi 0
