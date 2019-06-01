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
; 1. Count and display the number of  words in the user input string.
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
ExitProcess PROTO, dwExitCode:DWORD
CountWords PROTO,
    sentence:PTR BYTE,
    numChars:DWORD
SwitchCase PROTO, letter:BYTE

BUFF_MAX = 128      ; the maximum buffer size

INCLUDE Irvine32.inc

; Data segment
.data
; Input
inputStr  BYTE BUFF_MAX + 1 DUP(0) ; string input by the user
inputSize DWORD ?

; Returned data
inverted  BYTE BUFF_MAX + 1 DUP(0) ; input string with case reversed
numWords  BYTE 0

; Messages
NUM_WORDS_MSG     BYTE "The number of words in the input string is: ",0
OUTPUT_STRING_MSG BYTE "The output string is: ",0

; Code segment
.code
main PROC

    call Crlf
	exit
main ENDP

;------------------------------------------------------------------------------
CountWords PROC USES edi ebx ecx edx,
    sentence:PTR BYTE,
    numChars:DWORD,
; Counts the number of words in a sentence
; Receives: sentence: The sentence to count
;           numChars: The number of characters in the sentence
; Returns: EAX = The number of words in the sentence
;------------------------------------------------------------------------------
    mov eax,0
    ; There are no words if the string has a length of zero
    .IF(count > 0)
        mov edi,sentence
        mov ebx,0   ; is current character a space or punctuation?
        mov ecx,0   ; is previous character a space or punctuation?
        .WHILE(numChars > 0)
            mov ebx,[edi]
            call isSpaceOrPunct
            .IF(ebx == 1 && ecx == 0) ; don't double count words
                inc eax
            .ELSE
                mov ebx,0
            .ENDIF
            mov ecx,ebx     ; keep previous state
            add edi,TYPE sentence
            dec numChars
        .ENDW
    .ENDIF
    ; EAX holds the number of words in the sentence
    ret
CountWords ENDP

;------------------------------------------------------------------------------
isSpaceOrPunct PROC, c:BYTE
; Determines if a character is in the the following set of characters
;    {' ', ',', '.', '!', '?', ';'}
; which are space and some punctuation characters. Will destroy the Zero flag
; Receives: EBX: The character to compare
; Returns: EBX: 1 if the character is a space or punctuation mark, 0 otherwise
;------------------------------------------------------------------------------
    ; Note that 59 is the semicolon ASCII value
    .IF(c == " " || c == "," || c == "." || c == "!" || c == "?" || c == 59)
        mov ebx,1
    .ELSE
        mov ebx,0
    .ENDIF
    ret
isSpaceOrPunct ENDP
END main
