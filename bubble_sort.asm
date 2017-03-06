; sort numbers by bubble sort
.model tiny
.386
.data

    data    db  1, 5, 3, 4, 2, 9, 7, 5, 4, 0
    count   equ 10

.code
.startup

    ; number of sorted elements
    mov bx, 0

_sort:

    ; inititalize to start of array
    lea si, data
    lea di, [data + 1]

    ; get count
    mov cl, count 
    
    ; subtract the number of sorted elements from count
    sub cl, bl

    _test:
        mov dl, [di]
        cmp dl, [si]
        jg  _inc

        ; swap elements
        mov al, [di]
        movsb
        mov [si - 1], al

        jmp _conti

    _inc:
        inc si
        inc di

    _conti:
        loop _test

    ; increment number of sorted elements
    inc bx

    ; run till all elements are sorted
    cmp bl, count
    jnz _sort

.exit
end
