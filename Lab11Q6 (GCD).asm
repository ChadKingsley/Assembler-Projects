INCLUDE Irvine32.inc

.data

.code
main proc
	
	mov eax, 62
	mov ebx, 4

	call GCD

	mov eax, 48
	mov ebx, 9

	call GCD

	mov eax, 93
	mov ebx, 6

	call GCD

	invoke ExitProcess,0
main endp

;------------------------------
;Greatest common divisor does
;exactly as its name describes
;
GCD PROC

	L1: mov edx, 0			;zero out edx to not mess with division
		div ebx				;dvide eax by ebx
		mov eax, ebx		;mov the divisor into eax
		mov ebx, edx		;mov the remainder into ebx
			
		cmp	ebx, 0			;compare ebx to 0
		ja L1				;if above zero jump back to L1
					
	call WriteDec			;write the decimal value in eax
	call crlf				;character return line feed

	ret						;return to program

GCD ENDP

end main