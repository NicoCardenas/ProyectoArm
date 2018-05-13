.text
.global _start
_start:	MOV R0, #0 @ a = R0
		MOV R1, #0 @ b = R1
		MOV R2, #0 @ c = R2

		MOV R11, #0 @ x = R11
		MOV R12, #0 @ y = R12
		MOV R13, #0 @ count = R13

RAIZ:	MOV R11, R0 @ x = a
		MOV R12, #2 @ y = 2
		B 	DIV @ x div y
		MOV R1, R13 @ b = a div 2
		MUL	R2, R1, R1 @ c = b ^ 2
RLOOP:	CMP R2, R0 @ c < a
		BLT RLOOP2
		MOV R11, R1 @ x = b
		B 	DIV @ x div 2
		MOV R1, R13 @ b = b div 2
		MUL	R2, R1, R1 @ c = b ^ 2
		B 	RLOOP
RLOOP2:	CMP R2, R0 @ c != a
		BNE	FIN
		ADD R1, R1, #1 @ b += 1
		MUL R2, R1, R1 @ c = b ^ 2
		B RLOOP2

DIV:	CMP R11, R12 @ x < y
		BLLT PC 
		SUB R11, R11, R12 @ x -= y
		ADD R13, R13, #1 @ count += 1
		B 	DIV

FIN:	MOV R7, #1
		SVC 0
.end