TITLE Add and Subtract
; This program adds and subtracts 32-bit integers
; and stores the sum in a variable.

INCLUDE Irvine32.inc
.data
val1	dword 10000h
val2	dword 40000h
val3	dword 20000h
finalVal dword ?
.code
main PROC
	mov		eax, val1
	add		eax, val2
	sub		eax, val3
	mov		finalVal, eax
	call	DumpRegs
	exit
main ENDP
END main