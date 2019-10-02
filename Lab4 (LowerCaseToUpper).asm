; Chad Kingsley
; Lab 3
; String stuff

INCLUDE Irvine32.inc

.data
	string BYTE "abcde", 0ah, 0ah ,0

.code
main proc

	mov edx, OFFSET string		;edx is assigned the starting address of string
	call WriteString
								;subtracing 20h from any lowercase character within the string
								;will change its value to that of its uppercase form

	sub string, 20h				; 61h is a but A is 41h
	sub string + 1, 20h			; 62h is b but B is 42h
	sub string + 2, 20h			; 63h is c but C is 43h
	sub string + 3, 20h			; 64h is d but D is 44h
	sub string + 4, 20h			; 65h is e but E is 45h

	call WriteString

	invoke ExitProcess,0
main endp
end main