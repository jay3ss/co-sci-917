; Joshua Saunders
; CO SCI 917
; Assignment 6:
; GreatestCommonDivisor.asm
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
    firstArr:PTR DWORD,
    szArray1:DWORD,
    secondArr:PTR DWORD,
    szArray2:DWORD,
    diff:DWORD

INCLUDE Irvine32.inc

; Data segment
.data
array1 DWORD 15, 37, -1, 23, 14, 37, 42, 123, 456
sizeArr1 DWORD LENGTHOF array1
array2 DWORD 37, 19, 24, 23
sizeArr2 DWORD LENGTHOF array2

; Code segment
.code
main PROC

	exit
main ENDP

;---------------------------------------------------------
CountNearMatches PROC USES esi ecx,
    firstArr:PTR DWORD,
    szArray1:DWORD,
    secondArr:PTR DWORD,
    szArray2:DWORD,
    diff:DWORD
; Calculates the absolute value of a signed integer
; Receives: EAX = the number
; Returns: EAX = absolute value of the number
;---------------------------------------------------------

CountNearMatches ENDP
END main
