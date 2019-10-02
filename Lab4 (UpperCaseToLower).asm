; Chad Kingsley
; Lab 3
; String stuff

INCLUDE Irvine32.inc

.data
	string BYTE "ABCDE", 0ah, 0ah ,0

.code
main proc

	mov edx, OFFSET string		;edx is assigned the starting address of string
	call WriteString
								;adding 20h to any uppercase character within the string
								;will change its value to that of its lowercase form

	add string, 20h				; A is 41h but 61h is a
	add string + 1, 20h			; B is 42h but 62h is b
	add string + 2, 20h			; C is 43h but 63h is c
	add string + 3, 20h			; D is 44h but 64h is d
	add string + 4, 20h			; E is 45h but 65h is e

	call WriteString

	invoke ExitProcess,0
main endp
end main