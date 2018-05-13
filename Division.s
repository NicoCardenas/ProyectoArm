.text
.global _start
_start:	MOV R0, #6 @ x = R0
		MOV R1, #2 @ y = R1
		MOV R2, #0 @ count = R2

DIV:	CMP R0, R1 @ x < y
		BLT FIN
		SUB R0, R0, R1 @ x -= y
		ADD R2, R2, #1 @ count += 1
		B 	DIV

FIN:	MOV R7, #1
		SVC 0
.end