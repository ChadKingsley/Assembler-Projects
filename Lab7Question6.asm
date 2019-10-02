
;NOT FINISHED 

INCLUDE Irvine32.inc

.data
	array BYTE 10 DUP(?)
	pointer DWORD ?

.code
main proc
	call Randomize						;sets randomization for randonrange
	mov eax, LENGTHOF array				;assign eax the length of array, pointless but the instructions said to do so
	mov ecx, 20							;set counter for the repeated procedure call
	mov edx, OFFSET array
	L1: mov pointer, OFFSET array		;move pointer the starting address of array after each procedure call
		call randomString				;call procedure
		call Writestring
		LOOP L1							;loop L1, super self explanitory

	invoke ExitProcess,0
main endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Random string sets each location in array to an uppercase	;
;letter. Using ebx as a starting point for all uppercase	;
;ASCII letters, we recieve a random number between 0 and 25	;
;to be added to ebx. That sum will represent a letter		;
;and it will be stored in an array referenced by an			;
;incrementing pointer. That process will loop until each	;
;element of array is filled.								;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

randomString PROC
	
	push ecx							;push ecx to the stack as to not lose outer loop progress
	mov ecx, eax						;assign ecx the new counter value stored in eax
	push eax							;push eax to the stack to save the length of array
	mov edi, 0
	L1:	mov ebx, 65						;assign ebx 65, A in ascii.
		mov eax, 26						;move eax 26, setting the max value that RandomRange
										;	will have access to. Range is 0-25

		call RandomRange				;call RandomRange, filling eax with a new value from 0-25
		
		add eax, ebx					;add eax to ebx, this gives us a random uppercase letter

		mov [array + edi], al				;store that letter into the array location defined by pointer

		;mov al, BYTE PTR pointer		;store the value in pointer into al in order to write the 
										;	character to the console window

		;call WriteChar					;writes the character to the console window
		inc pointer						;increment pointer so it's pointing at the next location in array
		inc edi

		LOOP L1							;loop L1

	call Crlf							;character return line feed
	pop eax								;pop eax from the stack
	pop ecx								;pop ecx from the stack

ret										;return to main
randomString ENDP						;end procedure

end main