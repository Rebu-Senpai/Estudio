.MODEL SMALL

.STACK 100h

.DATA 
	
    cadena db 5, 0, 0, 0, 0, 0 

.CODE
    
    mov ax, seg cadena
    mov ds, ax