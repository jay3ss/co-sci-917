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
InvertSentenceCase PROTO,
    sentence1:PTR BYTE,
    sentence2:PTR BYTE
InvertLetterCase PROTO
IsSpaceOrPunct PROTO

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
ENTER_STR_PROMPT  BYTE "Please enter a string: ",0
NUM_WORDS_MSG     BYTE "The number of words in the input string is: ",0
OUTPUT_STRING_MSG BYTE "The output string is: ",0

; Bit mask for case inversion
CASE_INV_BIT_MASK DWORD 00100000b

; Code segment
.code
main PROC
	mov edx, OFFSET ENTER_STR_PROMPT
    call WriteString
    mov ecx, BUFF_MAX
    mov edx, OFFSET inputStr
    call ReadString
    mov inputSize, eax

	mov edx, OFFSET NUM_WORDS_MSG
    call WriteString

    mov ebx, inputStr
    call InvertLetterCase
    call WriteString
    ; call WriteInt
    call Crlf
	exit
main ENDP

;------------------------------------------------------------------------------
CountWords PROC USES edi ebx ecx edx,
    sentence:PTR BYTE,
    numChars:DWORD,
; Counts the number of words in a sentence
; Receives: sentence: The sentence to count the number of words
;           numChars: The number of characters in the sentence
; Returns: EAX = The number of words in the sentence
;------------------------------------------------------------------------------
    mov eax,0
    ; There are no words if the string has a length of zero
    .IF(numChars > 0)
        mov edi,sentence
        mov ebx,0   ; is current character a space or punctuation?
        mov ecx,0   ; is previous character a space or punctuation?
        .WHILE(numChars > 0)
            mov ebx,[edi]
            ;call IsSpaceOrPunct
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
InvertLetterCase PROC USES ebx
; Inverts the case of a letter. I.e., an uppercase letter is converted to a
; lowercase one and vice versa.
; Receives: EAX: The letter to invert
; Returns: EAX: The letter with the inverted case
;------------------------------------------------------------------------------
    call IsSpaceOrPunct
    .IF(ebx == 1)
        xor eax, CASE_INV_BIT_MASK
    .ENDIF
    ret
InvertLetterCase ENDP
;------------------------------------------------------------------------------
IsSpaceOrPunct PROC
; Determines if a character is in the the following set of characters
;    {' ', ',', '.', '!', '?', ';'}
; which are space and some punctuation characters. Will destroy the Zero flag
; Receives: EBX: The character to compare
; Returns: EBX: 1 if the character is a space or punctuation mark, 0 otherwise
;------------------------------------------------------------------------------
    ; Note that 59 is the semicolon ASCII value
    .IF(ebx == " " || ebx == "," || ebx == "." || ebx == "!" || ebx == "?" || ebx == 59)
        mov ebx,1
    .ELSE
        mov ebx,0
    .ENDIF
    ret
IsSpaceOrPunct ENDP
END main
