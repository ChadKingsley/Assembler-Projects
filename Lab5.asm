INCLUDE Irvine32.inc

.data
	array DWORD 0,4,9,15,19

.code
main proc

	mov ecx, LENGTHOF array				;assign ecx the number of elements in
										;the array to set the counter

	dec ecx								;decrement by one because that is how
										;many comparisons must be made in the loop

	mov edi, 0							;zero out edi
	mov eax, 0							;zero out eax

	L1: mov ebx, [array + edi]			;assign ebx the value in the corresponding
										;byte location in array

		mov edx, [array + (edi + 4)]	;assign edx the value in the next byte
										;location in array

		sub edx, ebx					;get the difference of the two values and
										;it will be stored in edx

		add eax, edx					;add the difference found into eax to find
										;the sum of all differences

		add edi, 4						;make edi point to the next byte location
										;for comparisons

		LOOP L1							;loop L1 to calculate the sum of all differences

	call DumpRegs

	invoke ExitProcess,0
main endp
end main