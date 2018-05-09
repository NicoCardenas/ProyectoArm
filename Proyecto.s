.text
.global _start
_start:	MOV R0, #0x11 @ x1
		MOV R1, #0x12 @ y1
		MOV R2, #0x13 @ x2
		MOV R3, #0x14 @ y2
		MOV R4, #0x15 @ x3
		MOV R5, #0x16 @ y3

		SUB R6, R2, R0 @ x2 - x1
		CMP R0, R2
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

		BNE FIN
		CMPEQ R0, R2
		CMP R0, R4
		CMP R1, R3
		CMP R1, R5

		ADD R9, R6, R7
		ADD R10, R9, R8

FIN:	MOV R0, R6 @ echo $? respuesta
		MOV R7, #1
		SVC 0
.end
