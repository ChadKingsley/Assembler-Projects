INCLUDE Irvine32.inc

.data
	string BYTE 51 DUP (0)	
	char BYTE 51 DUP (0)
	prompt1 BYTE "Please enter a string of character up to a total of 50, once done hit enter. Afterward, enter a single character you'd like to see removed from your string of characters", 0
	prompt2 BYTE "Taking the character you entered out of the string results in	", 0

.code
main proc
	mov edx, OFFSET prompt1				;setup for writestring
	call WriteString					;write to console window
	call Crlf							;character return line feed

	mov edx, OFFSET string				;setup for readstring
	mov ecx, SIZEOF string				;more setup
	call ReadString						;read string from console window
	mov ecx, eax						;eax hold the number of bytes entered in the console. 
										;move that value to ecx to be used as a counter

	call ReadChar						;read character from the console	
	mov char, al						;character held in al, mov it to char
	call Crlf					
	
	call CompressString					;call procedure compress string

	mov edx, OFFSET string				;setup for writestring
	call WriteString					;write compressed string to the console window

	invoke ExitProcess,0
main endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;procedure will replace the letter entered with a space in the string	;
;that was also entered.													;
;																		;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CompressString PROC

	mov esi, 0							;set esi to 0 for indexing

	L1: CMP [string + esi], al			;compare string location to the character
		je L2							;if equal jump to L2
		inc esi							;increment esi
		LOOP L1							;Loop L1
		jmp NEXT						;once loop is finished

	L2: mov [string + esi], ' '			;replace character with a space
		inc esi							;increment esi
		LOOP L1							;loop L1 to maintain the count of ecx

	NEXT: ret							;return to program

CompressString ENDP


end main