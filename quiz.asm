; A simple quiz made in assembly
; Add questions and options by seeing the examples
;
; copyright 2017 UTkarsh Maheshwari
; <utkarshme96@gmail.com>
; Date: 6 March 2017

.model small
.386
.data

    prompt      db  ">> $"
    welcome     db  "Welcome to the UTkarsh Maheshwari's MuP Quiz!!$"
    help        db  "This game works just by entering numbers. Press 9 to quit anytime$"
    help2       db  "Press any key to start...$"
    losemsg     db  "You have lost... better luck next time!$"
    winmsg      db  "Perfect! On you go to the next level!$"
    wingamemsg  db  "Congratulations!!You have won the whole game!$"
    nextmsg     db  "Press any key to continue...$"
    exit        db  "Press any key to exit...$"


    ; define stage msgs ----------------------------------------------

    ; stage1
    stage1      db  "What is the value of AH register to input a character with echo?$"
    opt1        db  "1. 08H"
    opt1_g1     db  0ah
    opt1_1      db  "2. 02H"
    opt1_g2     db  0ah
    opt1_2      db  "3. 01H"
    opt1_g3     db  0ah
    opt1_3      db  "4. 09H$"
    correct1    db  '3'


    ; stage2
    stage2      db  "What is the interrupt value to get keyboard input/output?	$"
    opt2        db  "1. 21H"
    opt2_g1     db  0ah
    opt2_1      db  "2. 10H"
    opt2_g2     db  0ah
    opt2_2      db  "3. 11H"
    opt2_g3     db  0ah
    opt2_3      db  "4. 20H$"
    correct2    db  '1'


    ; stage3
    stage3      db  "Where is the remainder stored in a 16bit/8bit division?$"
    opt3        db  "1. DX"
    opt3_g1     db  0ah
    opt3_1      db  "2. DH"
    opt3_g2     db  0ah
    opt3_2      db  "3. AX"
    opt3_g3     db  0ah
    opt3_3      db  "4. AH$"
    correct3    db  '4'


    ; stage4
    stage4      db  "Which program among the following compiles as well as links an ALP?$"
    opt4        db  "1. Masm.exe"
    opt4_g1     db  0ah
    opt4_1      db  "2. Link.exe"
    opt4_g2     db  0ah
    opt4_2      db  "3. Ml.exe"
    opt4_g3     db  0ah
    opt4_3      db  "4. Debugx.com$"
    correct4    db  '3'


    ; stage5
    stage5      db  "Which command in Debugx should be used to execute INT instructions?$"
    opt5        db  "1. U"
    opt5_g1     db  0ah
    opt5_1      db  "2. P"
    opt5_g2     db  0ah
    opt5_2      db  "3. D"
    opt5_g3     db  0ah
    opt5_3      db  "4. T$"
    correct5    db  '2'


    ; misc vars
    input       db  0

.code
.startup


; first screen -------------------------------------------------------
_welcome:

    ; clear screen
    call clrscr
    call newline

    ; display welcome msg
    lea dx, welcome
    mov ah, 09h
    int 21h
    call newline

    ; display help msg
    lea dx, help
    mov ah, 09h
    int 21h
    call newline

    ; start prompt
    call newline
    lea dx, help2
    mov ah, 09h
    int 21h
    call newline

    ; get a garbage key
    call getinp

; stage1 screen ------------------------------------------------------
_stage1:

    call clrscr
    call newline

    ; display stage1
    lea dx, stage1
    call disp
    call newline
    call newline

    ; display options1
    lea dx, opt1
    call disp
    call newline

    ;call prmt
    call dispmt
    lea di, input
    call getinp

    ; validate and check answer
    mov ah, correct1
    call validate
    cmp dx, 1
    je _stage1
    call check

    ; display win msg
    lea dx, winmsg
    call disp

    ; pause screen for next question
    call newline
    lea dx, nextmsg
    call disp
    call getinp

