.text
.global _start
_start:	MOV R0, #2 @ x1
		MOV R1, #6 @ y1
		MOV R2, #9 @ x2
		MOV R3, #12 @ y2
		MOV R4, #15 @ x3
		MOV R5, #20 @ y3

		SUB R6, R2, R0 @ x2 - x1
		SUB R7, R3, R1 @ y2 - y1
		MUL R8, R6, R6 @ (x2 - x1)**2
		MUL R9, R7, R7 @ (y2 - y1)**2
		ADD R6, R8, R9 @ (x2 - x1)**2 + (y2 - y1)**2

		SUB R7, R2, R4 @ x2 - x3
		SUB R8, R3, R5 @ y2 - y3
		MUL R9, R7, R7 @ (x2 - x3)**2
		MUL R10, R8, R8 @ (y2 - y3)**2
		ADD R7, R9, R10 @ (x2 - x3)**2 + (y2 - y3)**2

		SUB R8, R0, R4 @ x1 - x3
		SUB R9, R1, R5 @ y1 - x3
		MUL R10, R8, R8 @ (x1 - x3)**2
		MUL R11, R9, R9 @ (y1 - y3)**2
		ADD R8, R10, R11 @ (x1 - x3)**2 + (y1 - y3)**2

		MOV R0, R6 @ lado a = R0
		MOV R1, R7 @ lado b = R1
		MOV R2, R8 @ lado c = R2

		MOV R7, R0 @ a = raiz(lado a)
		MOV R8, #0 @ b = 0
		MOV R9, #0 @ c = 0
		BL RAIZ
		SUB R8, R8, #1 @ raiz((x2 - x1)**2 + (y2 - y1)**2)
		MOV R0, R8

		MOV R7, R1 @ a = raiz(lado b)
		MOV R8, #0 @ b = 0
		MOV R9, #0 @ c = 0
		BL RAIZ
		SUB R8, R8, #1 @ raiz((x2 - x3)**2 + (y2 - y3)**2)
		MOV R1, R8

		MOV R7, R2 @ a = raiz(lado c)
		MOV R8, #0 @ b = 0
		MOV R9, #0 @ c = 0
		BL RAIZ
		SUB R8, R8, #1 @ raiz((x1 - x3)**2 + (y1 - y3)**2)
		MOV R2, R8

		CMP R0, #0x0 @ R0 == 0
		BEQ	CANCEL @ if R0 == 0 then jump FIN

		CMP R1, #0x0 @ R1 == 0
		BEQ	CANCEL @ if R1 == 0 then jump FIN
		
		CMP R2, #0x0 @ R2 == 0
		BEQ	CANCEL @ if R2 == 0 then jump FIN

		@ Perimetro
		ADD R3, R0, R1
		ADD R3, R2, R3

		@ Area
		MOV R10, R3
		MOV R11, #2
		MOV R12, #0
		BL DIV
		MOV R4, R12 @ s = perimetro div 2
		@ s (s-a) (s-b) (s-c)
		SUB R6, R4, R0
		MUL R5, R6, R4
		SUB R6, R4, R1
		MUL R5, R6, R5
		SUB R6, R4, R2
		MUL R5, R6, R5
		@ raiz
		MOV R7, R5 @ a = raiz(lado c)
		MOV R8, #0 @ b = 0
		MOV R9, #0 @ c = 0
		BL RAIZ
		SUB R8, R8, #1 @ raiz((x1 - x3)**2 + (y1 - y3)**2)
		MOV R4, R8

		CMP R4, #0x0 @ R4 == 0
		BEQ	CANCEL @ if R4 == 0 then jump FIN
		B 	FIN

RAIZ:	CMP R7, #0
		ADDEQ R8, R8, #1
		BXEQ LR
		MOV R10, R7 @ x = a
		MOV R11, #2 @ y = 2
		MOV R12, #0 @ count = 0
		MOV SP, LR
		BL 	DIV @ x div y
		MOV R8, R12 @ b = a div 2
		MUL	R9, R8, R8 @ c = b ^ 2
RLOOP:	CMP R9, R7 @ c > a
		BLT RLOOP2
		MOV R10, R8 @ x = b
		MOV R12, #0 @ count = 0
		BL 	DIV @ x div 2
		MOV R8, R12 @ b = b div 2
		MUL	R9, R8, R8 @ c = b ^ 2
		B 	RLOOP
RLOOP2:	CMP R9, R7 @ c <= a
		MOV LR, SP
		BXGT LR
		ADD R8, R8, #1 @ b += 1
		MUL R9, R8, R8 @ c = b ^ 2
		B RLOOP2

DIV:	CMP R10, R11 @ x < y
		BXLT LR
		SUB R10, R10, R11 @ x -= y
		ADD R12, R12, #1 @ count += 1
		B 	DIV

CANCEL: MOV R0, #-1
		B FIN
		@ MOV R0, R6 @ echo $? respuesta
FIN:	MOV R7, #1
		SVC 0
.end
