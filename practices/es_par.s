/* Un numero es par */
.data
    numero: .int 14
.text
.global main

@Parametro 
@r3 <- numero

@r0 <- 1 es par, 0 no es par
es_impar:
  .fnstart
    and r0,r3,#0x1
    bx lr
  .fnend

main:
  ldr r0,=numero
  ldr r3,[r0]

  bl es_par

  bal end
            
    end:
    	mov r7, #1
    	swi 0