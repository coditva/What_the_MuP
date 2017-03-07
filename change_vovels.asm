; Change all vovels in a string to '@'
.model tiny
.data

    quote1  db  'What goes round comes round!'
    len     equ 28

.code
.startup

    ; initialize
    lea si, quote1
    lea di, quote1
    mov cl, len

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


.exit
end
