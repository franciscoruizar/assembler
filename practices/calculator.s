.data
    A:        .word
    B:        .word
    C:        .word
    O:        .word
    QUOTIENT: .word
.text
.global main
	main:
		mov r0, #15             // a = 15
        mov r1, #15             // b = 15
        mov r2, #0              // result = 0
		mov r3, #0x2d           // operator = "+"
        mov r4, #0              // quotient = 0

    	cmp r3, #0x2b           // if (operator.equals("+"))
        beq adition             //  adition();

		cmp r3, #0x2d           // if (operator.equals("-"))
        beq minus               //  minus();

        cmp r3, #0x2a           // if (operator.equals("*"))
        beq multiply            //  multiply();

        cmp r3, #0x2f           // if (operator.equals("/"))
        beq division            //  division();

        adition:
			add r2, r0, r1      // result = a + b;
			bal end             // end();

        minus:
			sub r2, r0, r1      // result = a - b;
			bal end             // end();
	
		multiply:
			mul r2, r0, r1      // result = a * b;
			bal end             // end();

		division:
            add r4, r4, #1      // quotient = quotient + 1;
            sub r0, r0, r1      // a = a - b;
            cmp r0, r1          // if (a > b)
            bge division        //  division();
            mov r2, r4          // else result = quotient
            bal end             // end();
		end:
			mov r7, #1
			swi 0
