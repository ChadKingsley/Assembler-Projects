 INCLUDE Irvine32.inc

.data
	
	targetStr BYTE "ABCDE", 10 DUP(0)
	sourceStr BYTE "FGH", 0

	targetSize DWORD LENGTHOF targetStr -1
	sourceSize DWORD LENGTHOF sourceStr -1

	strcon PROTO, target:DWORD, source:DWORD, tSize:DWORD, sSize:DWORD

.code
main proc
	
	INVOKE strcon, ADDR targetStr, ADDR sourceStr, targetSize, sourceSize	;call strcon

	invoke ExitProcess,0
main endp

;---------------------------------------------------------------------
;strcon will be passed two addresses pointing to strings, one for a
;target and one for a source, as well as the sizes for each to be 
;used for REP funtions. The procedure will concatenate the two strings
;into one string. The source string will be added to the target, but
;the proper space is needed in the target so it must be padded with 0
;---------------------------------------------------------------------

strcon PROC, target:DWORD, source:DWORD, tSize:DWORD, sSize:DWORD

	mov edi, target				;mov edi the target address
	mov esi, source				;mov esi the source address
	
	CLD							;clear the direction flag, direction = forward
	mov ecx, tSize				;mov ecx tSize for the REPNE funtion

	mov al, 0					;mov al 0
	REPNE SCASB					;scan edi for the value in al
	jnz quit					;if value is not found jump to quit
	
	dec edi						;dec edi to point to correct location, SCASB auto incs edi
	mov ecx, sSize				;mov ecx sSize
	REP MOVSB					;move the value at location esi to the value at location edi
								;repeat until ecx = 0 (all of esi will be attached to edi)
	mov edx, target				;mov edx the address of target
	call writestring			;display the newly concatenated string
	call Crlf					;character return line feed

quit: ret

strcon ENDP


end main