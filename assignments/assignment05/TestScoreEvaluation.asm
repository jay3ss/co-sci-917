; Joshua Saunders
; CO SCI 917
; Midterm:
; TestScoreEvaluation.asm
;
; Prompt:
;
; Create a procedure named CalcGrade that receives an integer value between 0
; and 50, and returns a single capital letter in the AL register. Preserve all
; other register values between calls to the procedure. The letter returned by
; the procedure should be displayed and should be according to the following
; ranges:
;
; Score 45 to 50 Grade A
; Score 40 to 44 Grade B
; Score 35 to 39 Grade C
; Score  0 to 34 Grade F
;
; Write a test program that
;
; 1. asks the user to enter integer between 0 and 50, inclusive. If the user
;    enters invalid number, please display error message.
;
; 2. Pass it to the CalcGrade procedure.
;
; 3. Repeat steps 1 and 2 three times so that you collect three scores from the
;    user and display the respective grade for each score.

; .386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

; Data segment
.data
; Constants
MIN_GRADE DWORD 0        ; minimum grade allowed
MAX_GRADE DWORD 50       ; maximum grade allowed

; User input
gradeLtrs BYTE 3 DUP(?)  ; the calculated letter grades arrays

; Prompts, error messages, and other text
gradePrompt     BYTE "Enter an integer (0 through 50): ",0
outOfRangeMsg   BYTE "You must enter an integer from 0 through 50",0
calcGradesMsg   BYTE "The grades for the test scores are",0
gradeListText	BYTE "- ",0

; Code segment
.code
main PROC
    mov esi,0                   ; Index variable for the gradeLtrs array
    mov ecx,SIZEOF gradeLtrs    ; How many scores we need to get

    ; Get the scores from the user, calculate the grades, save the grades into
    ; the gradeLtrs array
    GET_SCORES:
        ; Get user input and validate it. Prompt the user to enter an integer
        ; that's in the range [0, 50]. If it is out of this range, let the
        ; user know and prompt the user to enter another integer. Keep doing
        ; this until a valid integer is entered
        .REPEAT
            call PromptAndGetInt
            .IF (eax < MIN_GRADE || eax > MAX_GRADE)
                call DisplayErrorMsg
            .ENDIF
        .UNTIL (eax >= MIN_GRADE && eax <= MAX_GRADE)
        ; Calculate the letter grade then save it
        call CalcGrade
        mov gradeLtrs[esi],al
        inc esi
        loop GET_SCORES

    ; Setup for displaying the grades to the user
    call Crlf
    mov edx,OFFSET calcGradesMsg
    call WriteString

    mov esi,0
    mov ecx,SIZEOF gradeLtrs
    mov edx,0

    call Crlf

    ; Now that we have the letter grades, let's display them to the user
    DISPLAY_GRADES:
        call Crlf
        mov al,gradeLtrs[esi]
        call DisplayGrade
        inc esi

        loop DISPLAY_GRADES
    exit
main ENDP

;------------------------------------------------------------------------------
; CalcGrade
; Calculates a letter grade based on the numerical score that is passed to the
; procedure. The letter grade is based on the following table
;
; SCORE    | GRADE
; -----------------
; 45 to 50 |  A
; 40 to 44 |  B
; 35 to 39 |  C
;  0 to 34 |  F
;
; Receives: AL = integer value between 0 and 50
; Returns: AL = a single capital letter, a character that represents
;   a letter grade from the set {'A', 'B', 'C', 'F'}
;------------------------------------------------------------------------------
CalcGrade PROC
    .IF al >= 45
        mov al,'A'
    .ELSEIF al >= 40
        mov al,'B'
    .ELSEIF al >= 35
        mov al,'C'
    .ELSE
        mov al,'F'
    .ENDIF
	ret
CalcGrade ENDP

;---------------------------------------------------------
; PromptAndGetInt
; Prompts the user for input and returns the input
; Receives: Nothing
; Returns: EAX = the integer entered by the user
;---------------------------------------------------------
PromptAndGetInt PROC uses edx
    mov edx,OFFSET gradePrompt      ; move the prompt to the edx register
    call WriteString                ; display the prompt
    call ReadInt                    ; get the user input
    ret
PromptAndGetInt ENDP

;------------------------------------------------------------------
; DisplayErrorMsg
; Displays an error message when an integer that is out of bounds
; (0 through 50) is entered by the user
; Receives: Nothing
; Returns: Nothing
;------------------------------------------------------------------
DisplayErrorMsg PROC uses edx
    mov edx,OFFSET outOfRangeMsg    ; move the prompt to the edx register
    call WriteString                ; display the prompt
    call Crlf                       ; newline
    ret
DisplayErrorMsg ENDP

;---------------------------------------------------------------------
; DisplayGrade
; Displays a grade as a list item. If the character 'A' is in the AL
; register, then this procedure will print
;
; - A
;
; Receives: AL = a single capital letter, a character that represents
;   a letter grade from the set {'A', 'B', 'C', 'F'}
; Returns: Nothing
;---------------------------------------------------------------------
DisplayGrade PROC uses edx
    mov edx,OFFSET gradeListText    ; move the list text to the edx register
	call WriteString                ; write the list text
    call WriteChar                  ; write the grade that's in the AL reg
    ret
DisplayGrade ENDP
END main