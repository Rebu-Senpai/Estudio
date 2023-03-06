.MODEL SMALL

.CODE 
	org 100h
 
Programa_Int: 
	
	JMP Reside 
	
	CONTADOR db 0  

Rutina_Servicio PROC 

	CLI 
	
	;XOR bx, bx		
	INC CONTADOR 
	 
	
	CMP CONTADOR, 91 ; 15 seg de programa
	JNZ FIN 
	
	MOV ah, 4ch
	int 21h
	
	
FIN:	 
	STI 
	IRET 

ENDP 
Reside: 

	MOV DX, offset Rutina_Servicio 
	
	MOV AX, 0  
	MOV ES, AX    

	MOV SI, 1Ch*4 
	CLI 
	MOV ES:[SI], DX 
	MOV ES:[SI+2], CS 
	STI 
	MOV DX, offset Reside 
	INT 27h    
	
END Programa_Int                               






