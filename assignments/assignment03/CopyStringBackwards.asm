; Joshua Saunders
; CO SCI 917
; Assignment 3:
; CopyStringBackwards.asm
; 
; Prompt:
; Copy a String in Reverse Order Write a program with a loop and indirect
; addressing that copies a string from source to target, reversing the
; character order in the process. Use the following variables:
; 
; source BYTE "This is the source string",0
; target BYTE SIZEOF source DUP('#')

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

; Data segment
.data
source BYTE "This is the source string",0
target BYTE SIZEOF source DUP('#')

; Code segment
.code
main PROC
    ; get the start of the source string
	mov ecx,SIZEOF source		; loop counter
	; the index for the target string will start at the end of
	; the source string (ignoring the null terminator)
	; offset by two to:
	; - account for zero-indexing (one)
	; - ignore the null terminator, 0 (one)
    mov edi,SIZEOF source - 2   ; index for target
    mov esi,0                   ; index register

    ; loop through the source string and copy
    ; from source to target
L1:
    mov al,source[esi]          ; get a character from source
    mov target[edi],al          ; store it in target

    inc esi                     ; move to the next character
	dec edi
    loop L1                     ; repeat for the entire string

	mov esi,SIZEOF source - 1	; move to the end of the string to
	mov target[esi],0			; append null terminater to target

    ; Write the string to the console window
    mov edx,OFFSET target
    call WriteString

    INVOKE ExitProcess,0
main ENDP
END main