[org 100h]

[section .bss]
	;degree resw 1
	oldcw resw 1
	newcw resw 1
	itern resw 1

[section .data]
	welcome DB '//////////////////////////// Practica 1 - 200615067 \\\\\\\\\\\\\\\\\\\\\\\\\\\\',0DH,0AH,'$'
	msjnewt DB '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ METODO DE NEWTON @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@',0DH,0AH,'$'
	msjmull DB '^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ METODO DE MULLER ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^',0DH,0AH,'$'
	msjstef DB '&&&&&&&&&&&&&&&&&&&&&&&&&&&&& METODO DE STEFFENSEN &&&&&&&&&&&&&&&&&&&&&&&&&&&&&',0DH,0AH,'$'
	msjslin DB 0DH,0AH,'________________________________________________________________________________',0DH,0AH,'$'
	msjiter DB 'ITERACION # $'
	msjerr DB 'ERROR: $'
	msjxin DB 'VALOR INICIAL Xn = $'
	msjres DB 'VALOR Xn+1 = $'
	msjfin DB 'La solucion es Xn = $'
	msjfer DB ' con un error de $'
	Mensaje  DB   'Escriba el coeficiente ( Entre -99 y 99) para X^$'
	msjniter  DB   'Ingrese el numero de iteraciones para este metodo (formato ## ): $'
	msjntol  DB   'Ingrese la base de la tolerancia (formato # ): $'
	msjnexp  DB   'Ingrese la exponente de la tolerancia (formato # ): 10^-$'
	msjntolf DB	'La tolerancia minima es de: $'
	pts DB ': $'
	jline DB 0DH,0AH,'$'
	num DW 0
	minsign DB '-$'
	plusign DB '+$'
	dotsign DB '.$'
	varsign DW 0
	x1 DB 'X $'
	x2 DB 'X^2 $'
	x3 DB 'X^3 $'
	x4 DB 'X^4 $'
	x5 DB 'X^5 $'
	msjA DB 'VALOR X1: $'
	msjB DB 'VALOR X2: $'
	msjC DB 'VALOR X3: $'
	temp DD 0
	tmpd DD 1.0
	tdec DW 5
	
	msj0 DB 'Ingrese el numero de la opcion que desea, o presione ESC para salir: ',0DH,0AH,'$'
	msj1 DB '	{1} Ingresar los coeficientes de la funcion ',0DH,0AH,'$'
	msj2 DB '	{2} Imprimir la funcion almacenada ',0DH,0AH,'$'
	msj3 DB '	{3} Imprimir derivada de la funcion almacenada ',0DH,0AH,'$'
	msj4 DB '	{4} Graficar la funcion ',0DH,0AH,'$'
	msj5 DB '	{5} Metodo de Newton ',0DH,0AH,'$'
	msj6 DB '	{6} Metodo de Steffensen ',0DH,0AH,'$'
	msj7 DB '	{7} Metodo de Muller ',0DH,0AH,'$'
	msj8 DB '	{8} Salir de la Aplicacion ',0DH,0AH,'$'
	msjdeg DB 'Ingrese el grado de la funcion (0 - 5)',0DH,0AH,'$'
	msjfun DB 'La funcion almacenada es f(x) = ',0DH,0AH,'$'
	msjder DB 'La derivada de la funcion almacenada f',39,'(x) = ',0DH,0AH,'$'
	msjsign DB 'Ingrese el signo del numero que desea ingresar',0DH,0AH,'$'
	msjlimit DB 'Ingrese el valor que desea ingresar al limite: Formato ( ## )$'
	msjlinf DB ' LIMITE INFERIOR $'
	msjlsup DB ' LIMITE SUPERIOR $'
	msja DB ' VALOR A $'
	msjb DB ' VALOR B $'
	msjc DB ' VALOR C $'
	msj  DB   '@$'
	Escrito  DB   10, 13, 'Escribiste: $'
	Bufer    DB   3                         
		   RESB 1                         
		   RESB 2                        
	x    dw    160
	y    dw    100
	var dw 0
	rvar dt 0.0
	rval dt 0.0
	rval2 dt 0.0
	rvalxn dt 0.0
	rder dt 0.0
	rtmp dt 0.0
	zero dt 0.0
	var0 dw 0
	var1 dw 0
	var2 dw 0
	var3 dw 0
	var4 dw 0
	var5 dw 0

	dvar2 dw 2
	dvar3 dw 3
	dvar4 dw 4
	dvar5 dw 5
	
	degree db 0
	nsign dw 1
	
	iter dw 0
	tol dt 0.00005
	linf dw 0
	lsup dw 0
	xn dt 0.0
	tvar dt 0.0
	a dw 0
	b dw 0
	c dw 0
	A dt 0.0
	B dt 0.0
	C dt 0.0
	h0 dt 0.0
	h1 dt 0.0
	d0 dt 0.0
	d1 dt 0.0
	pa dt 0.0
	pb dt 0.0
	pc dt 0.0
	root dt 0.0
	fx0 dt 0.0
	fx1 dt 0.0
	fx2 dt 0.0
	D dt 0.0
	den dt 0.0
	
	%macro clrscr 2
		mov dx, 0 
		mov bh, 0
		mov ah, 2h
		int 10h
		mov cx, 3000 
		mov bh, 0
		mov bl, %1 
		mov al, %2
		mov ah, 9h
		int 10h
	%endmacro
	
	%macro read2num 0
		XOR AX,AX
		INT 16H
		SUB AL,48
		MOV BL,10
		MUL BL
		CBW
		MOV WORD[var],AX

		XOR AX,AX
		INT 16H
		SUB AL,48
		CBW
		ADD WORD[var],AX
	%endmacro

	%macro read1num 0
		XOR AX,AX
		INT 16H
		SUB AL,48
		CBW
		MOV WORD[var],AX
	%endmacro
	
	%macro readchar 0
		XOR AH,AH								
		int 16h
	%endmacro
	
	%macro write 1
		push dx
		push ax			; preservar ax 
		mov dx,%1
    	mov ah,9h      	; funcion 9, imprimir en pantalla
    	int 21h         	; interrupcion dos
		pop ax			; restaurar ax
		pop dx
	%endmacro
		
	%macro writej 0
		push dx
		push ax			; preservar ax 
		mov dx,jline
    	mov ah,9h     	; funcion 9, imprimir en pantalla
    	int 21h         	; interrupcion dos
		pop ax			; restaurar ax
		pop dx
	%endmacro
	
