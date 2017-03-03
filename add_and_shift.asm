; program to add a character at given positions and shift the string
.model tiny
.386
.data

    data1   db  'Microprocessors'
    len     equ 15
    repl    db  '@'
    inpos   db  1, 6, 7, 14
    count   equ 4
    data2   db  19 dup(?)

.code
.startup

    ; load source, destination, replacement char and positions
    lea si, data1
    lea di, data2
    mov al, repl
    mov bx, 0

    ; store count for loop
    mov cl, len

    ; store position number
    mov dh, 0

_rloop:

    ; load position to replace at
    mov dl, [inpos + bx]

    ; compare with current position
    cmp dh, dl
    jne _norep

    ; store char
    stosb
    inc bx

_norep:

    ; store string from pos
    movsb
    inc dh

    loop _rloop

.exit
end
