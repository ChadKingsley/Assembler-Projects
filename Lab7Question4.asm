INCLUDE Irvine32.inc

.data
	output1 BYTE "Enter two values to be summed. After each number press the enter key",0
	output2 BYTE "The sum of your two values is: ",0
	val DWORD ?

.code
main proc
	mov ecx, 3							;sets the counter for the loop

	L1: call Clrscr						;clears the screen of all data
		mov dh, 9						;sets the row number that I want the cursor to go to
		mov dl, 0						;sets the column number that I want the cursor to go to
		call Gotoxy						;moves the cursor to the set row and column

		mov edx, OFFSET output1			;move the starting address of output1 into edx to display
										;the string in the console window
		call writeString				;writes the string to the console window
		call Crlf						;character return line feed

		call ReadDec					;reads a decimal value from the keyboard entered in the 
										;the console window
		mov val, eax					;store the first value so its not lost when calling for the second
		call ReadDec					;reads the next decimal value from the keyboard

		add eax, val					;adds the two values and stores the sum in eax

		mov edx, OFFSET output2			;moves the starting address of the next output msg to edx
		call WriteString				;writes the string to the console window

		call WriteDec					;writes the sum stored in eax to the console window

		call Crlf						;character return line feed
		call WaitMsg					;pauses the screen before clearing it
		call Crlf						;character return line feed

		LOOP L1							;loop L1 the set amount of times

	invoke ExitProcess,0
main endp
end main