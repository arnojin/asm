comment * -----------------------------------------------------
                     Microsoft Macro Assembler 5.0
                      Build this console app with
                          masm.exe test.asm
                          link.exe test.obj
                          test.exe
        ----------------------------------------------------- *

data    segment
        message db 'Hello World !', 0dh, 0ah
                db 'This is a sample program of keyboard and display .', 0dh, 0ah
                db 'Please strike the key !', 0dh, 0ah, '$'
data    ends

stack   segment para stack 'stack'
        db 50 dup(?)
stack   ends

code    segment
        assume cs:code, ds:data, ss:stack
start:  mov ax, data
            mov ds, ax
            mov dx, offset message
            mov ah, 9
            int 21h
again:  mov ah, 1
            int 21h
            cmp al, 1bh
            je exit
            cmp al, 61h
            jc nd
            cmp al, 7ah
            ja nd
            and al, 11011111b
nd:     mov dl, al
            mov ah, 2
            int 21h
            jmp again
exit:   mov ah, 4ch
            int 21h
code    ends
end     start

            