main:
    SET R7 , 0xFF         ; stack
    SET R0 , p            ; p
    SET R1 , 0x10         ; size
    SET R2 , 0x03         ; Seteamos R2 en 0x03 para usarlo y ver si son múltiplos
    SET R3 , 0x00         ; Seteamos R3 para poner 0 en los no múltiplos de forma manual
    SET R4 , 0x01         ; Seteamos R4 para usarlo como nuestro contador

    CALL [R7] , cleanBytes

halt:
    JMP halt

cleanBytes:                  ; Guardamos R0 y R1 en la pila los registros para no modificarlo.
    PUSH [R7] , R0
    PUSH [R7] , R1

    loop1:
        SUB R1 , R2          ;   (size - 3)
        CLEAN3 R0            ;   Llamamos a la función clean para limpiar 3 valores consecutivos
        JZ fin               ;   En caso de terminar, salta a fin.
        JN loop2             ;   Sino, pasa a loop2 para limpiar los valores restantes manualmente
        ADD R0 , R2          ;   
        JMP loop1            ;   Repito ciclo hasta que R1 sea menor igual a 0.

    loop2:                   ; Se realiza si el tamaño es menor a 3 (es decir, no multiplo de 3)
        ADD R0 , R4          ;
        STR [R0] , R3        ; Seteamos manualmente [R0] en 0 
        ADD R1 , R4          ; Sumamos uno al puntero para avanzar a la siguiente posición restante
        JZ fin               ; En caso de que solo sea 1 valor, terminamos (salta a fin)
        ADD R0 , R4          ; Caso contrario: vemos siguiente valor 
        STR [R0] , R3        ; Seteamos ultimo valor restante en 0

fin:                         ; Restauramos de la pila los registros para no modificarlos 
    POP [R7] , R1        
    POP [R7] , R0
    RET [R7]

p:  
DB 0x01
DB 0x01
DB 0x01
DB 0xA5
DB 0x4A
DB 0xC5
DB 0x55
DB 0x09
DB 0xA4
DB 0xEE
DB 0x43