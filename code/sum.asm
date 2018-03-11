comment * -----------------------------------------------------
                     Microsoft Macro Assembler 5.0
                      Build this console app with
                          masm.exe sum.asm
                          link.exe sum.obj
                          sum.exe
        ----------------------------------------------------- *

data    segment
        array   db 1, 2, 3, 4, 5, 6, 7, 8, 9, 10;定义10个字节的数组变量 array
        count   equ $ - array;定义计算数组长度的变量 count
        sum_str db '00', 0dh, 0ah, '$';定义结果变量 sum_str '0'->30h, '1'->31h
data    ends

stack   segment para stack 'stack'
;        stak    db 10 dup(?);定义堆栈变量 stak
;        top     equ length stak;定义堆栈长度变量 top
stack   ends

code    segment
        assume  cs:code, ds:data, ss:stack
start:  mov ax, data;将数据段基址传入 ds
            mov ds, ax
            mov ax, 0
            mov bx, offset array;将 array 变量地址保存到 bx
            mov ax, count;将 loop 时使用到的计数值 count 传入 cx
            mov cx, ax
            mov ax, 0
sum:    add al, [bx];循环累加 array 数据，结果保存在 al
            adc ah, 0;处理进位
            inc bx;bx转到下一个数
            loop sum;循环累加直到 cx - 1 的值为0
show:   mov bl, 10;计算 ax 的10位、个位的值，分别保存在al, ah中
            div bl;al = (ax / 10), ah = (ax \ 10)
            add ax, '00';将 al, dl 的值都加上 ‘0’->30h 以将数字转化为10进制数字对应的字符串
            mov sum_str, al
            mov sum_str + 1, ah
            mov dx, offset sum_str;显示计算结果
            mov ax, 0900h
            int 21h
exit:   mov ax, 4c00h;退出程序
            int 21h
code    ends
end     start

            