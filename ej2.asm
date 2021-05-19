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
    A: .int
    B: .int
    C: .int
.text
.global main
	main:
		mov r0, #15
        mov r1, #15
        mov r2, #0

        cmp r0, r1       //compara r1 con r2
        beq end          // var1 == var2 hacer el salto a #equal
		bgt adition      // var1 > var2 hacer el salto a #adition
		bal subtraction  // var1 < var2 hacer el salto a #subtraction

        adition:
			add r2, r0, r1 //result = var1 + var2
			bal end

        subtraction:
			sub r2, r0, r1
			bal end

		end:
			mov r7, #1
			swi 0