; Joshua Saunders
; CO SCI 917
; SubtractVariables.asm
; Subtracting three integers.
;
; Prompt:
; Using the ADDSUB program from the section 3.2 as a reference, write a program
; that subtracts three integers only 16-bit registers.  Insert a cal DumpRegs
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
total       WORD   0

.code
main PROC
    mov ax,firstval			
    sub ax,secondval
    sub ax,thirdval
    mov total,ax

    call DumpRegs
    INVOKE ExitProcess,0
main ENDP
END main