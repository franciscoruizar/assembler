.data
    A: .int 18
    B: .int 33
    C: .int 0
.text
.global main
	main:
		ldr r0, =A 	     //cargo en r0 la direccion de A
		ldr r1, [r0] 	 //cargo en r1  el valor de la direccion de memoria de r0
		
		ldr r0, =B       //cargo en r0 la direccion de B
		ldr r2, [r0]     //cargo en r2  el valor de la direccion de memoria de r0

		ldr r0, =C       //cargo en r0 la direccion de C
		ldr r3, [r0]     //cargo en r3  el valor de la direccion de memoria de r0

        cmp r1, r2       //compara r1 con r2
        beq end          // var1 == var2 hacer el salto a #equal
		bgt adition      // var1 > var2 hacer el salto a #adition
		bal subtraction  // var1 < var2 hacer el salto a #subtraction

        adition:
			add r3, r1, r2 //result = var1 + var2
			bal end

        subtraction:
			sub r3, r1, r2
			bal end

		end:
			mov r7, #1
			swi 0