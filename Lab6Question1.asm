INCLUDE Irvine32.inc

.data
	bigEndian BYTE 12h, 34h, 56h, 78h
	littleEndian DWORD ?

.code
main proc
	mov eax, DWORD PTR bigEndian	;assign eax 12345678h, little endian form flips the bytes
									;leading to 78563412h
	mov littleEndian, eax			;assign littleEndian 78563412h
	call DumpRegs					;dump registers to the console window

	invoke ExitProcess,0
main endp
end main