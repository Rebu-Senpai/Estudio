.MODEL SMALL

.STACK 100h

.DATA

	char db 'x'


.CODE

	mov ax, seg char
    mov ds, ax
    
    mov al, 13h
    mov ah, 00h 
    int 10h  

    mov ax, 0A000h ; lleva el 0 delante para no leer como una etiqueta
    mov es, ax ;mueve acumulador a segmento extra
    
    mov bx, 50
    xor si, si 
    mov di, 50

    jmp bucle

SumaV:
    
    add bx, 16000
    jmp Vertical

RestaV:
    sub bx, 16000
    jmp VerticalR
    
Suma: 
    add bx, 50
    jmp bucle
    
Resta:
    sub bx, 50
    jmp Retroceso

    
Inicio:
    add di, 10
    mov bx, di  
 
   
bucle:                               

    mov al, char
    mov es:[si], al               
    
    inc si 
    
    cmp si, bx       
    jz SumaV
    
       
    jnz bucle
    
Vertical:
    
    mov es:[si], al 
    
    add si, 320
    
    cmp si, bx
    jz Resta  
    
    jnz Vertical 
    

Retroceso:
    
    mov es:[si], al
    
    dec si
    
    cmp si, bx
    jz RestaV
    
    jnz Retroceso    
    
    
VerticalR:  

    mov es:[si], al 
    
    sub si, 320
    
    cmp si, bx
    
    jnz VerticalR
 
    
    jmp Inicio
     
    
    mov ax,4c00h
	int 21h
END


