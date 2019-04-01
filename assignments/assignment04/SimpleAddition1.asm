; Joshua Saunders
; CO SCI 917
; Assignment 4:
; SimpleAddition1.asm
; 
; Prompt:
; 
; Write a program that clears the screen, locates the cursor near
; the middle of the screen, prompts the user for two integers, adds
; the integers, and displays their sum.

; .386
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