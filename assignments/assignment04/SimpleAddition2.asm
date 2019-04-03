; Joshua Saunders
; CO SCI 917
; Assignment 4:
; SimpleAddition2.asm
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
sum             DWORD 0 ; holds the sum of user-inputted ints
intloopnum      DWORD 2 ; number of times to loop getting user input
mainloopnum     DWORD 3 ; number of times to loop the program

; Cursor- and screen-related variables
rows            BYTE ? ; number of rows of screen
cols            BYTE ? ; number of columns of screen

; Printing-related variables
prompt          BYTE "Enter an integer: ",0
results         BYTE "The sum of the two numbers is ",0

; Code segment
.code
main PROC
    mov ecx,mainloopnum
MAINLOOP:
    ; clear the screen
    call Clrscr

    ; Get the center of the screen and print a prompt
    ; for the user to enter an integer
	call GetScreenCenter		; (DH, DL) = (x-coord, y-coord)
	mov rows,dh
	mov cols,dl
    ; Push the ECX (counter) to the stack so that we
    ; can keep track of how many times the main loop
    ; has run
    push ecx
    mov ecx,intloopnum

    ; This loop handles getting input from the
    ; user. This occurs intloopnum times
GETINTLOOP:
	call Gotoxy
    ; Prompt the user to enter an integer
    mov edx,OFFSET prompt
    call PromptAndGetInt
    add sum,eax

	inc rows                	; go to the next row
    loop GETINTLOOP

    ; pop ECX so that we can keep track of how many
    ; times the outer loop has run
    pop ecx

	mov dl,cols
    call Gotoxy
    mov edx,OFFSET results
    call WriteString
    call WriteInt
    call Crlf
    call WaitMsg

	loop MAINLOOP

    ; Display "Press any key to continue..." so that
    ; we can see what the program did before it
    ; closes
	call Crlf
	inc rows
	mov dh,rows
	mov dl,cols
    call Gotoxy
    call WaitMsg

    

    ; Clear the screen and exit
    call Clrscr
    exit
main ENDP

;---------------------------------------------------------
; GetScreenCenter
; Finds the center of the screen buffer
; Receives: None
; Returns: (DH, DL) = (x-coord, y-coord)
;---------------------------------------------------------
GetScreenCenter PROC uses eax
	; mov eax,0			; clear EAX & EDX
	; mov edx,0

	; find the size of the screen buffer
	; - AX: number of rows
	; - DX: number of columns
	CALL GetMaxXY
	shr al,1			; divide by 2 to get center
	shr dl,1
	mov dh,al			; move DH = (num of rows) / 2

	ret					; cooridnates are in EDX
GetScreenCenter ENDP

;---------------------------------------------------------
; PromptAndGetInt
; Prompts the user for input and returns the input
; Receives: None
; Returns: (DH, DL) = (x-coord, y-coord)
;---------------------------------------------------------
PromptAndGetInt PROC
    ; The prompt for the string needs to be
    ; in EDX before calling this procedure
    call WriteString
    call ReadInt

    ret
PromptAndGetInt ENDP
END main