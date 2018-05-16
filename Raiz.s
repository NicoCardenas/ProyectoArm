.text
.global _start
_start:	MOV R0, #150 @ a = R0
		MOV R1, #0 @ b = R1
		MOV R2, #0 @ c = R2

		MOV R10, #0 @ x = R10
		MOV R11, #0 @ y = R11
		MOV R12, #0 @ count = R12

RAIZ:	MOV R10, R0 @ x = a
		MOV R11, #2 @ y = 2
		MOV R12, #0 @ count = 0
		BL 	DIV @ x div y
		MOV R1, R12 @ b = a div 2
		MUL	R2, R1, R1 @ c = b ^ 2
RLOOP:	CMP R2, R0 @ c > a
		BLT RLOOP2
		MOV R10, R1 @ x = b
		MOV R12, #0 @ count = 0
		BL 	DIV @ x div 2
		MOV R1, R12 @ b = b div 2
		MUL	R2, R1, R1 @ c = b ^ 2
		B 	RLOOP
RLOOP2:	CMP R2, R0 @ c <= a
		BGT	FIN
		ADD R1, R1, #1 @ b += 1
		MUL R2, R1, R1 @ c = b ^ 2
		B RLOOP2

DIV:	CMP R10, R11 @ x < y
		BXLT LR
		SUB R10, R10, R11 @ x -= y
		ADD R12, R12, #1 @ count += 1
		B 	DIV

FIN:	SUB R1, R1, #1
		MOV R0, R1
		MOV R7, #1
		SVC 0
.end
