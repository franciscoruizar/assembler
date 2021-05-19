/*
    int a;
    int b;
    int c;

    if(a > b){
        c = a + b
    } else if (a < b){
        c = a - b
    } else {
        c = 0
    }

 */

.data
    A: .int 18
    B: .int 33
    C: .int 0
.text
.global main
	main:
		ldr r0, =A 	    //cargo en r0 la direccion de var1
		ldr r1, [r0] 	//cargo en r1  el valor de la direccion de memoria de r0
		
		ldr r0, =B
		ldr r2, [r0]

		ldr r0, =C
		ldr r3, [r0]

        cmp r1, r2       //compara r1 con r2
		bgt adition      // var1 > var2 hacer el salto a #adition
		bal subtraction  // var1 < var2 hacer el salto a #adition
        end              // var1 == var2 hacer el salto a #equal

        adition:
			add r3, r1, r2 //result = var1 + var2
			bal end

        subtraction:
			sub r3, r1, r2
			bal end

		end:
			mov r7, #1
			swi 0