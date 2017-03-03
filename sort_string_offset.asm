; sort strings according to a given offset
.model tiny
.386
.data

    input   db  'microprocessor', 'interfacingmpi', 'programmingmpi', 'architecturess', 'simdsisdmimdmi'

    len     equ  14
    count   equ  5

    offs    equ  3

    ; a grabage white space to seperate output
    garb    db  ' '

    ; 5 * 14 = 70
    sortd   db  70 dup(0)

.code
.startup

    lea di, sortd
    mov ah, count

; init for inner loop
_init:

    lea si, input
    mov cl, count
    mov al, 0
    mov dl, 0

; loop for getting index of wanted string in dl
_soloop:

    cmp al, [si + offs]
    jge _inc

    mov al, [si + offs]
    mov dl, 5
    sub dl, cl

; increment si for next string
_inc:

    add si, 14
    loop _soloop


; get position of the string to be stored
    lea si, input
    mov cl, dl
    cmp cl, 0
    je _skpdpos

_getpos:
    add si, 14
    loop _getpos

_skpdpos:
; store the string
    mov cl, len

_storit:
    movsb
    loop _storit

    ; change the value at offset of stored string to min val
    sub si, 14

    mov dx, di
    lea di, [si + offs]

    mov al, 0
    stosb

    mov di, dx
    dec ah

; do all this count times
    cmp ah, 0
    jne _init

.exit
end
