INCLUDE Irvine32.inc

.data
	
.code
main proc
	mov al, 7Fh
	add al, 1h				;adds two unsigned values resulting in a signed value
							;sets the sign flag and the overflow flag

	call DumpRegs
	
	add al, 80h				;adds 80h to signed 80h resulting in 0
							;sets the carry and zero flags

	call DumpRegs

	add al, 1h				;adds one to al resulting in 1h
							;clears all flags

	call DumpRegs

	invoke ExitProcess,0
main endp
end main