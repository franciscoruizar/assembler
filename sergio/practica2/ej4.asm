/*
4. La etiqueta vector define 4 bytes . Calcule en r0 la suma de esos valores.
*/


.data
    VECTOR: .byte 5,6,7,8


 .text
 .global main
 main:
        ldr r1,=VECTOR      @cargo en r1 la direccion de memoria de la primera posicion del vector
        mov r3,#0           @limpio el registro r3 donde cuento los ciclos
        mov r0,#0           @limpio el registro r0 donde acumulo la suma

        ciclo:
        cmp r3,#4
        beq end
        ldrb r2,[r1],#1         @cargo en r2 el contenido del primer word del vector
        add r0,r0,r2
        add r3,#1           @sumo 1 al contador de ciclos
        bal ciclo    

 end:
    mov r7,#1
    swi 0