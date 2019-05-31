; Joshua Saunders
; CO SCI 917
; Assignment 7:
; CountingNearlyMatchingElements.asm
;
; Prompt:
;
; Write a procedure named CountNearMatches that receives pointers to two arrays
; of signed doublewords, a parameter that indicates the length of the two
; arrays, and a parameter that indicates the maximum allowed difference
; (called diff) between any two matching elements. For each element x(i) in the
; ﬁrst array, if the difference between it and the corresponding y(i) in the
; second array is less than or equal to diff, increment a count. At the end,
; return a count of the number of nearly matching array elements in EAX.
; Display this value.

; Write a test program that calls CountNearMatches and passes pointers to two
; different pairs of arrays. Use the INVOKE statement to call your procedure
; and pass stack parameters. Create a PROTO declaration for CountMatches. Save
; and restore any registers (other than EAX) changed by your procedure.

; .386
.model flat,stdcall
.stack 4096

; Function prototypes
ExitProcess PROTO, dwExitCode:DWORD
CountNearMatches PROTO,
    firstArr:PTR SDWORD,
    secondArr:PTR SDWORD,
    szArray:DWORD,
    diff:DWORD

INCLUDE Irvine32.inc

; Data segment
.data
; Arrays to compare
array1a SDWORD -1, 30, 37, -1, 23, 14, 37, 42, 123, 456, -50
array1b SDWORD 1, 37, 19, 24, 23, 14, 33, 91, 13, 4, 50
difference1 DWORD 10

array2a SDWORD 420, 27, 37, 19, 52, -63
array2b SDWORD 240, -33, -22, 28, 51, -61
difference2 DWORD 3

; Output string
outputStr BYTE "Number of near matches: ",0

; Bit mask for the AbsVal procedure
ABS_VAL_BIT_MASK DWORD 0FFFFFFFFh
NEG_VAL_BIT_MASK DWORD 080000000h

; Code segment
.code
main PROC
	; Find the near matches for the first set of arrays
    mov eax,0
    INVOKE CountNearMatches,
        ADDR array1a,
        ADDR array1b,
        LENGTHOF array1a,
        difference1

    mov edx,OFFSET outputStr
    call WriteString
    call WriteInt
    call Crlf

	; Find the near matches for the second set of arrays
	mov eax,0
    INVOKE CountNearMatches,
        ADDR array2a,
        ADDR array2b,
        LENGTHOF array2a,
        difference2

    mov edx,OFFSET outputStr
    call WriteString
    call WriteInt
    call Crlf
	exit
main ENDP

;------------------------------------------------------------------------------
CountNearMatches PROC USES edi esi edx,
    firstArr:PTR SDWORD,
    secondArr:PTR SDWORD,
    count:DWORD,
    diff:DWORD
; Calculates the number of nearly matching elements in two arrays that are
;   within a specified distance from each other. For each element firstArr[i]
;   in the ﬁrst array, if the difference between it and the corresponding
;   secondArr[i] in the second array is less than or equal to diff
; Receives: firstArr: the first array
;           secondArr: the second array
;           szArrays: the number of elements in the arrays
;           diff: maximum allowed difference between two matching elements
; Returns: EAX = count of the number of nearly matching array elements
;------------------------------------------------------------------------------
	mov eax,0			; clear EAX
    ; mov ecx,count       ; number of elements in the arrays
    mov edi,firstArr    ; location of the first array
    mov esi,secondArr   ; location of the second array

    .WHILE (count > 0)
        ; find the absolute value of the two elements and if it's less than
		; or equal to the maximum allowable difference, then they are near matches
        mov edx,[edi]
        sub edx,[esi]
        call AbsVal
        .IF(edx <= diff)
            inc eax
        .ENDIF
        ; Move to the next element in each array
        add edi,TYPE firstArr
        add esi,TYPE secondArr
        dec count
    .ENDW
    ret
CountNearMatches ENDP

;---------------------------------------------------------
AbsVal PROC USES eax
; Calculates the absolute value of a signed integer
; Receives: EDX = the number
; Returns: EDX = absolute value of the number
;---------------------------------------------------------
    ; 1. Apply a bit mask of all 0s except for the MSB as 1
    ;    to get the MSB of the number in EDX
    ; 2. If negative
    ;   1. Add -1 to the number
    ;   2. Form one's complement
    mov eax,edx
    and eax,NEG_VAL_BIT_MASK
	.IF (eax > 0)
		add edx,-1
		xor edx,ABS_VAL_BIT_MASK
	.ENDIF
	ret
AbsVal ENDP

END main
