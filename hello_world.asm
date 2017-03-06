; display 'Hello, world!'
.model tiny
.386
.data

    msg     db  'Hello, world!'
    endl    db  0ah
    endmsg  db  '$'

.code
.startup

    lea dx, msg
    mov ah, 09h
    int 21h

.exit
end
