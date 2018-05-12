.text
.global _start
_start:	MOV R0, #0x11 @ x1
		MOV R1, #0x12 @ y1
		MOV R2, #0x13 @ x2
		MOV R3, #0x14 @ y2
		MOV R4, #0x15 @ x3
		MOV R5, #0x16 @ y3

		SUB R6, R2, R0 @ x2 - x1
		SUB R7, R3, R1 @ y2 - y1
		MUL R8, R6, R6 @ (x2 - x1)**2
		MUL R9, R7, R7 @ (y2 - y1)**2
		ADD R6, R8, R9 @ (x2 - x1)**2 + (y2 - y1)**2

		SUB R7, R2, R4 @ x2 - x3
		SUB R8, R3, R5 @ y2 - y3
		MUL R9, R7, R7 @ (x2 - x3)**2
		MUL R10, R8, R8 @ (y2 - y3)**2
		ADD R7, R8, R10 @ (x2 - x3)**2 + (y2 - y3)**2

		SUB R8, R0, R4 @ x1 - x3
		SUB R9, R1, R5 @ y1 - x3
		MUL R10, R8, R8 @ (x1 - x3)**2
		MUL R11, R9, R9 @ (y1 - y3)**2
		ADD R8, R10, R11 @ (x1 - x3)**2 + (y1 - y3)**2

		CMP R6, #0x0 @ R6 == 0
		BEQ	CANCEL @ if R6 == 0 then jump FIN

		CMP R7, #0x0 @ R7 == 0
		BEQ	CANCEL @ if R7 == 0 then jump FIN
		
		CMP R8, #0x0 @ R8 == 0
		BEQ	CANCEL @ if R8 == 0 then jump FIN

		ADD R9, R6, R7
		CMP R9, R8
		BEQ CANCEL
		ADD R10, R9, R8

		@ skipcond
		@CMP R0, R2
		@BLT FIN

CANCEL: MOV R0, #-1
		B FIN
		MOV R0, R6 @ echo $? respuesta
FIN:	MOV R7, #1
		SVC 0
.end
.text
.global _start
_start:	MOV R0, #0x11 @ x1
		MOV R1, #0x12 @ y1
		MOV R2, #0x13 @ x2
		MOV R3, #0x14 @ y2
		MOV R4, #0x15 @ x3
		MOV R5, #0x16 @ y3

		SUB R6, R2, R0 @ x2 - x1
		SUB R7, R3, R1 @ y2 - y1
		MUL R8, R6, R6 @ (x2 - x1)**2
		MUL R9, R7, R7 @ (y2 - y1)**2
		ADD R6, R8, R9 @ (x2 - x1)**2 + (y2 - y1)**2

		SUB R7, R2, R4 @ x2 - x3
		SUB R8, R3, R5 @ y2 - y3
		MUL R9, R7, R7 @ (x2 - x3)**2
		MUL R10, R8, R8 @ (y2 - y3)**2
		ADD R7, R8, R10 @ (x2 - x3)**2 + (y2 - y3)**2

		SUB R8, R0, R4 @ x1 - x3
		SUB R9, R1, R5 @ y1 - x3
		MUL R10, R8, R8 @ (x1 - x3)**2
		MUL R11, R9, R9 @ (y1 - y3)**2
		ADD R8, R10, R11 @ (x1 - x3)**2 + (y1 - y3)**2

		CMP R6, #0x0 @ R6 == 0
		BEQ	CANCEL @ if R6 == 0 then jump FIN

		CMP R7, #0x0 @ R7 == 0
		BEQ	CANCEL @ if R7 == 0 then jump FIN
		
		CMP R8, #0x0 @ R8 == 0
		BEQ	CANCEL @ if R8 == 0 then jump FIN

		ADD R9, R6, R7
		CMP R9, R8
		BEQ CANCEL
		ADD R10, R9, R8

DIV:	CMP R11, R12
		BGT FIN
		SUB R11, R11, R12
		ADD R13, #1, R13
		B 	DIV

		@ skipcond
		@CMP R0, R2
		@BLT FIN

CANCEL: MOV R0, #-1
		B FIN
		MOV R0, R6 @ echo $? respuesta
FIN:	MOV R7, #1
		SVC 0
.end
