.MODEL SMALL

.STACK 100h

.DATA

	char db 'x'
	espacio db ' '


.CODE

	mov ax, seg char
    mov ds, ax
    
    mov al, 13h
    mov ah, 00h 
    int 10h  

    mov ax, 0A000h ; lleva el 0 delante para no leer como una etiqueta
    mov es, ax ;mueve acumulador a segmento extra
    
    
    xor si, si 
    xor di, di
    
bucle:                               

    mov al, char
    mov es:[si], al               
    
    inc si 
    
    cmp si, 50       
    jz Vertical
    
       
    jnz bucle
    
Vertical:
    
    mov es:[si], al 
    
    add si, 320
    
    cmp si, 16050
    jz Retroceso  
    
    jnz Vertical 
    

Retroceso:
    
    mov es:[si], al
    
    dec si
    
    cmp si, 16000
    jz VerticalR
    
    jnz Retroceso    
    
    
VerticalR:  

    mov es:[si], al 
    
    sub si, 320
    
    cmp si, 0
    jz bucledi  
    
    jnz VerticalR 
    
    
    
bucledi:                               

    mov al, espacio
    mov es:[di], al               
    
    inc di 
    
    cmp di, 50       
    jz Verticaldi
    
       
    jnz bucledi
    
Verticaldi:
    
    mov es:[di], al 
    
    add di, 320
    
    cmp di, 16050
    jz Retrocesodi  
    
    jnz Verticaldi 
    

Retrocesodi:
    
    mov es:[di], al
    
    dec di
    
    cmp di, 16000
    jz VerticalRdi
    
    jnz Retrocesodi    
    
    
VerticalRdi:  

    mov es:[di], al 
    
    sub di, 320
    
    cmp di, 0 
    
    jnz VerticalRdi 
    
    
    mov si, 20   
    
bucle2:                               

    mov al, char
    mov es:[si], al               
    
    inc si 
    
    cmp si, 70       
    jz Vertical2
    
       
    jnz bucle2
    
Vertical2:
    
    mov es:[si], al 
    
    add si, 320
    
    cmp si, 16070
    jz Retroceso2  
    
    jnz Vertical2 
    

Retroceso2:
    
    mov es:[si], al
    
    dec si
    
    cmp si, 16020
    jz VerticalR2
    
    jnz Retroceso2    
    
    
VerticalR2:  

    mov es:[si], al 
    
    sub si, 320
    
    cmp si, 20
    jz Fin  
    
    jnz VerticalR2    
    
    
        
    
Fin:      
    
    mov ax,4c00h
	int 21h
END


