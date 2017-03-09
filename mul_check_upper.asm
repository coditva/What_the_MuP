.model tiny
.386
.data
    
    data    db  88h, 12h, 2h, 15h, 56h, 24h, 0A1h, 88h, 0F1h
    len     equ 9

    mulv    db  5h
    count   db  ?

.code
.startup

    lea si, data        ; load data
    mov cx, len         ; number to be tested
    mov bl, [mulv]      ; check what is to be multiplied
    mov dl, 0h          ; count

_start:
    
    mov ax, 0h          ; clear the reg
    lodsb               ; load value into al
    mul bl              ; multiply

    cmp ah, 0h          ; compare if zero
    jne _continue

    inc dl              ; increment count if its desired result

_continue:
    
    loop _start

    mov [count], dl        ; store the result

.exit
end
