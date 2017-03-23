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

	; open file if there
	call opnfile
	jc _screen2

    ; store filepointer in filehandle
    mov [filehandle], ax

	; read file into temp file and close it
	call clrscr
	call rdfile
	call clofile

_screen2:

	jnc _savechar
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

; open file if there
opnfile proc 	near
		mov ah, 3dh
		mov al, 0h
		lea dx, filename
		int 21h
		ret
opnfile endp

; read file into temp file
rdfile 	proc 	near
		mov cx, 1

	_rd_start:
		lea dx, data
		mov ah, 3fh
		mov bx, filehandle
		int 21h

		cmp ax, 0
		je _rd_done

		mov ah, 40h
		mov bx, temphandle
		int 21h

		; display on screen
		mov ah, 02h
		mov dl, [data]
		int 21h

		jmp _rd_start

	_rd_done:
		ret
rdfile 	endp

; read contents of temp file
shtemp 	proc 	near
		mov cx, 1
		mov bx, temphandle
	_sh_start:
		lea dx, data
		mov ah, 3fh
		int 21h
		cmp ax, 0
		je _sh_done

		mov dl, [data]
		mov ah, 02h
		int 21h

		jmp _sh_start

	_sh_done:
		ret
shtemp 	endp

; move to top of file in bx
m2top 	proc 	near
		mov ah, 42h
		mov al, 0
		mov dx, 0
		int 21h
		ret
m2top 	endp

; close the file
clofile proc    near
        mov ah, 3eh
        mov bx, filehandle
        int 21h
        ret
clofile endp

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

; save (rename) temp to file
s2file  proc    near
        mov ah, 56h
        lea dx, tempfile
        lea di, filename
        mov cl, 0
        int 21h
        ret
s2file  endp

end
