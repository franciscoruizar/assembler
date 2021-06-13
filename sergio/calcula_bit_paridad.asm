.data

mensaje: .ascii "hola\000        " 

.text
.global main

main:
    ldr r0,=mensaje

    bl calcula_cant_unos        @calculo cuantos unos hay en el mensaje en binario

    mov r0,r2
    bl calcula_bit_paridadPar   @a patir de la cantidad de unos obtengo el bit de paridad en R0 en numero ascii

    mov r7,#0
    swi 0

/*
Input:
    r0: la direccion de la "variable" donde esta guardado el mensaje
uso:
    r2: sumo la cantidad de unos de cada byte
Output:
    r2: cantidad de unos
    
*/

calcula_cant_unos:
        mov r2,#0

        .fnstart
        
        ciclo2:
        ldrb r1,[r0],#1             @cargo en r1 la primera/siguiente letra (1 byte), y quedo apuntando al siguiente
        cmp r1,#0x00                @comparo r1 con el caracter null
        bxeq lr                     @si es el caracter nullo, salgo de la funcion

        push {lr,r0,r1}
        push {r2}
        bl cantidad_de_1_en_byte    @entro a la funcion para calcular la cantidad de 1 del byte
        pop {r2}
        add r2,r2,r0                @sumo la cantidad de unos del byte en r2
        pop {r1,r0,lr}

        bal ciclo2

        .fnend

/*
input: 
    r1: el byte que quiero saber la cantidad de 1
uso:
    r2: 0x0000080   auxiliar para calcular (hasta 8 para recorrer todo el byte) 1000 0000 en binario
    r3: contador de la cantidad de ciclos 
    r3: auxiliar "como bandera" para saber si es o no un "1" la posicion
output: 
    r0: la cantidad de 1 que tiene el byte
*/

cantidad_de_1_en_byte:
        .fnstart
        mov r0,#0
        mov r2,#0x80        //10000000 en binario
        mov r3,#0           @aca guardo el numero de posicion que estoy evaluando

        ciclo:
        cmp r3,#8           @comparo la cantidad de ciclos con el numero 8
        bxeq lr             @ si ya hice 8 ciclos (recorri los 8 bits) salgo de la funcion

        push {r3}
        and r3,r1,r2        @hago un and entre la letra y el auxiliar y cicla en todas las posiciones
        cmp r3,#0           @comparo r3 con cero para hacer la condicion
        addne r0,#1         @si r3!=0 entonces la posicion actual es un 1 asi que sumo al contador de unos
        ror r2,r2,#1        @corro 1 bit a la derecha para comprobar si es 1 el proximo bit en el ciclo
        pop {r3}
        
        add r3,#1           @aumento 1 al contador de ciclos
        bal ciclo           

        .fnend


/*
input: r2: cantidad de unos
output: r0: bit de paidad
*/

calcula_bit_paridadPar:
        .fnstart
            mov r0,r2
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