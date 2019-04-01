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
sum      DWORD 0


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
main ENDP
END main