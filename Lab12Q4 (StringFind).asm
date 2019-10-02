INCLUDE Irvine32.inc

.data

	targetStr BYTE "123ABC342432",0
	sourceStr BYTE "ABC", 0

	targetSize DWORD LENGTHOF targetStr -1
	sourceSize DWORD LENGTHOF sourceStr -1

	pos DWORD ?

	match BYTE "The first matching occurance is at location ", 0
	noMatch BYTE "The two strings do not have any matching occurances", 0

	Str_find PROTO, target:DWORD, source:DWORD, tSize:DWORD, sSize:DWORD

.code
main proc
	
	INVOKE Str_find, ADDR targetStr, ADDR sourceStr, targetSize, sourceSize		;call str_find procedure 

	jnz notFound											;if no string match is found jump to not found
	mov pos, eax											;move pos the address held in eax

	mov edx, OFFSET match									;move edx the starting address of match to display string
	call WriteString										;display string

	call WriteHex											;display location held in eax
	call CRLF												;character return line feed
	jmp done												;jump to done

	notFound:	mov edx, OFFSET noMatch						;mov edx offset of noMatch to display string
				call WriteString							;display string
				call CRLF									;character return line feed

	done: invoke ExitProcess,0
main endp

;------------------------------------------------------------------------------
;str_find is passed parameters for the addresses of the target
;and source strings as well as the sizes of each string to be used
;for loops/rep. The procedure will find the first location inside the target 
;string where target=source. That address will be returned to main via eax
;------------------------------------------------------------------------------

Str_find PROC, target:DWORD, source:DWORD, tSize:DWORD, sSize:DWORD

	mov edi, target				;mov edi the address of target
	mov esi, source				;mov esi the address of source
	
	mov al, [esi]				;mov al the value at location esi
	mov ecx, tSize				;mov ecx tsize for REPNE

	cld							;clear direction flag, direction = forward

	L1: REPNE SCASB				;scan edi/target string for the value in al
								;repeat as long as values are not equal
		jnz quit				;if values never match jump to quit

		dec edi					;dec edi so it points to the matching location
		mov eax, edi			;mov eax the starting address of the match
		mov ebx, 0				;mov ebx 0 to be used as a counter for L2

	L2: CMPSB					;compare values in esi to edi
		jne L3					;if not equal jump to L3 for reset and re-search

		inc ebx					;inc ebx to indicate one comparison made
		cmp ebx, sSize			;compare ebx to size of source
		
		jb L2					;if below jump to L2 to repeat
		ret			

	L3: mov esi, source			;reset esi to source start address
		mov al, [esi]			;reset al to value at location esi
		dec edi					;dec edi to point to last non-matching location
		jmp L1					;jump back to L1 to continue search

	quit: ret

Str_find ENDP

end main