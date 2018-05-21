.text
.global _start
_start:	LDR R0, =#28300 @ x = R0
		LDR R1, =#40000 @ y = R1
		LDR R2, =#28300 @ count = R2

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
		MOVEQ R6, #0
		BGT APOS
		BLT ANG

APOS:	CMP R6, R7
		MOVLT R6, #0
		MOVGT R6, #1
		B COSA

ANG:	MOV R12, R6
		BL 	ABS
		MOV R6, R12
		CMP R6, R7
		MOVLT R6, #0
		MOVGT R6, #-1
		B COSA

		@ div( (a*a)+(c*c)-(b*b), 2*a*c) = cosb
COSA:	MUL R7, R0, R0
		MUL R8, R1, R1
		MUL R9, R2, R2
		ADD R7, R9, R7
		SUB R7, R7, R8
		MUL R8, R0, R5
		MUL R9, R8, R2
		@ Division
		CMP R7, #0
		MOVEQ R7, #0
		BGT BPOS
		BLT BNG

BPOS:	CMP R7, R8
		MOVLT R7, #0
		MOVGT R7, #1
		B COSC

BNG:	MOV R12, R7
		BL 	ABS
		MOV R7, R12
		CMP R7, R8
		MOVLT R7, #0
		MOVGT R7, #-1
		B COSC

COSC:	@ div( (b*b)+(c*c)-(a*a), 2*c*b) = cosa
		MUL R8, R0, R0
		MUL R9, R1, R1
		MUL R10, R2, R2
		ADD R9, R10, R9
		SUB R8, R9, R8
		MUL R8, R1, R5
		MUL R8, R2, R8
		@ Division
		CMP R8, #0
		MOVEQ R8, #0
		BGT CPOS
		BLT CNG

CPOS:	CMP R8, R9
		MOVLT R8, #0
		MOVGT R8, #1
		B COMP

CNG:	MOV R12, R8
		BL 	ABS
		MOV R8, R12
		CMP R8, R9
		MOVLT R8, #0
		MOVGT R8, #-1
		B COMP

COMP:	@ if (cosa == 0| cosb == 0| cosc == 0)
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

DIV:	CMP R10, R11 @ x < y
		BXLT LR
		SUB R10, R10, R11 @ x -= y
		ADD R12, R12, #1 @ count += 1
		B 	DIV

ABS:	MOV R11, #0
		CMP R12, R11
		SUBLT R12, R11, R12
		BX LR

FIN:	MOV R7, #1
		SVC 0
.end
