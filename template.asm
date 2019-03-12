; Template for x86 assembly programs (template.asm)
; From Assembly Language for x86 Processors, Kip Irvine

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

; Data segment
.data
    ; declare variables here

; Code segment
.code
main PROC
    ; write code here

    INVOKE ExitProcess,0
main ENDP
END main