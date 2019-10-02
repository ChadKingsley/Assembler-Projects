 INCLUDE Irvine32.inc

.data
	array BYTE 1h, 2h, 3h, 4h, 5h, 6h

.code
main proc
	
	mov ecx, LENGTHOF array			;used to set up call DumpMem
	mov esi, OFFSET array			;so that the user can see the
	mov ebx, TYPE array				;way array is organized 

	call DumpMem					;outputs array to console window

	mov edi, 0h						;set edi to 0 for index addressing
	mov esi, 1h						;set esi to 1 for indes addressing

	L1:
		mov al, [array + edi]		;assign al the value in the specified array location

		xchg al, [array + esi]		;exchange the value in the next array location
									;with the previous array value stored in al

		xchg al, [array + edi]		;exchange the value in the previous array location
									;with the next array value stored in al

		add esi, 2					;add 2 to esi so it points to the next value to be exchanged
		add edi, 2					;add 2 to edi so it points to the next value to be exchanged

		dec ecx						;having swapped 2 values, ecx needs to be decremented by 2. 
									;This will drop ecx by 1 and loop will drop it by 1 more

		loop L1						;loop L1 until ecx is 0, decrement ecx by 1

	mov esi, OFFSET array			;used to set up call DumpMem
	mov ecx, LENGTHOF array			;same
	mov ebx, TYPE array				;same

	call DumpMem					;outputs array to console window

	invoke ExitProcess,0
main endp
end main