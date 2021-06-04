.data

mensaje: .ascii "holaa\000  "

.text

/*
Parametros
r2 <- direccion de memoria del mensaje

Output
r0 <- cantidad de unos del mensaje

De uso:
r1, r4, r3

*/

calcularparidad:
	.fnstart
		mov r0,#0		//Contador de la cantidad de unos del mensaje
		loopbit:
			ldrb r1,[r2],#1		//Cargo en r1 un byte del mensaje
			cmp r1,#0			//Comparo el caracter con el caracter nulo
			bxeq lr				//Si el caracter es nulo salgo de la funcion
			push {lr}
			bl contarunos		//cuento la cantidad de unos del caracter
			pop {lr}
			bal loopbit
	.fnend


/*
@Parametros:
@r1 <- caracter

@Output:
@r0 <- cantidad de unos del byte

@De uso:
@r4

*/
contarunos:
	.fnstart
		mov r4,#0x80		// 0x80 es igual a 10000000 en binario
		loopcontarunos:
		and r3,r1,r4		// Se realiza un and para verificar si el bit es 1
		cmp r3, #0			// Comparo r3 con 0
		addne r0,#1			// Sumo uno en el contador si el resultado del and no es 0
		cmp r4,#1			// Si r4 es 00000001 Significa que llegue al final.
		bxeq lr				// Salgo de la funcion si es igual a 00000001
		ror r4,r4,#1		// corro el bit 1 posicion
		bal loopcontarunos	// vuelvo a ciclar
	.fnend


/*
input: r0: cantidad de unos
output: r0: bit de paidad
*/

calcula_bit_paridadPar:
        .fnstart
            mov r2,#2
            push {lr}
            bl division     @divide por dos para saber paridad. r0 resto, r1 resultado
            pop {rl}
            //el resto es el bit de paridad
            //si el resto es 1 significa que es impar, por lo que el bit de paridad es 1
            //si el ersto es 0, entonces es par, y el bit de paridad es 0
            add r0,r0,#0x30   @paso el numero a ascii
            bx lr
        .fnend

division:
        mov r1,#0               @limpio el registro r1 donde guardo el resultado
        .fnstart
            cicla:
        	cmp  r0,r2	        @comparo divisor con dividendo
	        bxlt lr		        @si r0 < r1 entonces sale del ciclo
	        add r1,r1,#1	    @le sumo uno al contador de resultado por cada ciclo
	        sub r0,r0,r2	    @hago la resta r0-r1 y lo pongo en r0

	        bal cicla	        @entra denuevo a la etiqueta cicla
        .fnend

.global main
main:
	ldr r2,=mensaje
	bl calcularparidad
	
	bl calcula_bit_paridadPar

	mov r7,#1
	swi 0
