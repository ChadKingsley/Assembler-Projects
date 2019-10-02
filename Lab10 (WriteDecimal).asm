INCLUDE Irvine32.inc

DECIMAL = 3						;defines where the decimal will be placed

.data
	
	number BYTE "12345"			;the number to be given a decimal

.code
main PROC
	
	mov edx, OFFSET number		;give edx the offset of number
	mov ecx, LENGTHOF number	;give ecx the length of number to be used as a counter
	mov ebx, DECIMAL			;assign ebx the value of DECIMAL, where the decimal will be placed

	call WriteScaled			;call procedure

	invoke ExitProcess,0
main ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; writes each number from number to			;
; the console window. Once ecx and ebx are	;
; equal the decimal place will be placed	;
; and the remaining values will be written.	;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WriteScaled PROC

	L1:	CMP ecx, ebx			;compare ecx and ebx
		je NEXT					;if equal jump to NEXT

		mov al, [edx]			;mov al the value at the location held in edx
		call WriteChar			;write al to the console

		inc edx					;point edx to the next location in numbers
		LOOP L1					;loop L1 until number is printed to the console

		call Crlf				;character return line feed
		ret						;return to program

	NEXT:	mov al, "."			;assign al the decimal
			call WriteChar		;write it to the console

			inc ebx				;increment ebx to prevent the CMP and jump from repeating
			jmp L1				;jump back to L1 

WriteScaled ENDP

end main