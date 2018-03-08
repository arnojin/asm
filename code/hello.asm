comment * -----------------------------------------------------
                     Microsoft Macro Assembler 5.0
                      Build this console app with
                          masm.exe hello.asm
                          link.exe hello.obj
                          hello.exe
        ----------------------------------------------------- *

data    segment
        message db 'hello world!$'
data    ends

code    segment
        assume cs:code,ds:data
start:  mov ax, data
            mov ds, ax
            lea dx, message
            mov ah, 9
            int 21h
        mov ah, 4ch
            int 21h
code    ends
end     start