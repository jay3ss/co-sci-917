; Joshua Saunders
; CO SCI 917
; Assignment 4:
; SimpleAddition2.asm
; 
; Prompt:
; 
; Use the solution program from the preceding exercise
; as a starting point. Let this new program repeat the
; same steps three times, using a loop. Clear the screen
; after each loop iteration.

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

; Data segment
.data
integer1 DWORD ?
integer2 DWORD ?


; Code segment
.code
main PROC
    
main ENDP
END main