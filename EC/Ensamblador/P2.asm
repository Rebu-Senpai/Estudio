.MODEL SMALL

.CODE 
	org 100h
 
Programa_Int: 
	
	JMP Reside 
	CONTADOR DB 0 
	CRONO DB '00:00' 

Rutina_Servicio PROC 

	CLI 		; Bloqueamos las interrupciones y cargamos los datos que estabamos usando en la Pila para salvarlos, posteriormente los liberaremos
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX

	INC CONTADOR 
	CMP CONTADOR, 18 
	JB FIN

	MOV CONTADOR, 0 
	MOV AX, 0B800h 

	MOV ES, AX 
	MOV AH, 00001111b 
	MOV SI, 0 
	MOV DI, 3988 ; Puse este valor para que saliera en la esquina inferior derecha
		     ; Me dio la mania ese dia

	INICIO: 

	MOV AL, CRONO[SI] 
	MOV ES:[DI], AX 
	ADD DI, 2 

	INC SI 
	CMP SI, 4 
	JBE INICIO 

	CMP CRONO[4], '9' 
	JNZ TIEMPO
 
	MOV CRONO[4], '0' 
	INC CRONO[3] 
	
	CMP CRONO[3], '6' 
	JNZ FIN 

	MOV CRONO[3], '0' 
	INC CRONO[1] 
	
	CMP CRONO[1], '9' 
	JNZ FIN 

	MOV CRONO[1], '0' 
	INC CRONO[0] 
	
	CMP CRONO[0], '6' 
	JNZ FIN 

	MOV CRONO[0], '0' 
	JMP FIN 
	
	TIEMPO: 
	INC CRONO[4]

		
	FIN:
	
	POP DX  ; Liberamos los datos que teniamos en la pila en el sentido contrario al que lo introducimos y liberamos las iterrupciones
	POP CX
	POP BX
	POP AX
	 
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

