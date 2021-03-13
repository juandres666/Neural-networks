;Title keypad.asm
;This program controls the six keys for the data entry on the temperature
;control board. Everytime a key is hit and acknowledged, the beeper sound
;a beep to acknowledge it to the user. The keys are sampled every 20 mS.
; A debounce of 100 mS is allowed.
;

GetKey  
        btfsc   _debounce       ;if debounce on then quit
        return
        call    WhichKey
        movf    KeyValue,w
        bcf     _gie
        bcf     _gie
        clrf    _pclath
        addwf   _pcl            ;add offet to pc
        goto    NoKey           ;0 is not a key
        goto    StopKey         ;Stop fucntion
        goto    LeftKey         ;Left function
        goto    NoKey           ;3 is not a key
        goto    StartKey        ;Stop function
        goto    NoKey
        goto    NoKey
        goto    NoKey
        goto    RightKey         ;Left function
;
;
;
WhichKey        
        clrf    KeyValue        ;empty value reg
        ;movlw   B'11111110'
        ;movwf   _portb
        bsf     _row1
        bsf     _row2
        bsf     _rp0
        bcf     _rbpu
        bcf     _rp0
        bcf     _row1           ;make row1 low
        call    FindKey         ;get key value w
        btfsc   _z              ;no key ?
        bsf     _2ndrow         ;yes set 2nd row flag
        addwf   KeyValue        ;else add key value
        btfss   _2ndrow         ;check if flag set
        return                  ;no then what key is hit in row1
        bsf     _row1           ;else go turn row1 off
        bcf     _row2           ;turn row2 on
        call    FindKey         ;get key value in w
        bcf     _2ndrow         ;clr flag
        btfsc   _z              ;key hit then skip
        goto    KeyReleased     ;do routine for release
        movwf   KeyValue        ;get key value
        bcf     _c              ;clr carry
        rlf     KeyValue        ;shif into position
        rlf     KeyValue        ;       /
        return

;
;
FindKey
        swapf   _portb,w        ;read columns
        movwf   temp            ;save in temp
        comf    temp,w          ;complement value
        andlw   0x03            ;check only low 2 bits
        return
;
;
KeyReleased
        bcf     _keyhit         ;reset key hit flag
        clrf    KeyValue        ;key value = 0.
        return
;
;
;
StartKey
        bsf     _gie
        bsf     _rtie           ;enable interrupt
        btfsc   _keyhit         ;key released?
        return                  ;no then return
        btfsc   _starton        ;in operation then ignore
        return                  ;       /
        bsf     _keyhit
        bsf     _starton        ;start on
        bsf     _debounce       ;and debounce
        bcf     _nopled         ;turn off nop
        bsf     _rp0
        bcf     _enable9V       ;9V enable set as output
        bcf     _rp0
        btfss   _pdmode         ;skip if in Pd mode
        return                  ;else return
        call    BlankDisplay
        call    ShowPd          ;else show Pd
        call    BlankDisplay    ;return to normal
        return
;
;
StopKey
        bsf     _gie
        bsf     _rtie           ;enable interrupts
        btfsc   _keyhit         ;key release?
        return                  ;no then ignore
        btfss   _starton        ;stopped then ignore
        return                  ;       /
        bsf     _keyhit
        bcf     _starton        ;else clear flag   
        bsf     _debounce       ;and set debounce
        bsf     _nopled
        bsf     _rp0            
        bsf     _enable9V       ;9V enable drive hi-Z
        bcf     _rp0
        clrf    serialto
        clrf    ErrorFlags
        clrf    DutyCycleBuffer ;stop pwm
        clrf    DutyCycle       ;       /
        bcf     _pwm
        return
;
;
RightKey
        bsf     _gie
        bsf     _rtie           ;enable interrupts
        btfsc   _keyhit         ;key released?
        return                  ;no then ignore
        btfsc   _FlashHot       ;if hot then quit
        return
        btfsc   _FlashSer       ;if serial error?
        return                  ;quit
        btfsc   _dcled          ;right most LED on?
        return                  ;yes then ignore
        btfsc   _ptled          ;pt led on?
        goto    RightSetDc      ;set dcled
        bcf     _ftled          ;clr ftled
        bsf     _ptled
RightKeyEnd
        bsf     _keyhit         ;turn on key hit flag
        bsf     _debounce       ;and show debounce
        return
RightSetDc
        bcf     _ptled
        bsf     _dcled
        goto    RightKeyEnd
;
;
LeftKey
        bsf     _gie
        bsf     _rtie           ;enable interrupts
        btfsc   _keyhit         ;key released?
        return                  ;no then ignore
        btfsc   _FlashHot       ;if hot then quit
        return
        btfsc   _FlashSer       ;if serial error?
        return                  ;quit
        btfsc   _ftled          ;left most LED on?
        return                  ;yes then ignore
        btfsc   _ptled          ;pt led on?
        goto    LeftSetFt       ;set ft
        bcf     _dcled          ;clr dc led
        bsf     _ptled          ;set pt led
LeftKeyEnd
        bsf     _keyhit         ;turn on key hit flag
        bsf     _debounce       ;and show debounce
        return
LeftSetFt
        bcf     _ptled
        bsf     _ftled
        goto    LeftKeyEnd
;
;
NoKey
        bsf     _gie
        bsf     _rtie           ;enable interrupts
        return
;




        

        
