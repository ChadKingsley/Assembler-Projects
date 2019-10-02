INCLUDE Irvine32.inc

.data
	
	phrase BYTE "It is now 11 O'clock",0
	key BYTE -2,4,1,0,-3,5,2,-4,-4,6
	outside BYTE 10
.code
main proc
	
	mov eax, LENGTHOF phrase		;using as a test condition because cl is needed for passing 
									;	values to ROR and I dont want to push and pop from stack
	mov edi, OFFSET phrase			;move edi the starting address of phrase
	mov esi, OFFSET key				;move esi the starting address of key

	L1: mov cl, [esi]				;move cl the value at the location held in esi because
									;	cl is the only register that can pass to ROR
		mov bl, [edi]				;move bl the value at location held in edi so it can be ROR'd

		ROR bl, cl					;Rotate the bits of bl by cl
		mov [edi], bl				;store the rotated value of bl back into the location held in edi

		inc edi						;increment edi to point to next location
		inc esi						;increment esi to point to next location
		cmp BYTE PTR [esi], 10		;compare esi to 10, if equal esi has gone outside of key
		je L2						;if equal jump to L2

	L3: dec eax						;decrement eax because one roatation has now finished
		cmp eax, 0					;compare eax to 0
		jne L1						;if not 0 jump back to L1 and repeat

	L2: mov esi, OFFSET key			;reassign esi the starting address of key
		cmp eax, 0					;check eax to make sure you dont rerun L1
		jne L3						;if not equal to 0, go back to loop L1 at point L3

	mov edx, OFFSET phrase			;mov edx the starting address of phrase for call WriteString
	call WriteString				;write the string phrase to the console window
	call Crlf						;character return line feed

	invoke ExitProcess,0
main endp
end main