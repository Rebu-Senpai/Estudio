.MODEL SMALL

.STACK 100h

.DATA

	char db 'x'
	espacio db ' '


.CODE

	mov ax, seg char
    mov ds, ax
    
    mov al, 03h 
    int 10h  

    mov ax, 0B800h ; lleva el 0 delante para no leer como una etiqueta
    mov es, ax ;mueve acumulador a segmento extra
    
    
    xor si, si 
    xor di, di
    
bucle:                               

    mov al, char
    mov es:[si], al               
    
    inc si 
    
    cmp si, 20       
    jz Vertical
    
       
    jnz bucle
    
Vertical:
    
    mov es:[si], al 
    
    add si, 160
    
    cmp si, 1460
    jz Retroceso  
    
    jnz Vertical 
    

Retroceso:
    
    mov es:[si], al
    
    dec si
    
    cmp si, 1440
    jz VerticalR
    
    jnz Retroceso    
    
    
VerticalR:  

    mov es:[si], al 
    
    sub si, 160
    
    cmp si, 0
    jz bucledi  
    
    jnz VerticalR 
    
    
    
bucledi:                               

    mov al, espacio
    mov es:[di], al               
    
    inc di 
    
    cmp di, 20       
    jz Verticaldi
    
       
    jnz bucledi
    
Verticaldi:
    
    mov es:[di], al 
    
    add di, 160
    
    cmp di, 1460
    jz Retrocesodi  
    
    jnz Verticaldi 
    

Retrocesodi:
    
    mov es:[di], al
    
    dec di
    
    cmp di, 1440
    jz VerticalRdi
    
    jnz Retrocesodi    
    
    
VerticalRdi:  

    mov es:[di], al 
    
    sub di, 160
    
    cmp di, 0 
    
    jnz VerticalRdi 
    
    
    mov si, 2   
    
bucle2:                               

    mov al, char
    mov es:[si], al               
    
    inc si 
    
    cmp si, 22       
    jz Vertical2
    
       
    jnz bucle2
    
Vertical2:
    
    mov es:[si], al 
    
    add si, 160
    
    cmp si, 1462
    jz Retroceso2  
    
    jnz Vertical2 
    

Retroceso2:
    
    mov es:[si], al
    
    dec si
    
    cmp si, 1442
    jz VerticalR2
    
    jnz Retroceso2    
    
    
VerticalR2:  

    mov es:[si], al 
    
    sub si, 160
    
    cmp si, 2
    jz Fin  
    
    jnz VerticalR2    
    
    
        
    
Fin:      
    
    mov ax,4c00h
	int 21h
END


