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
CountWords PROTO, sentencePtr:PTR BYTE, numChars:DWORD
InvertSentenceCase PROTO, sourcePtr:PTR BYTE, destPtr:PTR BYTE, strLen:DWORD
InvertLetterCase PROTO
IsSpaceOrPunct PROTO

BUFF_MAX = 128      ; the maximum buffer size

INCLUDE Irvine32.inc

; Data segment
.data
; Input
inputStr  BYTE BUFF_MAX DUP(0) ; string input by the user
numWords     BYTE 0

; Returned data
invertedStr  BYTE BUFF_MAX DUP(0) ; input string with case reversed
inputSize DWORD ?

; Messages
ENTER_STR_PROMPT  BYTE "Please enter a string: ",0
NUM_WORDS_MSG     BYTE "The number of words in the input string is: ",0
OUTPUT_STRING_MSG BYTE "The output string is: ",0

; Bit mask for case inversion
CASE_INV_BIT_MASK DWORD 20h

; Code segment
.code
main PROC
    ; Prompt the user for input
	mov edx, OFFSET ENTER_STR_PROMPT
    call WriteString
    mov ecx, BUFF_MAX
    mov edx, OFFSET inputStr
    call ReadString
    mov inputSize, eax

    ; Count the number of words in the string
	INVOKE CountWords,
		ADDR inputStr,
		inputSize

    ; Display a message stating the number of words in the string
	call Crlf
	mov edx, OFFSET NUM_WORDS_MSG
	call WriteString
	call WriteInt
	call Crlf

    ; Invert the capitalization of the alphabetic characters in the string
    INVOKE InvertSentenceCase,
        ADDR inputStr,
        ADDR invertedStr,
        inputSize

    ; Display a message and the string with the alphabetic characters inverted
    mov edx, OFFSET OUTPUT_STRING_MSG
    call WriteString
	mov edx, OFFSET invertedStr
    call WriteString
    call Crlf

    call WaitMsg

	exit
main ENDP

;------------------------------------------------------------------------------
CountWords PROC USES edi ebx ecx edx,
    sentencePtr:PTR BYTE,
    numChars:DWORD,
; Counts the number of words in a sentence
; Receives:
;	sentencePtr: The sentence to count the number of words
;   numChars: The number of characters in the sentence
; Returns: EAX = The number of words in the sentence
;------------------------------------------------------------------------------
    mov eax,0
    ; There are no words if the string has a length of zero
    .IF(numChars > 0)
        mov edi,sentencePtr
        mov ebx,0   ; is the current character a space or punctuation?
        mov ecx,0   ; is the previous character a space or punctuation?
        .WHILE(numChars > 0)
            mov bl,[edi]
            call IsSpaceOrPunct
            .IF(ebx == 1 && ecx == 0) ; don't double count words
                inc eax
            .ENDIF
            mov ecx,ebx     ; keep previous state
            inc edi
            dec numChars
        .ENDW
    .ENDIF

    ; We've reached the end of the string. Did it end with a sapce or
    ; punctuation? We're going to have to check and if it did we're ok, the
    ; number of words is correct. Otherwise, if the sentence didn't end with a
    ; space or punctuation then we'll need to add one to the count because the
    ; last word didn't get counted.
    .IF(ebx == 0)
        inc eax
    .ENDIF
    ; EAX holds the number of words in the sentence
    ret
CountWords ENDP

;------------------------------------------------------------------------------
InvertSentenceCase PROC USES edi esi eax,
	sourcePtr:PTR BYTE,
	destPtr:PTR BYTE,
	strLen:DWORD
; Inverts the case of an entire sentence
; Receives:
;	sentencePtr: Pointer to the source sentence
;	destPtr: Pointer to the destination sentence
; strLen: Length of the string
;------------------------------------------------------------------------------
	mov eax, 0
	mov edi, destPtr
    mov esi, sourcePtr
	.WHILE(strLen > 0)
		mov al, [esi]
		call InvertLetterCase
		mov [edi], al

        inc edi
        inc esi
		dec strLen
	.ENDW
    ret
InvertSentenceCase ENDP

;------------------------------------------------------------------------------
InvertLetterCase PROC USES ebx ecx
; Inverts the case of a letter. I.e., an uppercase letter is converted to a
; lowercase one and vice versa.
; Receives:
;	EAX: The letter to invert
; Returns:
;	EAX: The letter with the inverted case
;------------------------------------------------------------------------------
    ; Don't try to invert the case of a digit!
    call IsDigit
    jz RETURN
	mov ebx, eax
    call IsSpaceOrPunct
	; If the letter isn't a space or punctuation, then invert its case
    .IF(ebx == 0)
        xor eax, CASE_INV_BIT_MASK
    .ENDIF
RETURN:
    ret
InvertLetterCase ENDP

;------------------------------------------------------------------------------
IsSpaceOrPunct PROC
; Determines if a character is in the the following set of characters
;    {' ', ',', '.', '!', '?', ';'}
; which are space and some punctuation characters. Will destroy the Zero flag
; Receives:
;	EBX: The character to compare
; Returns:
;	EBX: 1 if the character is a space or punctuation mark, 0 otherwise
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
