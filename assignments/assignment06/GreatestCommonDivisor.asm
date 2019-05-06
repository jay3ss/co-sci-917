; Joshua Saunders
; CO SCI 917
; Assignment 6:
; GreatestCommonDivisor.asm
;
; Prompt:
;
; The greatest common divisor (GCD) of two integers is the largest
; integer that will evenly divide both integers. The GCD algorithm
; involves integer division in a loop, described by the following
; pseudocode:
;
; int GCD(int x, int y)
; {
;      x = abs(x)     // absolute value
;      y = abs(y)
;      do {
;                int n = x % y
;                x = y
;                y = n
;                } while (y > 0)
;      return x
; }
;
; Implement this function in assembly language and write a test program
; that collects two numbers from the user and calls the function, passing
; it the two values. Display  the result on the screen.

; .386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

; Data segment
.data
XOR_BIT_MASK DWORD  0FFFFFFFFh

; Code segment
.code
main PROC
    mov eax,5
    mov ebx,3
    ; call GCD
    call Modulo
    mov eax,ebx
    call WriteInt
	exit
main ENDP

;---------------------------------------------------------
AbsVal PROC
; Calculates the absolute value of a signed integer
; Receives: EAX = the number
; Returns: EAX = absolute value of the number
;---------------------------------------------------------
    ; 1. Add -1 to the number
    ; 2. Form one's complement
    add eax,-1
    xor eax,XOR_BIT_MASK
	ret
AbsVal ENDP


;---------------------------------------------------------
Modulo PROC uses EDX ECX
; Calculates the modulo of two numbers according to the
;   the formula n = x % y
; Receives: EAX = the first number (x)
;           EBX = the second number (y)
; Returns: EBX = the modulo (n) of x and y
;---------------------------------------------------------
	mov edx,0
	push eax	; eax gets overwritten during division, so copy it
    div ebx
    mov ebx,edx
	pop eax
    ret
Modulo ENDP
END main
