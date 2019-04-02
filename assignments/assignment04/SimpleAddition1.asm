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
    ;   move cursor to center of screen
    ;   3. cursor->x = centerX
    ;      cursor->y = centerY
    ;   prompt user for two integers
    ;   4. print("Enter an integer")
    ;   5. integer1 = input()
    ;   6. print("Enter another integer")
    ;   7. integer2 = input()
    ;   add the two integers
    ;   8. sum = integer1 + integer2
    ;   display the sum of the two integers
    ;   9. print(f"The sum of {integer1} and {integer2} is {sum}")

    call WaitMsg
main ENDP
END main