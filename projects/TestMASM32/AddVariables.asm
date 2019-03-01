; AddVariables.asm - Chapter 3 example

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
firstval    DWORD   20002000h
secondval   DWORD   11111111h
thridval    DWORD   22222222h
sum         DWORD   0

.code
main PROC
    ; x86 doesn't allow you to add one variable directly to another, but it
    ; does allow a variable to added to a register. That's why EAX is used
    ; as an accumulator below
    mov eax,firstval
    add eax,secondval
    add eax,thridval
    mov sum,eax

    INVOKE ExitProcess,0
main ENDP
END main