;Title DISPLAY.ASM
;This file displays a binary value found in the display
;register "DisplayRegister". The binary value is converted
;to BCD and then displayed.
;
;********** This routine LedValue should always be in Pg 0 ***************
;This is the lookup table for the 7 segment LED digits
;Although lookup tables can reside anywhere, code is highly
;simplified when the table lookup is placed in pg 0, specially
;when the table itself is small.
;The segment of code should always reside in pg 0 or else
;the lookup will not execute properly.
        org     0x10
LedValueAddress
        if LedValueAddress < 0x100 ;move out of pg 0 at own risk
LedValue
        clrf    _pclath
        addwf   _pcl
        retlw   0xfc    ;code for 0
        retlw   0x60    ;code for 1
        retlw   0xda    ;code for 2
        retlw   0xf2    ;code for 3
        retlw   0x66    ;code for 4
        retlw   0xb6    ;code for 5
        retlw   0xbe    ;code for 6
        retlw   0xe0    ;code for 7
        retlw   0xfe    ;code for 8
        retlw   0xe6    ;code for 9
        endif
;*************************************************************************
;
;
;*************************************************************************
;       THIS SUBROUTINE CONVERTS A 8 BIT BINARY WORD
;       INTO A 3 DIGIT BCD
;       THE INPUT IS IN DisplayRegister
;       OUTPUT IS IN accc and accd WITH  lsd in accd.
;       The basic idea is the a 8 bit binary # has a value
;       between 0 and 255. First we check if the # is > 99
;       then if it is > 199. After each check we dec the MSD
;       Lastly we convert the LSD which will have a value 
;       between 0 and 99.
;
;*************************************************************************
Bin8toBcd3
        movlw   2
        movwf   accc
        clrf    temp
        movlw   .199      ;check if # is > 199
        subwf   DisplayRegister,w    
        btfsc   _z        ;= 199?
        goto    Bcd99B
        btfsc   _c        ;       /
        goto    Bcd199    ;yes then do >200 #
Bcd99B
        decf    accc      ;else inc Msd of BCD
        movlw   .99       ;and see > 99
        subwf   DisplayRegister,w
        btfsc   _z        ; == 99?
        goto    Bcd99A    ;yes then skip over
        btfsc   _c        ;       /
        goto    Bcd199    ;no then do 99
Bcd99A
        decf    accc
Bcd99
        movf    DisplayRegister,w
        movwf   accd
        goto    get10th                     
Bcd199
        movwf   accd      ;get result in ACCD
        decf    accd      ;dec to get correct value
get10th                   
        movlw   .10
        subwf   accd,w    ;reduce by 10
        btfss   _c        ;see if done
        goto    BcdOver   ;yes then end
        movwf   accd      ;get new value in ACCD
        incf    temp      ;inc 10s count
        goto    get10th   ;do next
BcdOver                   
        swapf   temp,w    ;get in w
        iorwf   accd      ;or with 1s
        return
;        
;        
;**************************************************************       
;       This routine displays 3 digits on a LT8522 display.
;       Three wires are required to drive the display
;       Enable --> active low when writing to display
;       Clock  --> 1 start bit followed by 35 more (36 total)
;                  36 clock required for load to occur.
;                  Rising edge of Clock is active.
;       Data   --> start data bit = high; 
;                  1st data bit --> segment A of MSD
;                  2nd data bit --> segment B of MSD
;                  so on...
;                  8th data bit --> d.p. of MSD
;                  9th data bit --> segment A of 2nd digit
;                  10th data bit --> segment B of 2nd digit
;                  so on...
;                  16th data bit --> d.p. of 2nd digit
;                  17th data bit --> segment A of LSD
;                  18th data bit --> segment B of LSD
;                  so on ...
;                  24th data bit --> d.p. of LSD
;                  25th data bit --> appears on pin 4 of display
;                  26th data bit --> appears on pin 5 of display
;                  so on ...
;                  34th data bit --> appears on pin 13 of display.
;                  to drive segment set data = high.
;
;       The routine does a leading zero blanking.
;       The 3 BCD nibbles should be available in accc and accd,
;       with the MSD in the low nibble of accc and the LSD in the
;       low nibble of accd. The discrete led will be set as per the
;       values in the AuxDsp register.
;******************************************************************
Display
        call    StartDisplay
        movf    accc,w
        btfsc   _z              ;see if ACCC = 0
        goto    NoMsd
ShowMsd
        bcf     _gie
        bcf     _gie            ;disable interrupt
        call    LedValue
        bsf     _gie
        call    DisplayW
Show2sd
        swapf   accd,w
        andlw   0x0f
        bcf     _gie
        bcf     _gie            ;disable interrupt
        call    LedValue
        bsf     _gie
        btfss   _dcled          ;if dc on then clr
        iorlw   0x01            ;else set lsb
        call    DisplayW
ShowLsd
        movf    accd,w
        andlw   0x0f
        bcf     _gie
        bcf     _gie            ;disable interrupt
        call    LedValue
        bsf     _gie
        call    DisplayW
        movf    AuxDsp,w                ;get aux value
        andlw   B'11111100'             ;mask low 6 bits
        call    DisplayW
        call    EndDisplay
        return
;
;
DisplayW
        movwf   temp
        movlw   .8
        movwf   acca
DisplayLoop
        rlf     temp
        btfsc   _c
        bsf     _ledData
        bsf     _ledClk
        nop
        bcf     _ledClk
        bcf     _ledData
        decfsz  acca
        goto    DisplayLoop
        return
;
;
NoMsd
        movlw   0
        call    DisplayW
Check2sd
        swapf   accd,w
        andlw   0x0f
        btfss   _z
        goto    Show2sd
No2sd
        movlw   0
        call    DisplayW
        goto    ShowLsd
;
StartDisplay
        bcf     _ledData
        bcf     _ledClk
        nop
        bcf     _ledEn
        bsf     _ledData
        bsf     _ledClk
        nop
        bcf     _ledClk
        bcf     _ledData
        return
;
EndDisplay
        bsf     _ledClk
        bcf     _ledClk
        bsf     _ledClk
        bcf     _ledClk
        bsf     _ledClk
        bcf     _ledClk
        bsf     _ledEn
        return


;

