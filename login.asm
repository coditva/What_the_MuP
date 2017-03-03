.model tiny
.386
.data

  welco     db  'Welcome! Please verify identity$'

  uprmt     db  'Enter username: $'
  umax      db  20
  actuu     db  ?
  usr       db  20 dup('$')

  pprmt     db  'Enter password: $'
  pmax      db  11
  actup     db  ?
  pass      db  11 dup('$')

  uwprmt    db  'Hey there, $'
  noamsg    db  'Wrong password. Bye. $'

  corrp     db  'myPass$$$$$'

.code
.startup

; welcome msg
  lea dx, welco
  mov ah, 09h
  int 21h

; newline
  mov dx, 10
  mov ah, 02h
  int 21h

; show username prompt
  lea dx, uprmt
  mov ah, 09h
  int 21h

; get username
  lea dx, umax
  mov ah, 0ah
  int 21h

; newline
  mov dx, 10
  mov ah, 02h
  int 21h

; show password prompt
  lea dx, pprmt
  mov ah, 09h
  int 21h

; get password
  lea di, pass
  mov cl, pmax

_rpass:

  mov ah, 08h
  int 21h

  cmp al, 0dh
  je _auth

  stosb
  mov dl, '*'
  mov ah, 02h
  int 21h

  loop _rpass

; authenticate user
_auth:
  mov cl, pmax
  lea di, pass
  lea si, corrp

_authloop:
  cmpsb
  jne _noauth
  loop _authloop

; newline
  mov dx, 10
  mov ah, 02h
  int 21h

; show username
  mov ah, 09h
  lea dx, uwprmt
  int 21h
  lea dx, usr
  int 21h

; newline
  mov dx, 10
  mov ah, 02h
  int 21h
  int 21h

  jmp _exit

; Not authenticated
_noauth:

  ; newline
  mov dx, 10
  mov ah, 02h
  int 21h

  lea dx, noamsg
  mov ah, 09h
  int 21h

_exit:

.exit
end
