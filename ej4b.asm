main:
	SET R7, 0xFF   ;stack
	SET R0, num    ;number
	SET R1, 4	   ;steps
	SET R2, 0x01   ; seteamos R2 para ir restando la cantidad de steps (cant de iteraciones) y avanzar con el puntero
	CALL |R7|, collatzSteps

halt:
	JMP halt

collatzSteps:
	PUSH |R7|, R0       ;guardo R0 en la pila para no perder valor original
    PUSH |R7|, R1       ;guardo R1 en la pila para no perder valor original
	
	loop:
		LOAD R3, [R0]   ;Guardo en R3 lo apuntado por R0 (num)
		ADD R0, R2      ;Le sumo 1 a la posicion apuntada 
		LOAD R4, [R0]   ;Guardo en R4 lo apuntado por R0 + 1 (sumado en la linea de arriba)
	    
	loop2:
		COLLATZ R3, R4  ;LLamo a la función (lo hace una vez)
		SUB R1, R2      ; Nos fijamos si ya termine de realizar todos los steps indicados 
		JZ fin          ; En caso de que R1 - R2 == 0, salto a fin sino sigo repitiendo el ciclo loop2
		JMP loop2       

	fin:                ;Restauro valores guardados en la pila y finaliza el código 
   	 	POP |R7|, R1  
    	POP |R7|, R0
		RET |R7|

num:
DB 0x01
DB 0x22