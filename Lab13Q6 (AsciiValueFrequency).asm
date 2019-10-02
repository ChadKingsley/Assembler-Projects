INCLUDE Irvine32.inc

.data
	string BYTE "1 22 333 4444 55555 666666 7777777 88888888 999999999",0
	array DWORD 256 DUP(0)
	stringSize DWORD LENGTHOF string

	Get_Frequency PROTO, pString:DWORD, pArray:DWORD, sSize:DWORD

.code
main proc

	INVOKE Get_Frequency, ADDR string, ADDR array, stringSize

	mov esi, OFFSET array			;mov esi the starting address of array
	mov ecx, LENGTHOF array			;mov ecx the length of the array

	L1: LODSD						;load the value at location esi into eax (LODSB auto incs esi)
		call WriteDec				;write eax to the console window in decimal form

		mov eax, " "				;move eax a space 
		call WriteChar				;write the space to the console window
		LOOP L1						;loop l1 ecx times

	call CRLF						;character return line feed
	

	invoke ExitProcess,0
main endp

;---------------------------------------------------------------------------
;Get_Frequency is passed 3 parameters. 2 pointers, one to a string and
;one to a null array with 256 elements, and 1 variable equal to the size 
;of the string. The procedure will search the string for all ascii values, 
;0-255, and count how many times each character is used in the string.
;Each ascii value corresponds to its indexed spot in the array, and 
;the values at those locations are the count of how many times that
;ascii value appeared in the string.
;---------------------------------------------------------------------------	

Get_Frequency PROC, pString:DWORD, pArray:DWORD, sSize:DWORD

	mov eax, 0						;mov 0 to eax, 0 will be the starting ascii value to search for
	mov ecx, sSize					;move ecx the size of the string to use as a loop counter
	mov esi, pArray					;move esi the starting address of array
	mov edi, pString				;move edi the starting address of string
	cld								;clear direction flag, direction = forward

	L1:	REPNE SCASB					;scan the string for a single byte that matches eax, ecx times
									;	(REPNE will auto dec ecx/SCASB will auto inc edi)
		jnz L2						;if no value is found jump to L2

		inc DWORD PTR [esi]			;increment the value at location esi because a match was found
		cmp ecx, 0					;compare ecx to 0
		ja L1						;if ecx is above 0 then the whole string has not been searched
									;	so jump back to L1 until ecx is 0

	L2: inc eax						;increment eax to compare the next ascii value
		add esi, 4					;add 4 to esi to point to the next location in array

		mov ecx, sSize				;reset ecx to the size of string
		mov edi, pString			;reset edi to the starting address of string

		cmp eax, 256				;compare eax to 256
		jb L1						;if below then more ascii values need to be searched for so jump to L1

	ret								;once eax is equal to 256 all values have been searched for and counted
									;	so return from the procedure

Get_Frequency ENDP

end main