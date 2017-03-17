.model tiny
.data

    filenamemax db  12
    filenameact db  ?
    filename    db  14 dup(0)
    filehandle  dw  ?

    tempfile    db  'temp.tmp', 0
    temphandle  dw  ?

    data        db  ?


    welcome     db  'This is text editor', 0ah,
                    'Once inside the editor,', 0ah,
                    'Press <ctrl+s> to save and quit', 0ah,
                    'Press <ctrl+q> q to quit', 0ah,  '$'

    fileprompt  db  0ah, 'Enter filename: ', '$'

.code
.startup

_screen1:

    call clrscr

    ; show welcome msg
    lea dx, welcome
    call print

    ; show filename prompt
    lea dx, fileprompt
    call print

    ; get filename
    lea dx, filenamemax
    call scan

    ; clean filename (remove 0dh)
    call cleanfn

    ; create temp file
    call lodtemp

_screen2:

    ; store filename in filehandle
    mov [filehandle], ax

    call clrscr

    _savechar:
        
        call getchar

        ; save file
        cmp al, 13h  ; 13 -> ascii for ctrl+s 
        je _save

        ; quit file
        cmp al, 11h  ; 11 -> ascii for ctrl+q
        je _quit

        ; enter pressed
        cmp al, 0dh
        jne _normal
        mov al, 0ah

        ; normal char entered
        _normal:

            ; display on screen
            mov dl, al
            call putchar

            ; save to buffer
            mov [data], al
            call savbuf
            
            jmp _savechar

        ; repeat getting and processing char again
        jmp _savechar


; save and close the file.
_save:

    ; save EOF to buffer
    mov [data], 0ah
    call savbuf

    call clotemp
    call delfile
    call s2file

; close the file and exit clearing the screen
_quit:
    call clrscr

.exit

; clearscreen
clrscr  proc    near
        mov ax, 0003h
        int 10h
        ret
clrscr  endp

; print dx on screen
print   proc    near
        mov ah, 09h
        int 21h
        ret
print   endp

; store input at dx+2
scan    proc    near
        mov ah, 0ah
        int 21h
        ret
scan    endp

; get a char in al
getchar proc    near
        mov ah, 08h
        int 21h
        ret
getchar endp

; output a char in dl
putchar proc    near
        mov ah, 02h
        int 21h
        ret
putchar endp

; clean filename
cleanfn proc    near
        lea si, filename
        lea di, filename

    _cleanjmp:
        lodsb
        cmp al, 0dh
        jne _next
        mov al, 0
    _next:
        stosb
        cmp al, 0
        jne _cleanjmp
        ret
cleanfn endp

; create temp file
lodtemp proc    near
        mov ah, 3ch
        mov cl, 07h
        lea dx, tempfile
        int 21h
        mov [temphandle], ax
        ret
lodtemp endp

; close the temp file
clotemp proc    near
        mov ah, 3eh
        mov bx, temphandle
        int 21h
        ret
clotemp endp

; moves character in buffer to temp file
savbuf  proc    near
        lea dx, data
        mov bx, temphandle
        mov cx, 1h
        mov ah, 40h
        int 21h
        ret
savbuf  endp

; delete the file
delfile proc    near
        mov ah, 41h
        lea dx, filename
        int 21h
        ret
delfile endp

; rename temp to file
s2file  proc    near
        mov ah, 56h
        lea dx, tempfile
        lea di, filename
        mov cl, 0
        int 21h
        ret
s2file  endp

end
