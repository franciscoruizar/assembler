/*
Instrucciones Aritméticas y Lógicas (30 puntos)

a. (10 puntos) Las instrucciones lógicas también se usan para modificar el contenido de 
los registros a nivel de bit. 
Dar un ejemplo concreto en donde se setean en cero los 3 bits más significativos del registro r0.
*/


.data
    
.text
.global main
main:
    mov r0,#0xFFFFFFFF      @cargo en r0 un valor en hexadecimal donde todo los bits son 1
    mov r1,#0x1FFFFFFF      @cargo en r1 un valor en hexa donde todos los bits son 1 menos 3 mas significativos
    and r0,r0,r1            @con la instruccion AND, apago los 3 bits mas significativos

end:
    mov r7,#1
    swi 0

/*
b. (10 puntos) ¿Existe una instrucción para hacer la división en ARM? 
En caso de no que no la haya, hacer un pseudocódigo muestre cómo podría implementarla.
 */
/*
No existe la instruccion para hacer division en ARM, la misma tiene que ser programada.
Pseudocodigo de la division:

        int numerador;
        int denominador;
        int resultado;

        while(numerador>denominador){
            numerador=numerador-denominador;
            resultado++;
            }
        
        //cuando sale del while, en la variable numerador estará el resto de la division
        // y en la variable resultado estará el resultado de la misma.

 */


/*
c. (10 puntos) ¿Qué instrucción se puede utilizar para traer de memoria un dato de un 1 byte?. 
Muestre un ejemplo.
*/

@la instruccion ldrb permite traer 1 byte de memoria

.data
    N1: .word 0xA1F1A1F1
.text
.global main
main:
    mov r1,#0           @limpio el registro r1
    ldr r0,=N1          @apunto r0 a la posicion de memoria del primer byte de N1
    ldrb r1,[r0]        @traigo de memoria el primer byte del word
    

end:
    mov r7,#1
    swi 0




