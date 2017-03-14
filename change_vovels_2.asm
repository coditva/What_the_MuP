.model tiny
.data

    welcome db  'Welcome! this program replaces vovels with @', 0ah, '$'
    prmt    db  'Enter text: $'
    count   equ 10
    max     db  12
    actu    db  ?
    text    db  count dup ('$')

.code
.startup

    ; display welcome msg
    lea dx, welcome
    call print

    ; display prompt
    lea dx, prmt
    call print

    ; get text
    lea dx, max
    mov ah, 0ah
    int 21h

; compare and replace

    lea si, text
    lea di, text

_start:

    ; load character into al
    lodsb

    cmp al, 'a'
    je _change
    cmp al, 'e'
    je _change
    cmp al, 'i'
    je _change
    cmp al, 'o'
    je _change
    cmp al, 'u'
    je _change

    cmp al, 'A'
    je _change
    cmp al, 'E'
    je _change
    cmp al, 'I'
    je _change
    cmp al, 'O'
    je _change
    cmp al, 'U'
    je _change

    ; increment DI if no change
    inc di
    jmp _continue

_change:

    ; change character in the string
    mov al, '@'
    stosb

_continue:
    loop _start

    ; display newline
    mov dx, 10
    mov ah, 02h
    int 21h

    ; display new text
    lea dx, text
    call print

.exit

; print the text in dx
print   proc    near
        mov ah, 09h
        int 21h
        ret
print   endp

end
