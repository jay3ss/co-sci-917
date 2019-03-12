; Joshua Saunders
; CO SCI 917
; SubtractVariables.asm
; Subtracting three integers.
;
; Prompt:
; Using the ADDSUB program from section 3.2 as a reference, write a program
; that subtracts three integers only 16-bit registers. Insert a cal DumpRegs
; statement to display the register values.

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.data
firstval    WORD   2222h
secondval   WORD   1111h
thirdval    WORD   0022h

.code
main PROC
    mov ax,firstval			; move firstval into the AX register
    sub ax,secondval		; subtract secondval from AX and store result in AX
    sub ax,thirdval			; subtract thirdval from AX and store result in AX

    call DumpRegs			; the first 16 bits of the EAX register (AX) will
							; show 10EFh
    INVOKE ExitProcess,0
main ENDP
END main