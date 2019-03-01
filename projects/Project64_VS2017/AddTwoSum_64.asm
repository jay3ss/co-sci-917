; example from page 54

.data
sum DWORD 0					; this is the data area

.code						; this is the code area
main proc
	mov	eax,5				; move 5 to the eax register
	add	eax,6				; add 6 to the eax register
	move sum, eax

	invoke ExitProcess,0	; end the program
main endp
end main