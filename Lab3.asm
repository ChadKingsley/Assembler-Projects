; Chad Kingsley
; Add and subtract using registers. 
; eax = (eax + ebx) - (ecx + edx)

INCLUDE Irvine32.inc

.code
main proc
	mov	eax, 5		;assign 5 to eax	
	mov ebx, 5		;assign 5 to ebx
	mov ecx, 4		;assign 4 to ecx
	mov edx, 5		;assign 5 to edx
	
	add eax, ebx	;add the value in ebx to eax
	add ecx, edx	;add the value in edx to ecx
	
	sub eax, ecx	;subtract the value in ecx from eax
	
	call DumpRegs	;display the contents of the registers

	invoke ExitProcess,0
main endp
end main