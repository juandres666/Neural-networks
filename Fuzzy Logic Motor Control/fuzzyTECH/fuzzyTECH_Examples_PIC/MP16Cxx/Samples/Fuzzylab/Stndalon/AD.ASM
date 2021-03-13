;This include file contains the sub-routines required to sample the 
;temperature sensor. The a/d value is determined every 100mSec and 
;updated on the display.
;
GetAd
        movlw   B'11000001'
        movwf   _adcon0
        call    Delay20uS
        bsf     _go
adchk0
        btfss   _adif
        goto    adchk0
        bcf     _adif
        call    CalPT                   ;calculate present temp
        movwf   PresentTemp             ;save as present temp
        btfsc   _FlashHot               ;if hot then check at lower limit
        goto    Below73                 ;see if gone below 73
        sublw   .74                     ;see if above 74
        btfss   _c                      ;no then skip
        bsf     _FlashHot               ;show hot on display
DoCh1
        btfss   _manled                 ;manual on then do      
        goto    DoCh2                   ;else do ch 2
        bcf     _chs1                   ;select ch1
        bsf     _chs0
        call    Delay20uS               ;allow for sample
        bsf     _go                     ;start conversion
adchk1
        btfss   _adif
        goto    adchk1
        bcf     _adif
        comf    _adres
        call    CalDC                   ;calculate dc
        movwf   lv1_DutyCycle           ;save as new duty cycle
DoCh2
        bcf     _chs0
        bsf     _chs1                   ;select ch 2
        call    Delay20uS               ;allow for sample
        bsf     _go                     ;start conversion
adchk2
        btfss   _adif                   ;done?
        goto    adchk2                  ;no then check again
        bcf     _adif
        comf    _adres                   ;do a 2s complement
        call    CalFT                   ;calculate final temp
        movwf   FinalTemp               ;save as final temperature
        call    GetDeltaTemp
        return     
;        
Below73
        sublw   .70                     ;< 70
        btfsc   _c                      ;no then quit
        bcf     _FlashHot               ;reset flag
        goto    DoCh1                   ;do next
;
;20 uS at 4Mhz clock speed and includes the call time
Delay20uS
        movlw   5
        movwf   temp
dly20again
        decfsz  temp
        goto    dly20again
        return
;
;
CalPT        
        clrf    accc            ;clr accc
        bcf     _Flash0         ;clr flash 0 flag
        movlw   .79             ;subtract offset
        subwf   _adres          ;       /
        btfss   _c              ;no carry then skip
        goto    FlashCold       ;flash lower limit
        movlw   .4
        movwf   temp
        bcf     _c
Mult16
        rlf     _adres          ;multiply by 16
        rlf     accc            ;shift in accc
        decfsz  temp
        goto    Mult16
        movf    _adres,w
        movwf   accd
        movlw   .15
        movwf   acca            ;load divisor in acca
        call    Div16by8        ;do divide
        bcf     _pthalfvalue      ;clr half led
        rrf     temp,w          ;divide result by 2
        btfsc   _c              ;carry not set hen skip
        bsf     _pthalfvalue      ;else set half led
        return
;
FlashCold
        bsf     _Flash0         ;set flag for below limit
        bcf     _pthalfvalue    ;show 0 on display
        clrw
        return
;
CalDC
        clrf    accc
        bcf     _c
        rlf     _adres,w        ;multiply by 2
        movwf   accd            ;save in accd
        rlf     accc            ;shift in accc
        movlw   .5              ;load divisor
        movwf   acca            ;save in acca
        call    Div16by8        ;do divide
        movlw   .100            ;>100
        subwf   temp,w          ;
        btfsc   _c              ;no then skip
        goto    DC100           ;else dc = 100
        movf    temp,w          ;return with value in w
        return
DC100   
        movlw   .100
        return
;        
;
CalFT
        clrf    accc            ;
        bcf     _c
        rlf     _adres          ;multiply by 4
        rlf     accc
        rlf     _adres,w        ;       /
        movwf   accd            ;save in accd
        rlf     accc            ;shift in accc
        movlw   .17             ;load divisor
        movwf   acca            ;in acca
        call    Div16by8        ;do divide
        bcf     _fthalfvalue      ;clr half led
        movlw   .60             ;see if > 70 (offsetted value)
        subwf   temp,w          ;       /
        btfsc   _c              ;no then skip
        goto    FT70            ;else FT = 70
        rrf     temp,w          ;div by 2
FTOffset
        addlw   .40             ;add offset to it
        btfsc   _c              ;no carry then skip
        bsf     _fthalfvalue      ;set half led 
        return
FT70
        movlw   .30
        goto    FTOffset
;
;This is a 16 bit by 8 bit unsigned divide
;The 16 bit value is loaded in accc and accd, the 8 it
;divisor is loaded in acca
Div16by8
        clrf    temp            ;result is in temp
div16again
        movf    acca,w
        subwf   accd            ;subtract w
        goto    DecHigh         ;reduce high if needed
DecHighReturn
        btfss   _c              ;see if all done
        return                  ;then return
        incf    temp            ;inc temp
        goto    div16again      ;do again
;
DecHigh
        btfsc   _c              ;carry?
        goto    DecHighReturn   ;no then return
        movf    accc            ;check high byte
        btfsc   _z              ;0?
        goto    msdover         ;yes then show that msd over
        movlw   .1
        subwf   accc            ;reduce msd 
        goto    DecHighReturn
msdover
        bcf     _c              ;show carry = 0
        goto    DecHighReturn
;
;
GetDeltaTemp
        bcf     _c              ;clr carry
        rlf     PresentTemp,w   ;get present temp
        movwf   acca            ;save in gp ram
        btfsc   _pthalfvalue    ;half value set?
        bsf     acca,0          ;yes then set lsb
        bcf     _c              ;do same for final temp
        rlf     FinalTemp,w     ;       /
        movwf   accc            ;save in gp ram
        btfsc   _fthalfvalue    ;half value set?
        bsf     accc,0          ;yes then set lsb
        movf    acca,w          ;get Present value in w
        subwf   accc,w          ;Final - Present
        btfss   _c              ;+ve result
        call    Get2sCompl      ;-ve then do 2's compl
        movwf   lv0_DeltaTemp   ;save in ram
        return
Get2sCompl
        movwf   acca            ;save in gp ram
        comf    acca            ;complement value
        incf    acca            ;inc
        bsf     acca,7          ;
        movf    acca,w
        return


