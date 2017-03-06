.model tiny
.386
.data
    
    data    db      -126, 8, -9, 5, 126, 6, -12, 41, -21
    garb    db      00, 00          ; empty space to differentiate result
    count   equ     9
    div3    db      count dup(0)
    garb2   db      00, 00          ; empty space to differentiate result

.code
.startup
    
    ; initialize
    lea si, data
    lea di, div3

    mov bl, 3
    mov cl, count

_start:

    ; move and sign extend
    mov al, [si]
    movsx ax, al

    idiv bl
    cmp ah, 0       ; remainder is in ah
    jnz _skip

    movsb
    jmp _conti

_skip:
    inc si

_conti:
    loop _start

.exit
end