[section .text] 
_start:
	_menu:
	clrscr 21h,20h
	write welcome
	write msj0
	write msj1
	write msj2
	write msj3
	write msj4
	write msj5
	write msj6
	write msj7
	write msj8
	readchar
	CMP AL,'1'
	je _intro
	CMP AL,'2'
	je _printfunc
	CMP AL,'3'
	je _printder
	CMP AL,'4'
	je _plot
	CMP AL,'5'
	je _newton
	CMP AL,'6'
	je _steffensen
	CMP AL,'7'
	je _muller
	CMP AL,'8'
	je _end
	CMP AL,27
	je _end
	jmp _menu
	;-----------------------------------------------------------------------------------------------------;
	;Aqui se pregunta el grado de la funcion, que va desde 0 a 5 a lo sumo
	_intro:
		MOV WORD[var0],0
		MOV WORD[var1],0
		MOV WORD[var2],0
		MOV WORD[var3],0
		MOV WORD[var4],0
		MOV WORD[var5],0
		write msjdeg
		readchar
		SUB AL,48
		MOV BYTE[degree],AL
		CBW
		MOV CX,AX
		;Comparaciones, para verificar que no se ingresen ASCII extranios
		CMP AL,0
		JL _intro
		CMP AL,5
		JG _intro	
	;---------------------------------------------------------------------------------------------------;
	;Este ciclo me va preguntar los coeficientes dependiendo del grado que halla ingresado
	$_BucleNum: 
	;En esta parte voy a preguntar el signo del numero a ingresar
		_asksign:   
		PUSH CX
		write msjsign
		readchar
		CMP AL,'-'
		JNE _pos
			MOV WORD[nsign],-1
			jmp _endsign
		_pos:
		CMP AL,'+'
		JNE _ent
			MOV WORD[nsign],1
			jmp _endsign
		_ent:
		CMP AL,13
		JNE _serr
			MOV WORD[nsign],1
			jmp _endsign
		_serr:
			jmp _asksign
		_endsign:
		
		;Imprime el mensaje que pregunta por el coeficiente de la variable dada
		_askcoef:
		write Mensaje
		MOV AX,CX
		CALL _intascii
		write pts
		MOV      DX, Bufer                      ; Dirección del Bufer
		MOV      AH, 0Ah                        ; función A entrada en búfer
		INT      21h                            ; Llama a la func.ión
		write Escrito                           ; Escribe el mensaje por pantalla

		MOV      SI, Bufer + 1
		MOV      CL, BYTE [SI]
		
		MOV WORD[num],0
		CMP WORD[nsign],1
		JE $_Bucle
		write minsign
		$_Bucle:
			MOV      AH, 6h       ; Función escribir carácter
			INC      SI
			MOV      DL, BYTE [SI]
			INT      21h                ; Dirección del mensaje
			CMP CL,0
			JE _end
			SUB DL,48		
			XOR DH,DH
			MOV BX,DX
			JMP _convert
			_conv:
		LOOP     $_Bucle
		MOV BX,WORD[num]
		IMUL BX,WORD[nsign]
		MOV WORD[num],BX
		writej
		POP CX
		DEC CX
	MOV BX,WORD[num]
	_v5:
		CMP CX,4
		JNE _v4
		MOV WORD[var5],BX
	_v4:
		CMP CX,3
		JNE _v3
		MOV WORD[var4],BX
	_v3:
		CMP CX,2
		JNE _v2
		MOV WORD[var3],BX
	_v2:
		CMP CX,1
		JNE _v1
		MOV WORD[var2],BX
	_v1:
		CMP CX,0
		JNE _v0
		MOV WORD[var1],BX
	_v0:
		CMP CX,0
		JGE $_BucleNum
		MOV WORD[var0],BX
		JMP _start
	; Volvemos al DOS
	_end:
	clrscr 09h,20h
	MOV      AX, 4C00h                      ; Servicio 4Ch,mensaje 0
	INT      21h                            ; volvemos al DOS
	
	;---------------------------------------------------------------------------------------------------------------------------------------------------------
	;METODO PARA CONVERTIR ENTEROS A CADENAS
	_intascii:
		push cx
		mov bx, 10
		xor cx,cx
		test AX,8000h
		JZ _loopini
		write minsign
		imul AX,-1
		JMP _loophere
		_loopini:
		MOV DX,WORD[varsign]
		CMP DX,0
		JE _loophere
		write plusign
		_loophere:
			XOR DX,DX
			idiv bx
			INC CX
			add dl, '0'
			push dx
			cmp ax, 0
		jnz _loophere
		
		_printc:
			pop dx
			mov ah,2  
			int 21h 
		loop _printc
		pop cx
		ret
	;---------------------------------------------------------------------------------------------------------------------------------------------------------
	
	;---------------------------------------------------------------------------------------------------------------------------------------------------------
	;METODO PARA CONVERTIR DOBLES A CADENAS
	_floatascii:
		push cx
		mov bx, 10
		xor cx,cx
		test EAX,80000000h
		JZ _floopini
		write minsign
		imul EAX,-1
		JMP _floophere
		_floopini:
		MOV DX,WORD[varsign]
		CMP DX,0
		JE _floophere
		write plusign
		_floophere:
			XOR DX,DX
			idiv bx
			INC CX
			add dl, '0'
			push dx
			cmp ax, 0
		jnz _floophere
		
		_fprintc:
			pop dx
			mov ah,2  
			int 21h 
		loop _fprintc
		pop cx
		ret
	;---------------------------------------------------------------------------------------------------------------------------------------------------------
	
	_realascii:
		MOV WORD[num],10
		FSTCW WORD[oldcw]              
		FWAIT		  
		MOV ax,WORD[oldcw]
		OR ax,0C00h  
		MOV WORD[newcw],ax
		FLDCW [newcw]  
		
		FSTP TWORD[rtmp]
		FLD TWORD[rtmp]
		FABS
		FLD TWORD[rtmp]
		FDIV
		FIST WORD[nsign]
		CMP WORD[nsign],1
		JE _printr
		write minsign
		
		_printr:
		FLD TWORD[rtmp]
		FABS
		FIST DWORD[temp] ;almaceno el valor entero en la variable temp
		XOR EAX,EAX 	;limpio AX
		MOV EAX,DWORD[temp] 	; mi metodo de impresion requiere cargar el numero a AX
		call _floatascii     ;llamo mi metodo de impresion. IMPRIME '14'
		write dotsign    ;write es mi macro de escritura, imprime un dotsign, una var con '.', en la pantalla
		FISUB DWORD[temp] ; extraigo el valor entero de st(0), queda 0.28571428571428571428571428571
		MOV CX,WORD[tdec] 
		_printdec:
			CMP CX,1
			JNE _printtrun
			FLDCW [oldcw]
			_printtrun:
			FIMUL WORD[num]
			FABS 
			FIST WORD[var]
			MOV DX,WORD[var]
			ADD DX,'0'
			MOV AL,9h
			INT 21h
			FISUB WORD[var]
		LOOP _printdec
		FLDCW [oldcw]
	ret
	
	_derivefpu:
		FINIT
		PUSH CX
		MOV WORD[num],0
		
		
		FILD word[var1]
		
		FLD TWORD[rvar]
		FILD WORD[var2]
		FILD WORD[dvar2]
		FMUL
		FMUL
		FADD
		
		MOV CX,1
		CALL _expfpu
		FILD WORD[var3]
		FILD WORD[dvar3]
		FMUL
		FMUL
		FADD
		
		MOV CX,2
		CALL _expfpu
		FILD WORD[var4]
		FILD WORD[dvar4]
		FMUL
		FMUL
		FADD
		
		MOV CX,3
		CALL _expfpu
		FILD WORD[var5]
		FILD DWORD[dvar5]
		FMUL
		FMUL
		FADD
		
		POP CX
	ret
	
	_evaluarfpu:
		FINIT
		PUSH CX
		MOV DWORD[temp],0
		FILD WORD[var0]
		
		FLD TWORD[rvar]
		FILD WORD[var1]
		FMUL
		FADD
		
		MOV CX,1
		CALL _expfpu
		FILD WORD[var2]
		FMUL
		FADD
		
		MOV CX,2
		CALL _expfpu
		FILD WORD[var3]
		FMUL
		FADD
		
		MOV CX,3
		CALL _expfpu
		FILD WORD[var4]
		FMUL
		FADD
		
		MOV CX,4
		CALL _expfpu
		FILD WORD[var5]
		FMUL
		FADD
		
		FIST DWORD[temp]
		FILD DWORD[temp]
		FABS
		FISTP DWORD[temp]
		
		MOV WORD[num],101
		MOV EAX,DWORD[temp]
		test EAX,8000h
		JNZ _overflow
		FIST WORD[num]
		_overflow:
		POP CX
	ret
	
	_expfpu:
		FLD TWORD[rvar]
		_loopexpf:
			FLD TWORD[rvar]
			FMUL
		LOOP _loopexpf
	ret
	
	_plot:
		call _graficar
	JMP _start
	
	_setup:
		write msjniter
		read2num
		MOV AX,WORD[var]
		MOV WORD[iter],AX
		CALL _intascii
		writej
		write msjntol
		read1num
		FINIT
		FILD WORD[var]
		MOV AX,WORD[var]
		CALL _intascii
		writej
		write msjnexp
		read1num
		MOV AX,WORD[var]
		MOV CX,WORD[var]
		CALL _intascii
		writej
		write msjntolf
		_iniexp:
			CMP CX,0
			JLE _endexp
			MOV WORD[var],10
			FLD1
			FILD WORD[var]
			FDIV
			FMUL
			DEC CX
			JMP _iniexp
		_endexp:
		FSTP TWORD[tol]
		FLD TWORD[tol]
		CALL _realascii
		writej
	ret
	
	_setuplimit:
		_asksignl:   
		PUSH CX
		write msjsign
		readchar
		CMP AL,'-'
		JNE _posl
			MOV WORD[nsign],-1
			jmp _endsignl
		_posl:
		CMP AL,'+'
		JNE _entl
			MOV WORD[nsign],1
			jmp _endsignl
		_entl:
		CMP AL,13
		JNE _lerr
			MOV WORD[nsign],1
			jmp _endsignl
		_lerr:
			jmp _asksignl
		_endsignl:
		write msjlimit
		read2num
		MOV BX,WORD[var]
		IMUL BX, WORD[nsign]
		MOV WORD[num],BX
		MOV AX,BX
		CALL _intascii
		POP CX
		INC CX
		CMP WORD[itern],0
		JE _newtonini
		CMP WORD[itern],1
		JE _steffini
		CMP WORD[itern],2
		JE _mullini
		
		
	_newton:
		CALL _setup
		XOR CX,CX
		MOV WORD[itern],0
		JMP _setuplimit
		_newtonini:
			CMP CX,1
			JNE _newtoncont
			MOV BX,WORD[num]
			MOV WORD[lsup],BX
			write msjlsup
			writej
			JMP _setuplimit
		_newtoncont:
			MOV BX,WORD[num]
			MOV WORD[linf],BX
			write msjlinf
			writej
		readchar
		
		clrscr 12h,20h
		write msjnewt
		;---------------------------------------------------------------------------------------------
		; MOV WORD[iter],10
		; MOV WORD[linf],-2
		; MOV WORD[lsup],-1
		; MOV WORD[var0],4
		; MOV WORD[var1],4
		; MOV WORD[var2],-4
		; MOV WORD[var3],-2
		; MOV WORD[var4],1
		;---------------------------------------------------------------------------------------------
		XOR ECX,ECX
		MOV CX,1
		FINIT
		FWAIT
		MOV WORD[var],2
		FILD WORD[lsup]
		FILD WORD[lsup]
		FILD WORD[linf]
		FSUB
		FILD WORD[var]
		FDIV
		FSUB
		FSTP TWORD[rvar]
		FSTP TWORD[rtmp]
		
		_iternew:
			write msjiter
			MOV AX,CX
			PUSH CX
			call _intascii
			writej
			FINIT
			FWAIT
			FLD TWORD[rvar]
			write msjxin
			call _realascii
			writej
			
			CALL _evaluarfpu
			FSTP TWORD[rval]
			FLD TWORD[rval]
			;call _realascii
			;writej
			
			CALL _derivefpu
			FSTP TWORD[rder]
			FLD TWORD[rder]
			;call _realascii
			;writej

			FINIT
			FLD TWORD[rval]
			FLD TWORD[rder]
			FDIV
			FSTP TWORD[rval]
			FLD TWORD[rval]
			write msjerr
			call _realascii
			writej
			
			FLD TWORD[rvar]
			FLD TWORD[rval]
			FSUB
			FSTP TWORD[rvar]
			FLD TWORD[rvar]
			write msjres
			call _realascii
			
			write msjslin
			readchar
			FINIT
			FLD TWORD[tol]
			FLD TWORD[rval]
			FABS
			POP CX
			INC CX
			FCOM st0,st1
			FSTSW AX
			SAHF
			JBE _resnew
			CMP CX,WORD[iter]
			JLE _iternew
		_resnew:
			call _printres
	JMP _start
	
	_muller:
		CALL _setup
		XOR CX,CX
		MOV WORD[itern],2
		JMP _setuplimit
		 _mullini:
			CMP CX,1
			JNE _mullcont
			MOV BX,WORD[num]
			MOV WORD[a],BX
			write msja
			writej
			JMP _setuplimit
		_mullcont:
			CMP CX,2
			JNE _mullcont2
			MOV BX,WORD[num]
			MOV WORD[b],BX
			write msjb
			writej
			JMP _setuplimit
		_mullcont2:
			MOV BX,WORD[num]
			MOV WORD[c],BX
			write msjc
			writej
		readchar
		
		;---------------------------------------------------------------------------------------------
		; MOV WORD[iter],2
		; MOV WORD[a],-1
		; MOV WORD[b],-2
		; MOV WORD[c],-3
		; MOV WORD[var0],4
		; MOV WORD[var1],4
		; MOV WORD[var2],-4
		; MOV WORD[var3],-2
		; MOV WORD[var4],1
		;---------------------------------------------------------------------------------------------
		
		clrscr 34h,20h
		write msjmull
		
		FINIT
		FILD WORD[a]
		FSTP TWORD[A]
		FILD WORD[b]
		FSTP TWORD[B]
		FILD WORD[c]
		FSTP TWORD[C]
		MOV CX,1
		
		_itermull:
			write msjiter
			MOV AX,CX
			PUSH CX
			call _intascii
			writej
			FINIT
			FLD TWORD[B]
			FLD TWORD[A]
			FSUB
			FSTP TWORD[h0]
			
			FINIT
			FLD TWORD[C]
			FLD TWORD[B]
			FSUB
			FSTP TWORD[h1]
			
			FINIT
			FLD TWORD[B]
			FSTP TWORD[rvar]
			CALL _evaluarfpu
			FSTP TWORD[fx1]
			
			
			FINIT
			FLD TWORD[A]
			FSTP TWORD[rvar]
			CALL _evaluarfpu
			FSTP TWORD[fx0]
			
			FINIT
			FLD TWORD[C]
			FSTP TWORD[rvar]
			CALL _evaluarfpu
			FSTP TWORD[fx2]
			
			FINIT
			FLD TWORD[fx1]
			FLD TWORD[fx0]
			FSUB
			FLD TWORD[h0]
			FDIV
			FSTP TWORD[d0]
			
			FINIT
			FLD TWORD[fx2]
			FLD TWORD[fx1]
			FSUB
			FLD TWORD[h1]
			FDIV
			FSTP TWORD[d1]

			FINIT
			FLD TWORD[d1]
			FLD TWORD[d0]
			FSUB
			FLD TWORD[h1]
			FLD TWORD[h0]
			FADD
			FDIV
			FSTP TWORD[pa]
			
			FINIT
			FLD TWORD[pa]
			FLD TWORD[h1]
			FMUL
			FLD TWORD[d1]
			FADD
			FSTP TWORD[pb]
			
			FINIT
			FLD TWORD[fx2]
			FSTP TWORD[pc]
			
			FINIT
			FLD TWORD[pb]
			FLD TWORD[pb]
			FMUL
			MOV WORD[num],4
			FILD WORD[num]
			FLD TWORD[pa]
			FMUL
			FLD TWORD[pc]
			FMUL
			FSUB
			FSQRT
			FSTP TWORD[root]
			
			FINIT
			FLD TWORD[pb]
			FLD TWORD[root]
			FSUB
			FABS
			FLD TWORD[pb]
			FLD TWORD[root]
			FADD
			FABS
			
			FCOM st0,st1
			FSTSW AX
			SAHF
			JA _den
			FSTP TWORD[den]
			_den:
			FSTP TWORD[den]
			FLD TWORD[den]
			CALL _realascii
			write msj
			writej
			
			FINIT
			FLD TWORD[B]
			MOV WORD[num],2
			FILD WORD[num]
			FLD TWORD[C]
			FMUL
			FLD TWORD[den]
			FDIV
			FSUB
			FSTP TWORD[D]
			FLD TWORD[D]
			CALL _realascii
			write msj
			writej
			
			FINIT
			FLD TWORD[B]
			FSTP TWORD[A]
			FLD TWORD[C]
			FSTP TWORD[B]
			FLD TWORD[D]
			FSTP TWORD[C]
			FLD TWORD[D]
			FSTP TWORD[rvar]
			CALL _evaluarfpu
			FSTP TWORD[rval]
			FLD TWORD[rval]
			write msjerr
			call _realascii
			writej
			
			FLD TWORD[rvar]
			write msjres
			call _realascii
			write msjslin
			readchar
			
			POP CX
			INC CX
			
			CMP CX,WORD[iter]
			JLE _itermull
			
		call _printres
		JMP _start
	
	
	_steffensen:
		CALL _setup
		XOR CX,CX
		MOV WORD[itern],1
		JMP _setuplimit
		_steffini:
			CMP CX,1
			JNE _steffcont
			MOV BX,WORD[num]
			MOV WORD[lsup],BX
			write msjlsup
			writej
			JMP _setuplimit
		_steffcont:
			MOV BX,WORD[num]
			MOV WORD[linf],BX
			write msjlinf
			writej
		readchar
		
		
		clrscr 43h,20h
		write msjstef
		;---------------------------------------------------------------------------------------------
		;MOV WORD[iter],10
		; MOV WORD[linf],-2
		; MOV WORD[lsup],-1
		; MOV WORD[var0],4
		; MOV WORD[var1],4
		; MOV WORD[var2],-4
		; MOV WORD[var3],-2
		; MOV WORD[var4],1
		;---------------------------------------------------------------------------------------------
		XOR ECX,ECX
		MOV CX,1
		FINIT
		FWAIT
		MOV WORD[var],2
		FILD WORD[lsup]
		FILD WORD[lsup]
		FILD WORD[linf]
		FSUB
		FILD WORD[var]
		FDIV
		FSUB
		FSTP TWORD[rvar]
		FLD TWORD[rvar]
		FSTP TWORD[tvar]
		
		_iterste:
			write msjiter
			MOV AX,CX
			PUSH CX
			call _intascii
			writej
			FINIT
			FWAIT
			FLD TWORD[rvar]
			write msjxin
			call _realascii
			writej
			
			CALL _evaluarfpu
			FSTP TWORD[rval]
			
			CALL _derivefpu
			FSTP TWORD[rder]

			FINIT
			FLD TWORD[rval]
			FLD TWORD[rder]
			FDIV
			FSTP TWORD[rval]
			
			FLD TWORD[rvar]
			FLD TWORD[rval]
			FSUB
			FSTP TWORD[rvar]
			
			CALL _evaluarfpu
			FSTP TWORD[rval]
			FLD TWORD[rval]
			
			CALL _derivefpu
			FSTP TWORD[rder]
			FLD TWORD[rder]

			FINIT
			FLD TWORD[rval]
			FLD TWORD[rder]
			FDIV
			FSTP TWORD[rval]
			
			FLD TWORD[rvar]
			FLD TWORD[rval]
			FSUB
			FSTP TWORD[rval]
			
			MOV word[var],-2
			FINIT
			FLD TWORD[rvar]
			FIMUL WORD[var]
			FLD TWORD[rval]
			FADD
			FLD TWORD[tvar]
			FADD
			FSTP TWORD[rval]
			FLD TWORD[rval]
			;call _realascii
			;writej
			
			FINIT
			FLD TWORD[rvar]
			FLD TWORD[tvar]
			FSUB
			FMUL ST0,ST0
			FLD TWORD[rval]
			FDIV
			FSTP TWORD[rval]
			FLD TWORD[rval]
			write msjerr
			call _realascii
			writej
			
			FLD TWORD[tvar]
			FLD TWORD[rval]
			FSUB
			FSTP TWORD[rvar]
			FLD TWORD[rvar]
			FLD TWORD[rvar]
			FSTP TWORD[tvar]
			write msjres
			call _realascii
			write msjslin
			readchar
			
			FINIT
			FLD TWORD[tol]
			FLD TWORD[rval]
			FABS
			;call _realascii
			;write msjslin
			POP CX
			INC CX
			FCOM st0,st1
			FSTSW AX
			SAHF
			JBE _resste
			CMP CX,WORD[iter]
			JLE _iterste
		_resste:
			call _printres
		JMP _start
	
	_printres:
		write msjfin
		FLD TWORD[rvar]
		CALL _realascii
		write msjfer
		FLD TWORD[rval]
		CALL _realascii
		writej
		readchar
	ret
	
		_printfunc:
		writej
		write msjfun
		MOV WORD[varsign],1
		MOV AX,WORD[var5]
		CMP AX,0
		JE _pv4
		CALL _intascii
		write x5
		_pv4:
			MOV AX,WORD[var4]
			CMP AX,0
			JE _pv3
			CALL _intascii	
			write x4
		_pv3:
			MOV AX,WORD[var3]
			CMP AX,0
			JE _pv2
			CALL _intascii
			write x3
		_pv2:
			MOV AX,WORD[var2]
			CMP AX,0
			JE _pv1
			CALL _intascii
			write x2
		_pv1:
			MOV AX,WORD[var1]
			CMP AX,0
			JE _pv0
			CALL _intascii
			write x1
		_pv0:
			MOV AX,WORD[var0]
			CALL _intascii
		MOV WORD[varsign],0
		writej
		readchar
	JMP _menu
	
	_printder:
		writej
		write msjder
		MOV WORD[varsign],1
		MOV AX,WORD[var5]
		CMP AX,0
		JE _$pv3
		FINIT
		FILD WORD[var5]
		FILD WORD[dvar5]
		FIST WORD[var]
		MOV AX,WORD[var]
		CALL _intascii
		write x4
		_$pv3:
			MOV AX,WORD[var4]
			CMP AX,0
			JE _$pv2
			FINIT
			FILD WORD[var4]
			FILD WORD[dvar4]
			FMUL
			FIST WORD[var]
			MOV AX,WORD[var]
			CALL _intascii
			write x3
		_$pv2:
			MOV AX,WORD[var3]
			CMP AX,0
			JE _$pv1
			FINIT
			FILD WORD[var3]
			FILD WORD[dvar3]
			FMUL
			FIST WORD[var]
			MOV AX,WORD[var]
			CALL _intascii
			write x2
		_$pv1:
			MOV AX,WORD[var2]
			CMP AX,0
			JE _$pv0
			FINIT
			FILD WORD[var2]
			FILD WORD[dvar2]
			FMUL
			FIST WORD[var]
			MOV AX,WORD[var]
			CALL _intascii
			write x1
		_$pv0:
			MOV AX,WORD[var1]
			CALL _intascii
		MOV WORD[varsign],0
		writej
		readchar
	JMP _menu
	
	
	_convert:
		push ax
		push cx
		push dx	
		DEC CL
		cmp CL,0
		je _endex
		cmp CL,1
		je _add1
	_buclexp:
		imul BX,10
		loop _buclexp
		jmp _endex
	_add1:
		imul BX,10
	_endex:
		add bx,word[num]
		mov word[num],bx

		pop dx	
		pop cx
		pop ax
	JMP _conv
	
  _graficar:
	push ax
	push bx
	push cx
	push dx
	mov    ax,13h    ;    move the number of the mode to ax
	int    10h    ;    and enter the mode using int 10h

	mov    ax,0a000h;    you cant move a value directly to es
	mov    es,ax    ;    move the screenadress to es

	mov cx,319
	putpixelv:
		mov bx,[y]
		imul bx,320
		add bx,cx
		mov    di,bx;        
		mov    al,50    ;    
		mov    [es:di],al;    
		LOOP putpixelv

	mov cx,200
	putpixelh:
		mov bx,cx
		imul bx,320
		add bx,160
		mov    di,bx;       
		mov    al,45       
		mov    [es:di],al  
		LOOP putpixelh

	MOV CX,15900
	putpixelp:
		MOV Word[num],100
		MOV WORD[var],CX
		FINIT
		FILD WORD[var]
		FILD WORD[num]
		FDIV
		FIST WORD[var]
		FSTP TWORD[rvar]
		MOV WORD[num],0
		call _evaluarfpu
		XOR BX,BX
		CMP WORD[num],100
		JG _noprintp
		CMP WORD[num],-100
		JL _noprintp
		mov bx,WORD[num]
		imul bx,-1
		add bx, 100
		imul bx,320
		add bx,WORD[var]
		add bx,160
		mov    di,bx       
		mov    al,55     
		mov    [es:di],al
		_noprintp:
		DEC CX
		CMP CX,0
	JGE putpixelp
	
	MOV CX,15900
	putpixelm:
		MOV Word[num],100
		MOV BX,CX
		IMUL BX,-1
		MOV WORD[var],BX
		FINIT
		FILD WORD[var]
		FILD WORD[num]
		FDIV
		FIST WORD[var]
		FSTP TWORD[rvar]
		MOV WORD[num],0
		call _evaluarfpu
		XOR BX,BX
		CMP WORD[num],100
		JG _noprintm
		CMP WORD[num],-100
		JL _noprintm
		mov bx,WORD[num]
		imul bx,-1
		add bx, 100
		imul bx,320
		add bx,WORD[var]
		add bx,160
		mov    di,bx;        and the calculated offset to di
		mov    al,55    ;    and the colorbyte to al
		mov    [es:di],al;    finally move the pixel to the screen
		_noprintm:
		DEC CX
		CMP CX,0
	JGE putpixelm
	
	
	_quit:
		mov ah,0        ;readkey
		int 22            ;call BIOS for readkey
		mov ah,00        ;setting up ax to go back to text
		mov al,03        
		int 10h  
	
		pop dx
		pop cx
		pop bx
		pop ax
	
	ret
	
	JMP _start
  
