.data

X1: .int 2
Y1: .int 6

X2: .int 9
Y2: .int 12

X3: .int 15
Y3: .int 20

.text
.global _start
_start:	
		LDR R0, =#X1 @ x1 --> lado a
		LDR R0, [R0] 
		LDR R1, =#Y1 @ y1 --> lado b
		LDR R1, [R1] 
		LDR R2, =#X2 @ x2 --> lado c
		LDR R2, [R2] 
		LDR R3, =#Y2 @ y2 --> perimetro
		LDR R3, [R3] 
		LDR R4, =#X3 @ x3 --> Area
		LDR R4, [R4] 
		LDR R5, =#Y3 @ y3 --> clasificacion por lados 
		LDR R5, [R5] 
		LDR R6, =#0 @ clasificacion por angulos
		LDR R7, =#0 @ a
		LDR R8, =#0 @ b
		LDR R9, =#0 @ c
		LDR R10, =#0 @ x
		LDR R11, =#0 @ y
		LDR R12, =#0 @ count

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

		@ Clasificacion de lados
		CMP R0, R1 @ a == b
		BEQ IFAC
		BNE IFBC

IFAC:	CMP R0, R2 @ a == c
		MOVEQ R5, #1
		MOVNE R5, #2
		B COMP

IFBC:	CMP R1, R2
		MOVEQ R5, #2
		BNE IFCA
		B COMP

IFCA:	CMP R2, R0
		MOVEQ R5, #2
		BNE ELSE
		B COMP

ELSE:	MOV R5, #3
		B COMP

COMP:	CMP R4, #0x0 @ R4 == 0
		BEQ	CANCEL @ if R4 == 0 then jump FIN

		@ div( (a*a)+(b*b)-(c*c), 2*a*b) = cosc
		MUL R6, R0, R0
		MUL R7, R1, R1
		MUL R8, R2, R2
		ADD R6, R7, R6
		SUB R6, R6, R8
		MOV R5, #2
		MUL R7, R0, R5
		MUL R8, R7, R1
		MOV R7, R8
		@ Division
		CMP R6, #0
		MOVGT R6, #-1
		MOVEQ R6, #0
		MOVLT R6, #1

		@ div( (a*a)+(c*c)-(b*b), 2*a*c) = cosb
		MUL R7, R0, R0
		MUL R8, R1, R1
		MUL R9, R2, R2
		ADD R7, R9, R7
		SUB R7, R7, R8
		MUL R8, R0, R5
		MUL R9, R8, R2
		@ Division
		CMP R7, #0
		MOVGT R7, #-1
		MOVEQ R7, #0
		MOVLT R7, #1

		@ div( (b*b)+(c*c)-(a*a), 2*c*b) = cosa
		MUL R8, R0, R0
		MUL R9, R1, R1
		MUL R10, R2, R2
		ADD R9, R10, R9
		SUB R8, R9, R8
		MUL R8, R1, R5
		MUL R8, R2, R8
		@ Division
		CMP R8, #0
		MOVGT R8, #-1
		MOVEQ R8, #0
		MOVLT R8, #1

		@ if (cosa == 0| cosb == 0| cosc == 0)
		CMP R6, #0
		BEQ RECT
		CMP R7, #0
		BEQ RECT
		CMP R8, #0
		BEQ RECT
		@ else if (cosa < 0| cosb < 0| cosc < 0)
		CMP R6, #0
		BGT OBTU
		CMP R7, #0
		BGT OBTU
		CMP R8, #0
		BGT OBTU
		B ACUD

RECT:	MOV R6, #1
		B FIN

OBTU:	MOV R6, #3
		B FIN

ACUD:	MOV R6, #2
		B FIN

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

FIN:	MOV R7, #1
		SVC 0
.end
