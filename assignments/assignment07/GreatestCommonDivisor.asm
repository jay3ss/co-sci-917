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
ABS_VAL_BIT_MASK DWORD  0FFFFFFFFh

; To hold the numerical values entered by the user
intX    DWORD ?
intY    DWORD ?

; Prompts and output
integerPrompt BYTE "Please enter an integer: ",0
results1      BYTE "The greatest common divisor of ",0
results2      BYTE " and ",0
results3      BYTE " is ",0

; Code segment
.code
main PROC
    mov edx,OFFSET integerPrompt
    ; Get the two integers from the user
    ; First integer
    call WriteString
    call ReadInt
    mov intX,eax

    ; Second integer
    call WriteString
    call ReadInt
    mov intY,eax

	; Recover the inputs
    mov eax,intX
    mov edx,intY
    call GCD

	call Crlf

    mov ebx,eax
	mov eax,intX
    mov edx,intY
    call PrintResults
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
	.IF (eax < 0)
		add eax,-1
		xor eax,ABS_VAL_BIT_MASK
	.ENDIF
	ret
AbsVal ENDP


;---------------------------------------------------------
Modulo PROC
; Calculates the modulo of two numbers according to the
;   the formula n = x % y
; Receives: EAX = the first number (x)
;           EDX = the second number (y)
; Returns: EBX = the modulo (n) of x and y
;---------------------------------------------------------
	; eax & edx get overwritten during division, so push
	; them to the stack
    push edx
	push eax
	mov ebx,edx
	mov edx,0
    div ebx
	; div stores the remainder in edx, so move it to ebx
    mov ebx,edx
	; get eax and edx back
	pop eax
    pop edx
    ret
Modulo ENDP

;---------------------------------------------------------------
GCD PROC uses EBX
; Calculates the greatest common divisor (GCD) of two integers
; Receives: EAX = the first number (x)
;           EDX = the second number (y)
; Returns: EAX = greatest common divisor of the two numbers
;---------------------------------------------------------------
    ; 1. Find the absolute value of each number
    ; 2. Find the remainder (n) of x and y
    ; 3. Set x = y, y = n
    ; 4. Goto 2 while y > 0
    .IF (eax != 0 && edx != 0)
        ; Step 1
        call AbsVal ; x = abs(x)
        push eax    ; store eax so we can use it later
        mov eax,edx
        call AbsVal ; y = abs(y)
        mov edx,eax
        pop eax     ; get eax back
        .REPEAT
            ; Step 2
            call Modulo ; n = x % y
            mov eax,edx ; x = y
            mov edx,ebx ; y = n
        ; Step 4
        .UNTIL (edx <= 0)
    .ENDIF

	ret
GCD ENDP

;---------------------------------------------------------
PrintResults PROC
; Prints the of the calculation of the GCD proc
; Receives: EAX = the first number
;           EDX = the second number
;           EBX = the greatest common divisor
;---------------------------------------------------------
    push edx

    ; The follwing code block prints:
    ; The greatest common divisor of <intX> and <intY> is <GCD>
    ; where
    ; <intX> and <intY> are the integers enterd by the user
    ; <GCD> is the greatest common divisor of <intX> and <intY>
    mov edx,OFFSET results1
    call WriteString
    call WriteInt
    mov edx,OFFSET results2
	call WriteString
    pop edx
    mov eax,edx
    call WriteInt
    mov edx,OFFSET results3
    call WriteString
    mov eax,ebx
    call WriteInt

	ret
PrintResults ENDP
END main
