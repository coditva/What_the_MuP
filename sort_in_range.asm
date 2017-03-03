; sort given numbers in 5 ranges
.model tiny
.386
.data
    mark1   db  20, 34, 56, 78, 11, 41, 92, 60
    count   equ 8

    ; range1 -> 0-19, range2 -> 20-39 etc
    range1  db  count dup(0)
    range2  db  count dup(0)
    range3  db  count dup(0)
    range4  db  count dup(0)
    range5  db  count dup(0)

.code
.startup

    ; load data
    lea si, mark1
    mov cl, count

_chloop:

    mov al, [si]

_rc1:
    ; check for range1

    cmp al, 20
    jge _rc2

    ; store in range1
    lea di, range1
    jmp _next


_rc2:
    ; check for range2

    cmp al, 40
    jge _rc3

    ; store in range2
    lea di, range2
    jmp _next


_rc3:
    ; check for range3

    cmp al, 60
    jge _rc4

    ; store in range3
    lea di, range3
    jmp _next


_rc4:
    ; check for range4

    cmp al, 80
    jge _rc5

    ; store in range4
    lea di, range4
    jmp _next


_rc5:
    ; no need for check, store it

    lea di, range5
    jmp _next


_next:
    mov al, [di]
    cmp al, 0
    je _storit

    inc di
    jmp _next

_storit:
    movsb

    loop _chloop

.exit
end
