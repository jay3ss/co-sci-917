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
integer1 DWORD ?    ; user input 1
integer2 DWORD ?    ; user input 2
sum      DWORD 0    ; to hold the addition of user inputs

; cursor- and screen-related variables
rows    BYTE ?      ; number of rows of screen
cols    BYTE ?      ; number of columns of screen
centerX BYTE ?      ; x-coordinate of center of screen
centerY BYTE ?      ; y-coordinate of center of screen

; printing-related variables
prompt  BYTE "Enter an integer: ",0
results BYTE "The sum of the two numbers is ",0

; Code segment
.code
main PROC
    ; clear the screen
    call Clrscr

    ; PSEUDOCODE:
    ;   find center of screen
    ;   1. maxX, maxY = GetMaxXY
    ;   2. centerX = maxX / 2
    ;      centerY = maxY / 2
    call GetMaxXY
    dec  dl         ; highest column number = X-1
    dec  dh         ; highest row number = Y-1
	; Divide each register by 2 (shift right, or left?) to get
	; the center coordinate
    shr dl,1        ; x-coordinate of screen center
    shr dh,1        ; y-coordinate of screen center
    call Gotoxy     ; position the cursor at the center of the screen
    ;   move cursor to center of screen
    ;   3. cursor->x = centerX
    ;      cursor->y = centerY

    ; Prompt the user to enter an integer
    mov edx,OFFSET prompt
    call WriteString
    call ReadInt
    mov integer1,eax        ; save the integer into integer1

    ; Prompt the uesr to enter another integer
	call Gotoxy
    call WriteString
    call ReadInt
    mov integer2,eax        ; save the integer into integer2

    ; add the two integers
    mov eax,0
    add eax,integer1
    add eax,integer2
    
    ; Display the sum of the two integers
	call Gotoxy
    mov edx,OFFSET results
    call WriteString
    call WriteInt

    
    ; Display "Press any key to continue..." so that
    ; we can see what the program did before it
    ; closes
	call Crlf
    call WaitMsg
    call Clrscr

    exit
main ENDP
END main