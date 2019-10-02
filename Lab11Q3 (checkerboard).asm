INCLUDE Irvine32.inc

.data
	

.code
main proc

	call ColorChange

	invoke ExitProcess,0
main endp

;-------------------------------------
;Write odd will fill in the odd
;rows of the checker board
;rows:	1	3	5	7

WriteOdd PROC

	mov dl, 1				;point to the points in the console window horizontally
	mov dh, 1				;point to the points in the console window vertically
	mov al, 219				;a square for the checkerboard
	call gotoxy				;point the cursor to the first point to get a square 1,1

	L1: call WriteChar		;write the square to the console window
		add dl, 2			;add to to dl to alternate squares
		call gotoxy			;move cursor to new location

		cmp dl, 8			;compare dl to 8
		jb L1				;if below, still within the 8*8 board so jump back to L1

		add dh, 2			;add 2 to dh to alternate to the next row needing squares
		mov dl, 1			;reset dl to 1 to fill new row
		call gotoxy			;move cursor to new location

		cmp dh, 8			;cmp dh to 8
		jb L1				;if below, still within 8*8 board so jump back to L1

ret							;return to program
WriteOdd ENDP


;-----------------------------------
;Write even will fill in the even
;rows of the checker board
;rows:	0	2	4	6	

WriteEven PROC

	mov dl, 0				;point to the points in the console window horizontally
	mov dh, 0				;point to the points in the console window vertically
	mov al, 219				;a square for the checkerboard
	call gotoxy				;point the cursor to the first point to get a square 0,0
						
	L1:	call WriteChar		;write the square to the console window
		add dl, 2			;add to to dl to alternate squares
		call gotoxy			;move cursor to new location

		cmp dl, 8			;compare dl to 8
		jb L1				;if below, still within the 8*8 board so jump back to L1

		add dh, 2			;add 2 to dh to alternate to the next row needing squares
		mov dl, 0			;reset dl to 1 to fill new row
		call gotoxy			;move cursor to new location

		cmp dh, 8			;cmp dh to 8
		jb L1				;if below, still within 8*8 board so jump back to L1

ret							;return to program
WriteEven ENDP

;----------------------------------------
;color change will utilize the delay
;and set color functions to change the 
;color of the board printed every 500ms
;until all 16 color boards have been printed

ColorChange PROC

	mov eax, 0 + (15 SHL 4)		;set eax to black text and white background
	call SetTextColor			;set those colors
	mov ecx, 16					;set ecx to 16 for a counter on all colors

	L1: call clrscr				;clear the screen after every color change
		Push eax				;push the color value to not lose it
		call WriteEven			;self explanitory
		call WriteOdd			;self explanitory
		mov eax, 500			;set eax to a timer of 500ms for delay
		call Delay				;call a delay of time eax
		pop eax					;pop color value back to eax
		inc eax					;increment the color value to point to next text color, background wont change (white)
		call SetTextColor		;set new text color
		LOOP L1					;loop until ecx is 0 and eax has gone through all colors

	mov eax, 0 + (15 SHL 4)		;reset text color (cause i couldnt see the "press any key to continue")
	call SetTextColor			;set text color to black with with background

ret								;return to program
ColorChange ENDP
end main