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
        mov r2, #0              // c = 0
		mov r3, #"+"            // operator = "+"
        mov r4, #0              // quotient = 0

    	cmp r3, #"+"            // if (operator.equals("+"))
        beq adition             //  adition();

		cmp r3, #"-"            // if (operator.equals("-"))
        beq minus               //  minus();

        cmp r3, #"*"            // if (operator.equals("*"))
        beq multiply            //  multiply();

        cmp r3, #"/"            // if (operator.equals("/"))
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
            sub r4, r4, #1      // quotient = quotient + 1;
            sub r0, r0, r1      // a = a - b;
            cmp r0, #0          // if (a > 0)
            bgt division        //  division();
            add r2, r0, r4      // else c = a + quotient
            bal end             // end();
		end:
			mov r7, #1
			swi 0
