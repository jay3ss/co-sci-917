; Joshua Saunders
; CO SCI 917
; Assignment 4:
; SimpleAddition2.asm
; 
; Prompt:
; 
; Use the solution program from the preceding exercise
; as a starting point. Let this new program repeat the
; same steps three times, using a loop. Clear the screen
; after each loop iteration.

; .386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

; Data segment
.data
sum             DWORD 0 ; holds the sum of user-inputted ints
inputloopnum    DWORD 2 ; number of times to loop getting user input
mainloopnum     DWORD 3 ; number of times to loop the program
; inputloopcnt    DWORD ? ; number of times input loop has iterated
; mainloopcnt     DWORD ? ; number of times main loop has iterated


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
    mov ecx,inputloopnum

    ; This loop handles getting input from the
    ; user. This occurs inputloopnum times
    GETINTLOOP:
        call Gotoxy
        ; Prompt the user to enter an integer
        mov edx,OFFSET prompt
        call PromptAndGetInt
        add sum,eax

        inc rows                	; increase row
        ; move rows and cols to EDX so that the prompt can be
        ; printed at the correct location
        mov dh,rows
        mov dl,cols
        loop GETINTLOOP             ; end GETINTLOOP

    ; Back to the outer (main) loop
    ; pop ECX so that we can keep track of how many
    ; times the outer loop has run
    pop ecx

    call Gotoxy
    ; print the results
    mov edx,OFFSET results
    call WriteString

    ; move sum into EAX so that we can print it
    mov eax,sum
    call WriteInt
    call Crlf               ; newline

    ; Display "Press any key to continue..." so that
    ; we can see what the program did before it
    ; starts over
    call WaitMsg

    ; clear sum so that we start fresh
    mov sum,0

	loop MAINLOOP           ; end MAINLOOP
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
; Receives: EDX = the prompt (array) offset
; Returns: EAX = the integer entered by the user
;---------------------------------------------------------
PromptAndGetInt PROC
    ; The prompt for the string needs to be
    ; in EDX before calling this procedure
    call WriteString
    call ReadInt

    ret
PromptAndGetInt ENDP
END main