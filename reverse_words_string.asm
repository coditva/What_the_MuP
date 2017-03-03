; reverse words seperated by spaces in a string. starting and ending must be 
; spaces too
.model tiny
.386
.data
    data    db  ' abcd efgh ijklmb nop a '
    len     equ 24
    count   equ 5

.code
.startup
    
    lea si, data
    lea di, data
    mov cl, count
    mov ah, count
    
_getsp:

    mov al, [di + 1]

    cmp al, ' '
    je _storit

    inc di
    jmp _getsp


_storit:
    
    mov dx, di
    inc si

_stoloop:

    cmp si, di
    jge _inc

    mov al, [di]
    movsb

    dec si
    mov [si], al
    sub di, 2
    inc si

    jmp _stoloop


_inc:
    
    inc dx
    mov si, dx
    mov di, dx

    loop _getsp

.exit
end
