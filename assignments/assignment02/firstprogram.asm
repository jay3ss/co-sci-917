; First assembly program from chapter 3

.386									; identifies this as a 32-bit program
.model flat,stdcall						; selects program's memory model as flat
										; and identifies the call convention (stdcall)
										; for procedures
.stack 4096								; set asside 4096 bytes of storage for the 
										; runtime stack
ExitProcess PROTO, dwExitCode:DWORD		; declares a prototype for the ExitProcess function
										; (a standard Windows service)

.data
sum DWORD 0					; this is the data segment

.code						; this is the code segment
main PROC
	mov eax,5				; move 5 to the eax register
	add eax,6				; add 6 to the eax register
	mov sum,eax				; move the contents of the eax register
							; to the sum variable
	INVOKE ExitProcess,0	; end the program
main ENDP
END main