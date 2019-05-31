; Joshua Saunders
; CO SCI 917
; Final Exam Project:
; FinalExam.asm
;
; Prompt:
;
; Write an assembly language program to input a string from the user. Your
; program should do these two things:
;
; 1. count and display the number of  words in the user input string.
; 2. Flip the case of each character from upper to lower or lower to upper.
;
; For example if the user types in:   "Hello thEre. How aRe yOu?"
; Your output should be:
; The number of words in the input string is: 5
; The output string is : hELLO THeRE. hOW ArE YoU?

; .386
.model flat,stdcall
.stack 4096

; Function prototypes

INCLUDE Irvine32.inc

; Data segment
.data

; Code segment
.code
main PROC

    call Crlf
	exit
main ENDP
END main
