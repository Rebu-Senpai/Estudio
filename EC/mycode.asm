.MODEL SMALL

.STACK 100h

.DATA 
	
    char db 5,?,5 dup(?) ; dejando una extra para enter 
    pesos db 8,4,2,1
    resultado db ?  
    resultado2 db ?
    signo2 db '+'      
    signo db '+'
    clave db 'Digite el numero 4 Digitos: ', '$'
.CODE
    ;Iniciar el segmento de Datos
    mov ax, seg char
    mov ds, ax     
                     
                     
    ;Introducir los datos por teclado
    mov dx, offset char     
    mov ah, 0Ah
    int 21h    
    
    sub char[2],30h            ; Restamos 48 al numero para que se quede en 1 o 0
    sub char[3],30h
    sub char[4],30h
    sub char[5],30h
    
    mov al, char[3]
    mul pesos[1]
    add resultado,al
     
    mov al, char[4]
    mul pesos[2]
    add resultado,al
    
    mov al, char[5]
    mul pesos[3]
    add resultado,al
    
    ;Aqui termina los numero enteros y empezamos con signo;
    
    mov al, char[2]
    cmp al,1   
    
    jnz signo_cambia ;salta si no es igual   
    mov signo,'-'            
    
    
    
        
    signo_cambia:
    
    mov ax, 0b800h ; lleva el 0 delante para no leer como una etiqueta
    mov es, ax ;mueve acumulador a segmento extra
    
    mov ah, 101b ; Cambia de color, Magenta
    
    mov al, 'C'
    MOV es:[0], ax
    mov al, '1'
    mov es:[2], ax
    mov al, ':'
    mov es:[4], ax
    mov al, signo
    mov es:[6], ax
    mov al, resultado
    add al, 30h     	; Se le suma para que quede en codigo ascic el valor que queremos
    mov es:[8], ax  
        

    
    
    
    
    
    
	mov ax,4c00h
	int 21h
END    