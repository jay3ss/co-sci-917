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
integer1 DWORD ?    ; user input 1
integer2 DWORD ?    ; user input 2
sum      DWORD 0    ; to hold the addition of user inputs

; cursor- and screen-related variables
rows    BYTE ?      ; number of rows of screen
cols    BYTE ?      ; number of columns of screen

; printing-related variables
prompt  BYTE "Enter an integer: ",0
results BYTE "The sum of the two numbers is ",0

; Code segment
.code
main PROC
    ; clear the screen
    call Clrscr

    ; Get the center of the screen and print a prompt
    ; for the user to enter an integer
	call GetScreenCenter		; (DH, DL) = (x-coord, y-coord)
	mov rows,dh
	mov cols,dl
	call Gotoxy
    ; Prompt the user to enter an integer
    mov edx,OFFSET prompt
    call WriteString
    call ReadInt
    mov integer1,eax

	inc rows                	; go to the next row
	mov dh,rows
	mov dl,cols
	call Gotoxy
    ; Prompt the user to enter an integer
    mov edx,OFFSET prompt
    call WriteString
    call ReadInt
    
    ; Add the two numbers. EAX is currently holding one of the
    ; user's numbers so we only need to add the first to EAX
    ; mov eax,integer1
    add eax,integer1
    ; Display the results
    inc rows
	mov dh,rows
	mov dl,cols
    call Gotoxy
    mov edx,OFFSET results
    call WriteString
    call WriteInt

    ; Display "Press any key to continue..." so that
    ; we can see what the program did before it
    ; closes
	call Crlf
	inc rows
	mov dh,rows
	mov dl,cols
    call Gotoxy
    call WaitMsg
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
	mov eax,0			; clear EAX & EDX
	mov edx,0

	; find the size of the screen buffer
	; - AX: number of rows
	; - DX: number of columns
	CALL GetMaxXY
	shr al,1			; divide by 2 to get center
	shr dl,1
	mov dh,al			; move DH = (num of rows) / 2

	ret					; cooridnates are in EDX
GetScreenCenter ENDP
END main