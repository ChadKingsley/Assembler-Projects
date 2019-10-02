INCLUDE Irvine32.inc

.data
	numbers DWORD 51 DUP(?)

.code
main proc
	
	call Randomize							;seed random number generator for function calls
	call FillArray
	call WriteArray
	call SelectionSort
	Call WriteArray

	invoke ExitProcess,0
main endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Selection sort will organize an array	;
;based on numerical value.				;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

selectionSort PROC
															
mov edi, OFFSET [numbers]					;mov edi the starting address of numbers	
mov esi, OFFSET [numbers + 4]				;mov esi the address of the second value
mov ecx, eax								;mov ecx the # of actual entries made in numbers
mov edx, 0									;zero out edx to count comparisons made 

L1: mov ebx, edi							;mov ebx the address of numbers held in edi
	push ecx								;push ecx to keep the counter for loop L1
	mov ecx, eax							;mov eax the # of actual entries made in numbers
	sub ecx, edx 							;subtract the number of comparisons made from the 
											; number of entries to get remaining comparisons
	push edx								;push edx to save comparisons

	L2: CMP ecx, 1							;if ecx is 1 then we have reached the end of the 
											; array because we are performing 1 less operation
											; than the array holds, but we cant dec ecx or L2 will 
											; eventually start at 0 causing Loop issues
		je OUTL2							;if equal to 1 then jump to OUTL2 to prevent comparisons
											; outside of the array
		mov edx, [esi]						;mov edx the value at the address location held in esi
		CMP edx, [ebx]						;cmp edx to the value held at location ebx
		jb L3								;if edx < [ebx] jump to L3

		add esi, 4							;add 4 to esi to point to next location in numbers
		LOOP L2								;Loop L2
		jmp OUTL2							;Jump to OUTL2

		L3: mov ebx, esi					;mov ebx the address held in esi because it is
											; the new lowest value in numbers
			add esi, 4						;add 4 to esi to point to next location in numbers
			LOOP L2							;Loop L2

	OUTL2:	mov ecx, [ebx]					;mov ecx the value held at location ebx
			xchg [edi], ecx					;assign the location of edi the value in ecx
											; and vice versa
			mov [ebx], ecx					;assign the location of ebx the value in ecx

			add edi, 4						;add 4 to edi to point to next location in numbers
			mov esi, edi					;reassign esi the location following edi
			add esi, 4						;^^^^

			pop edx							;pop edx
			inc edx							;increment to count comparisons done
			pop ecx							;pop ecx back for L1 loop

			LOOP L1							;Loop back to start of L1

OUTL1:	ret									;return to program

selectionSort ENDP							;end selection sort proc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Define entries will get the value		;
;representing the number of entries		;
;made in array and store it in eax		;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DefineEntries PROC

mov eax, 41									;set random range to get a number between 0-39
call RandomRange							;get a random number between 0-40 to be the # of
											; entries to be made in the numbers array
add eax, 10									;add 10 to the number of entries because there must
											; be between 10-50
ret											;return to program

DefineEntries ENDP							;Define entries End PROC

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Fill array fills the array numbers ;
;with values between 1-1000 for		;
;however many entries are to be made;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

FillArray PROC

call DefineEntries							;set eax to the # of entries to be made
mov ecx, eax								;mov ecx the # of entries to be used as a count
push eax									;push eax to save count

mov edi, OFFSET numbers						;mov edi the starting location of numbers

L1: mov eax, 1000							;set range
	call RandomRange						;get a number from 0-999 and assign it to eax
	add eax, 1								;increase eax because we want values from 1-1000
	mov DWORD PTR [edi], eax				;assign the location of numbers the value in eax
	add edi, 4								;add 4 to edi to point to next location in numbers
	LOOP L1									;loop L1
	
pop eax										;pop eax (number of entries) back from stack
ret											;return to program
	
FillArray ENDP								;Fill array end PROC

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Write array writes the array to the;
;console window one value at a time	;
;in a vertical list					;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WriteArray PROC

mov edi, OFFSET [numbers]					;mov edi the starting address of numbers
mov ecx, eax								;mov ecx the # of entries made to use as a count
push eax									;push eax to keep # number of entries made

L1: mov eax, [edi]							;mov eax the value in the location held in edi
	call WriteDec							;write the value in eax to the console in decimal
	call Crlf								;character return line feed
	add edi, 4								;add 4 to edi to point to next location in numbers
	LOOP L1									;loop L1 

call Crlf									;character return line feed
pop eax										;pop eax back from stack
ret											;return to program

WriteArray ENDP								;Write array end PROC


end main