; stage2 screen ------------------------------------------------------
_stage2:

    call clrscr
    call newline

    ; display stage2
    lea dx, stage2
    call disp
    call newline
    call newline

    ; display options2
    lea dx, opt2
    call disp
    call newline

    ;call prmt
    call dispmt
    lea di, input
    call getinp

    ; validate and check answer
    mov ah, correct2
    call validate
    cmp dx, 1
    je _stage2
    call check

    ; display win msg
    lea dx, winmsg
    call disp

    ; pause screen for next question
    call newline
    lea dx, nextmsg
    call disp
    call getinp

; stage3 screen ------------------------------------------------------
_stage3:

    call clrscr
    call newline

    ; display stage3
    lea dx, stage3
    call disp
    call newline
    call newline

    ; display options3
    lea dx, opt3
    call disp
    call newline

    ;call prmt
    call dispmt
    lea di, input
    call getinp

    ; validate and check answer
    mov ah, correct3
    call validate
    cmp dx, 1
    je _stage3
    call check

    ; display win msg
    lea dx, winmsg
    call disp

    ; pause screen for next question
    call newline
    lea dx, nextmsg
    call disp
    call getinp


; stage4 screen ------------------------------------------------------
_stage4:

    call clrscr
    call newline

    ; display stage4
    lea dx, stage4
    call disp
    call newline
    call newline

    ; display options4
    lea dx, opt4
    call disp
    call newline

    ;call prmt
    call dispmt
    lea di, input
    call getinp

    ; validate and check answer
    mov ah, correct4
    call validate
    cmp dx, 1
    je _stage4
    call check

    ; display win msg
    lea dx, winmsg
    call disp

    ; pause screen for next question
    call newline
    lea dx, nextmsg
    call disp
    call getinp


; stage5 screen ------------------------------------------------------
_stage5:

    call clrscr
    call newline

    ; display stage5
    lea dx, stage5
    call disp
    call newline
    call newline

    ; display options5
    lea dx, opt5
    call disp
    call newline

    ;call prmt
    call dispmt
    lea di, input
    call getinp

    ; validate and check answer
    mov ah, correct5
    call validate
    cmp dx, 1
    je _stage5
    call check

    ; display win game msg
    lea dx, wingamemsg
    call disp


; exit screen --------------------------------------------------------

_exit:
    ; exit prompt
    call newline
    lea dx, exit
    mov ah, 09h
    int 21h
    call newline

    ; get a garbage key
    call getinp

.exit


; define procedures --------------------------------------------------

; clear the screen
clrscr  proc    near
        mov ax, 0003h
        int 10h
        ret
clrscr  endp

; display newline
newline proc    near
        mov dx, 10
        mov ah, 02h
        int 21h
        ret
newline endp

; display prompt
dispmt  proc    near
        call newline
        lea dx, prompt
        mov ah, 09h
        int 21h
        ret
dispmt  endp

; get input
getinp  proc    near
        mov ah, 08h
        int 21h
        mov [input], al
        ret
getinp  endp


; display a msg stored in dx
disp    proc    near
        mov ah, 09h
        int 21h
        ret
disp    endp

; validate input
validate    proc    near
            mov dx, 0

            cmp [input], '1'
            je _val_fine
            cmp [input], '2'
            je _val_fine
            cmp [input], '3'
            je _val_fine
            cmp [input], '4'
            je _val_fine
            cmp [input], '9'
            je _exit

            mov dx, 1

        _val_fine:
            ret
validate    endp

; check user's answer
check   proc    near
        cmp ah, [input]
        je _check_corr

        ; display lose msg
        lea dx, losemsg
        mov ah, 09h
        int 21h
        jmp _exit

    _check_corr:

        ret
check   endp

; user has lost
lose    proc    near
        call clrscr
        call newline
        lea dx, losemsg
        mov ax, 09h
        int 21h
        jmp _exit
        ret
lose    endp
end
