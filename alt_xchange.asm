.model tiny
.386
.data

    data1   db  'abcdefghijklmno'
    data2   db  'ABCDEFGHIJKLMNO'

    len     equ 15

.code
.startup

    lea si, data1
    lea di, data2
    mov cx, len

_start:

    mov al, [di]
    movsb
    mov [si - 1], al

    inc si
    inc di

    sub cx, 2
    cmp cx, 1
    jge _start

.exit
end
