INCLUDE Irvine32.inc

.data
	start DWORD 1
	links DWORD 0, 4, 5, 6, 2, 3, 7, 0	
	chars BYTE 'H', 'A', 'C', 'E', 'B', 'D', 'F', 'G'
	string BYTE LENGTHOF chars DUP(?)

.code
main proc
	mov ecx, LENGTHOF links			;set ecx counter the length of links
	mov edi, start					;set edi the value in start, this will be 
									;	used as an index location
	mov esi, 0						;assign esi 0, this will also be used as an index location

	L1:
		mov al, [chars + edi]		;al is assigned a character in chars at location edi
		mov [string + esi], al		;string location esi is assigned the character in al
		inc esi
		
		push ecx					;push ecx to the stack to save the counter for loop L1
		mov ecx, edi				;set new counter to the value in edi. This determines how
									;	many times 4 must be added to edi until it is pointing
									;	at the right memory location for links
		mov edi, 0					;zero out edi

		L2:
			add edi, 4				;add 4 to edi
			LOOP L2					;LOOP L2

		pop ecx						;return the L1 counter to ecx
		mov edi, [links + edi]		;move links location edi into edi in order to get the next
									;	letter alphabetically
		LOOP L1						;LOOP L1

	mov edx, OFFSET string			;set edx the starting location of string to call writestring
	call WriteString				;write string to the console window
	call crlf						;character return line feed

	invoke ExitProcess,0
main endp
end main