.data
stringentrada: .ascii "                                                           "
mensaje: .ascii "                                                                 "
clave: .ascii "        "
opcion: .ascii "        "

.text

/* -------------------------- Codigo Subrutinas ---------------------------*/


/* ----------------------- Input ----------------------------------- */

/*
Lee la entrada por consola 200 caracteres

Return
r1: direccion de memoria de la entrada del usuario

*/

input:
	.fnstart
		push {lr}
		mov r7, #3				@Entrada por teclado
		mov r0, #0				@Entrada de cadena
		mov r2, #200			@Longitud de 200
		ldr r1, =stringentrada	@r1 <- se guarda direccion de memoria de la entrada del usuario
		swi 0

		pop {lr}
		bx lr
	.fnend


/* -------------------------- extraermensaje ---------------------- */
/*
Parametros
r1 <- direccion de memoria de la entrada del usuario
r3 <- direccion de memoria de donde se va a guardar el mensaje

Return
r1 <- direccion de memoria de la ultima posicion del mensaje
*/
extraermensaje:
	.fnstart

		loopmensaje:
			ldrb r0,[r1],#1		@ cargo en r0 un caracter de la entrada del usuario y preparo para el siguiente caracter
			cmp r0,#0x3b		@ comparo con ';'

			push {lr}
			bleq agregarnulo	@Agrega el caracter nulo si la cadena termina con ';'
			pop {lr}

			bxeq lr				@ Si el caracter en r0 es igual a ';' salgo de la funcion
			strb r0,[r3],#1		@ guardo en la direccion de memoria de r3 el caracter de r0
			bal loopmensaje		@ vuelvo a iterar

	.fnend


/*

Parametros

r1 <- direccion de memoria de stringentrada
r3 <- direccion de memoria de clave

Output
r1 <- direccion de memoria de la ultima posicion de clave

*/
/*------------------------ extraerclave -----------------------------*/



extraerclave:
	.fnstart

		loopclave:
			ldrb r0,[r1],#1		@cargo en r0 un caracter de la entrada del usuario y preparo para el siguiente caracter
			cmp r0,#0x3b		@ comparo con ';'

			push {lr}
			bleq agregarnulo	@Agrega el caracter nulo si la cadena termina con ';'
			pop {lr}

			bxeq lr				@ Si el caracter en r0 es igual a ';' salgo de la funcion
			strb r0,[r3],#1		@ guardo en la direccion de memoria de r3 el caracter de r0
			bal loopclave		@ vuelvo a iterar

	.fnend


/* ----------------------- extraeropcion -------------------------------

Parametros

r1 <- direccion de memoria de stringentrada
r3 <- direccion de memoria de opcion

Output
r1 <- direccion de memoria de la ultima posicion de clave

*/
extraeropcion:
	.fnstart

		loopopcion:
			ldrb r0,[r1],#1		@cargo en r0 un caracter de la entrada del usuario y preparo para el siguiente caracter
			cmp r0,#0x3b		@ comparo con ';'

			push {lr}
			bleq agregarnulo	@Agrega el caracter nulo si la cadena termina con ';'
			pop {lr}

			bxeq lr				@ Si el caracter en r0 es igual a ';' salgo de la funcion
			strb r0,[r3],#1		@ guardo en la direccion de memoria de r3 el caracter de r0
			bal loopopcion		@ vuelvo a iterar
	.fnend
/* ------------------ agregarnulo -------------------- */
/*
Agrega el caracter nulo en la direccion de memoria pasada en r3

Parametros
r3 <- direccion de memoria donde se ingresara el caracter nulo

*/
agregarnulo:
		.fnstart
			mov r0,#0		@caracter null
			strb r0,[r3]
			bx lr
		.fnend

.global main


/* --------------- Codigo del main ---------------------*/

main:

	@Entrada de datos
	bl input				@ Usuario introduce mensaje

	/*Cargo parametros a la funcion extraermensaje*/
	ldr r1,=stringentrada
	ldr r3,=mensaje
	bl extraermensaje 	@Se extrae el mensaje del usuario del input

	/*Cargo parametros a la funcion extraerclave*/
	ldr r3,=clave
	bl extraerclave		@Se extrae la clave del usuario del input

	/*Cargo parametros a la funcion extraeropcion*/
	ldr r3,=opcion
	bl extraeropcion

	mov r7,#1
	swi 0
