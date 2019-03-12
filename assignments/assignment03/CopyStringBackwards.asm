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
    ; write code here

    ; Write the string to the console window
    mov edx,OFFSET source
    call WriteString
    INVOKE ExitProcess,0
main ENDP
END main