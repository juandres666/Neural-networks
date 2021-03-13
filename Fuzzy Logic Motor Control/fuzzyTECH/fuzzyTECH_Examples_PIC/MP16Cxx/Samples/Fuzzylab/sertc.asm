;In this program we do the routines for the fuzzy logic control
;The routines are sent by the contoller to the PC which has
;the fuzzy explorer project running on it. The PC then sends 
;back the value for the incremental DC which has to be added
;or subtracted from the present value of the DC.
TransmitData
        movf    DeltaTemp,w
        call    SendVariable
        movf    DiffTemp,w
        btfsc   _pdmode
        call    SendVariable
        movlw   0x1a                    ;send the ^Z character
        call    Send1
        return                          ;transmitted to fuzzyTech

ReceiveData
        clrf    _intcon                 ;clr all interrupts
        push                            ;save status and w
        call    Freeze
        call    SetTimeOut              ;set 16mS timeout
;
        call    RecvVariable
        btfsc   _recvabort
        goto    RecvQuit
        call    Bcd3toBin8
        movf    acca,w
        movwf   DutyCycleBuffer
        bsf     _recvdone               ;set flag
        clrf    serialto                ;clr time out
        bcf     _FlashSer               ;and flag
        movlw   B'00100000'             ;set up intcon
        call    UnFreezeRecv
        pop
        retfie
RecvQuit
        bcf     _recvabort
        movlw   B'00100000'             ;set up intcon
        call    UnFreezeRecv
        pop
        retfie

;
;
SetTimeOut
        movlw   B'10000111'             ;set for max. TO
        option                          ;= 16mS at 4Mhz
        clrf    _rtcc                   ;clr rtcc
        bcf     _rtif                   ;amd flag
        return
        
;
SendVariable
        movwf   SerialValue             ;check if +ve or -ve
        movlw   '+'
        btfsc   SerialValue,7
        movlw   '-'
        bcf     SerialValue,7
        movwf   S0
        call    Bin8toBcd3
        call    LoadSerialBuffer
        movlw   S0
        movwf   _fsr
        call    Send
        incf    _fsr
        call    Send
        incf    _fsr
        call    Send
        incf    _fsr
        call    Send
        clrw
        call    Send1
        return
;
;
LoadSerialBuffer
        movf    accc,w
        addlw   0x30
        movwf   S1
        swapf   accd,w
        andlw   0x0f
        addlw   0x30
        movwf   S2
        movf    accd,w
        andlw   0x0f
        addlw   0x30
        movwf   S3
        return
;
;
Send
        movf    0,w
Send1
        call    transmit                ;send data in w
        return
;
;
RecvVariable
        clrf    S2
        call    Recv1
        movlw   0x30
        subwf   rcreg,w
        movwf   S1               
RecvAgain
        call    RecvS           ;get 2nd char
        btfsc   _recvabort      ;abort?
        return                  ;yes then quit
        andlw   0xff            ;
        btfsc   _z
        goto    RecvEnd
        xorlw   0x2e            ;see if decimal point
        btfsc   _z              ;       /
        goto    RecvIgnore      ;yes then ignore
        movlw   0x30
        subwf   rcreg,w
        movwf   S3
        swapf   S3
        movlw   .4
        movwf   count
shftloop
        bcf     _c
        rlf     S3            ;1 bit
        rlf     S1
        rlf     S2
        decfsz  count
        goto    shftloop
        ;
        goto    RecvAgain
RecvEnd
        call    RecvS           ;is char == 0x1A?
        btfsc   _recvabort      ;abort done?
        return                  ;yes then quit
        xorlw   0x1a
        btfss   _z
        nop                     ;receive 2nd output        
        return
RecvIgnore
        call    RecvS
        btfsc   _recvabort
        return
        andlw   0xff
        btfsc   _z
        goto    RecvEnd
        goto    RecvIgnore

;
;
RecvS
        btfsc   _rtif           ;time out occured?
        goto    RecvAbort       ;abort receive
        btfsc   _rx             ;see if start bit
        goto    RecvS           ;else look for start bit
Recv1
        goto    receive
RecvReturn
        movf    rcreg,w
        return
;
RecvAbort
        bcf     _rtif           ;clr rtcc int flag
        bsf     _recvabort
        return
;
;
Bcd3toBin8
        movf    S2,w          ;check flag
        btfss   _z              ;
        call    add100s         ;yes then add
        swapf   S1,w          ;get 10s value
        andlw   0x0f            ;mask hi bits
        btfss   _z              ;check if 0
        call    add10s
        movf    S1,w
        andlw   0x0f
        btfss   _z
        call    add1s
        return
add100s
        clrw
add100sloop
        addlw   .100
        decfsz  S2
        goto    add100sloop
        movwf   acca
        return    
;        
;
add10s
        movwf   S2
        clrw
add10sloop
        addlw   .10
        decfsz  S2
        goto    add10sloop
        addwf   acca
        return    
;        
;
add1s
        movwf   S2
        clrw
add1sloop
        addlw   .1
        decfsz  S2
        goto    add1sloop
        addwf   acca
        return    


        

        




        
