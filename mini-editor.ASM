limpa:	MOV	AL,20	; Carrega em AL o caracter "0"
	MOV	BL,C0	; Carrega em BL o 1o. end. da mem. de v�deo
loop:	MOV	[BL],AL	; Copia o caracter em AL na mem. de v�deo
	CMP	BL,FF	;VERIFICA SE TA NO ULTIMO
	JZ	inseri	; Caso afirmativo salta para o fim do programa
	CMP	BL,F0	; Verifica se j� imprimiu na �ltima linha da mem. de v�deo
	JNS	sobeln	; Se j� imprimiu, volta � 1a. linha da mem. de v�deo
	ADD	BL,10	; Aponta para a linha abaixo da atual
	
	
	JMP	loop	; Volta para imprimir um novo caracter
sobeln: SUB	BL,2F	; Volta para a 1a. linha da mem. de v�deo
	
	JMP	loop	;teste 3

	
inseri:	MOV	BL,C0	;CERTIFICA QUE ESTA NO c0
letra:	IN	00
	CMP	AL,18	; Compara o valor lido do teclado com o ASCII do "Enter"
	JZ	fim	; finaliza com control+x
	CMP	AL,0D	; VERIFICA SE FOI DIGITADO ENTER
	JZ	enter	;manda pra enter
	CMP	AL,08	;VERIFICA SE DIGITOU BACKSPACE
	JZ	backs	;back space
	MOV	[BL],AL	;supostamente guarda na memoria de video
	CMP	BL,FF	;VERIFICA ULTIMO ESPA�O
	JZ	limpa	;come�a tudo dnv
	INC	BL	;PROXIMA CASA
	JMP	letra	; Volta para nova letra

enter:	cmp	bl,f0	; verifica se ta na linha f
	jns	entf0	;vai pra enter f0

	cmp	bl,e0	; verifica se ta na linha e
	jns	ente0	;vai pra enter e0

	CMP	BL,D0	;VERIFICA SE TA NA LINHA D	
	JNS	entd0	; enter na linha d

	CMP	BL,C0	;VERIFICA SE TA NA LINHA C
	Jns	entc0

	JMP	letra	;volta pra inserir
	;verifica��o do enter

entc0:	mov	BL,D0	;LINHA D0
	JMP	letra	; RETORNA PRA INSERIR

entd0:	mov	bl,e0	;	pula pra linha e
	jmp	letra	; volta pra letra

ente0:	mov	bl,f0	; linha f
	jmp	letra	; cansei de comentar essa linha ja 

entf0:	jmp	limpa	;	


backs:	cmp	bl,c0	;se tiver no c0 n�o faz nada
	jz	letra	; 

	sub	bl,01	;supostamente volta uma casa 
	mov	al,20	; imprime vazio/espa�o
	mov	[bl],al	;imprime na tela
	jmp	letra	; volta em letra

fim:	END
