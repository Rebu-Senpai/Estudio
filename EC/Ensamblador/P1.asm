.MODEL SMALL

.STACK 100h

.DATA 	
    char db 5,?,5 dup(?) ; dejando una extra para enter 
    pesos db 8,4,2,1
    resultado db ?  
    resultado2 db ?
    signo2 db '+'      
    signo db '+'
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
    
    jz signo_cambia ;salta si es igual   
    mov signo,'-'            
        
    signo_cambia:
    
    mov ax, 0b800h ; lleva el 0 delante para no leer como una etiqueta
    mov es, ax ;mueve acumulador a segmento extra
    
    mov ah, 101b ; Cambia de color, Magenta
    
    mov al, 'B'
    MOV es:[260], ax
    mov al, 'N'
    mov es:[262], ax
    mov al, ':'
    mov es:[264], ax
    mov al, signo
    mov es:[266], ax
    mov al, resultado
    add al, 30h     	; Se le suma para que quede en codigo ascic el valor que queremos
    mov es:[268], ax
   
   ;Complemento C2:
    mov si, 5
    mov di, 3
    mov cx, 2
    
    Bucle:
      mov al, char[si]
      cmp al, 1
      jnz SINO 
      
      mov al, 0
      mul pesos[di]
      add resultado2,al 
      jmp fin
      
      SINO:
         mov al, 1
         mul pesos[di]
         add resultado2,al 
      fin:   
         dec di
         dec si
      
      loop Bucle
    
    mov al, 1
    add resultado2, al

    mov al, char[2]
    cmp al, 1
    jnz signo_cambia2
    mov signo2, '-'
     
    signo_cambia2:
    
    mov ax, 0b800h ; lleva el 0 delante para no leer como una etiqueta
    mov es, ax ;mueve acumulador a segmento extra
    
    mov ah, 011b ; Cambia de color, Magenta
    
    mov al, 'C'
    MOV es:[272], ax
    mov al, '2'
    mov es:[274], ax
    mov al, ':'
    mov es:[276], ax
    mov al, signo2
    mov es:[278], ax
    mov al, resultado2
    add al, 30h     	; Se le suma para que quede en codigo ascic el valor que queremos
    mov es:[280], ax  
     
	mov ax,4c00h
	int 21h
END    