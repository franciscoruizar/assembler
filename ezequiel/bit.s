.data

mensaje: .ascii "holaa\000  "

.text

/*
	@param r0:  direccion de memoria del mensaje
	@return r1: cantidad de unos del mensaje
*/

calcular_bit_paridad_par:
	.fnstart
		push {lr}
		push {r1}
		push {r3}

		mov r1, #0                          @Limpiamos registros - Contador de la cantidad de unos del mensaje
		mov r2, #0                          @Limpiamos registros 
		mov r3, #0                          @Limpiamos registros - Carga del byte mas significativo

		loop_calcular_bit_paridad_par:
			ldrb r3, [r0], #1                      @Cargamos el bit mas significativo de r0 en r3
			
			cmp r3, #0                             @Comparamos r3 con ''
			beq return_calcular_bit_paridad_par    @si r3 == '', retornamos

			bl contar_cantidad_de_unos

			b loop_calcular_bit_paridad_par

		return_calcular_bit_paridad_par:
			and r2, r1, #1

			pop {r3}
			pop {r1}
			pop {lr}

			bx lr						
	.fnend


/*
	@param r3: caracter
	@return r1: cantidad de unos del byte
*/
contar_cantidad_de_unos:
	.fnstart
		push {lr}
		push {r0}
		push {r2}

		mov r0, #0                     @Limpiamos registros
		mov r2, #0x80                  @Limpiamos registros - 0x80 es igual a 10000000 en binario

		loop_contar_cantidad_de_unos:
			and r0, r3, r2
			
			cmp r0, #0                           @Comparamos r0 con 0
			addne r1, r1, #1

			cmp r2, #1
			beq return_contar_cantidad_de_unos   @Si r2 es 00000001 Significa que llegue al final.

			ror r2, r2, #1		                 @corremos el bit 1 posicion

			b loop_contar_cantidad_de_unos


		return_contar_cantidad_de_unos:
			pop {r2}
			pop {r0}
			pop {lr}

			bx lr

	.fnend


.global main
main:
	ldr r0,=mensaje
	bl calcular_bit_paridad_par

	mov r7,#1
	swi 0