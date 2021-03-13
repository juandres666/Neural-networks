;*****************************************************************
;TITLE: Fuzzy logic Temperature Control Demo Board.
;
;Program to control the Fuzzy Logic Temperature Control Demo Board.
;The program consists of the following include files
;       <rs232.asm>
;       <display.asm>
;       <keypad.asm>
;The include files control the sub elements of the control program.
;The module basically excepts inputs from the Explorer program thru
;the serial port. Using key-pad inputs, the heating temperature
;can be set manually. The processor transmits the information to
;the Explorer program, which in turn determines the Fuzzy control
;method of heating the sensor. This information is sent back in
;to the controller. The controller takes this information and 
;controls the PWM output to the heating element. It then transmits 
;the temperature of the sensor back to the Explorer project at 
;regular intervals, which in turn computes the Fuzzy control and
;send back new control information. In this interactive manner,
;the user can determine the "speed" and efficency of the control
;algorithm. The Fuzzy logic rules can be varied in the Explorer
;program, thereby giving the user access to the fuzzy control.
;
;
	list p=16c71,f=inhx8m
;
	include "tc.h"
	include "16cxx.h"
;
;
push    macro
	movwf   WBuffer         ;save w reg in Buffer
	swapf   WBuffer         ;swap it
	swapf   _status,w       ;get status
	movwf   StatBuffer      ;save it
	endm
;
pop     macro
	swapf   StatBuffer,w    ;restore status
	movwf   _status         ;       /
	swapf   WBuffer,w       ;restore W reg
	endm
;
;
	org     ResetVector
;
	goto    Start
;
;
	org     InterruptVector
	goto    ServiceInterrupts
;
	include "display.asm"
	include "keypad.asm"
;
Start
	call    ClearRam
	call    InitPorts
	call    InitRTCC
	call    InitAD
	call    StartDisplay
	call    BlankDisplay
	bsf     _ptled           
	bsf     _nopled
	call    WhichKey        ;read row 1 and return in temp
	btfsc   _StopKey        ;stop pressed?
	goto    SetManMode      ;set manual mode
	btfsc   _StartKey       ;start pressed?
	goto    SetPdMode
	bsf     _fuzled         ;turn fuzzy logic led
StartContinue
	bcf     _blankdisplay
	bsf     _recvdone
ConstantCheck
	btfsc   _500mSOver
	call    ServiceHalfSec
	btfsc   _1mSOver
	call    CheckDC
	btfsc   _20mSOver
	call    ServiceKP
	btfsc   _100mSOver
	call    ServiceDisplay
	goto    ConstantCheck                   
;
SetManMode
	bsf     _manled
	goto    StartContinue
;
;
SetPdMode
	bsf     _pdmode
	bsf     _fuzled
	call    ShowPd
StartReleased
	call    WhichKey
	btfsc   _StartKey
	goto    StartReleased
	goto    StartContinue
;
ShowPd
	call    StartDisplay
	movlw   B'11001110'             ;with Pd
	call    DisplayW
	movlw   B'01111010'             ;       /
	call    DisplayW
	clrw                            ;       /
	call    DisplayW
	movf    AuxDsp,w
	andlw   B'11111100'
	call    DisplayW
	call    EndDisplay
	call    LongDelay               ;wait  for 2 Secs
	call    LongDelay
	call    LongDelay
	call    LongDelay
	return
;
;
LongDelay
	clrf    acca
	clrf    accc
LDloop
	goto    $+1
	goto    $+1
	decfsz  accc
	goto    LDloop
	decfsz  acca
	goto    LDloop
	return
;
;ClearRam clears ram from 0x0C to 0x2F.
ClearRam
	movlw   0x0c            ;get first ram location
	movwf   _fsr            ;load in indirect address
CR1
	clrf    0               ;do indirect ram clr
	incf    _fsr            ;inc FSR
	btfss   _fsr,5          ;if bit 5 set then skip
	goto    CR1             ;else clr next ram
	btfss   _fsr,4          ;if bit 4 set then done
	goto    CR1             ;else clr next
	return                  
;        
InitPorts
	clrf    _portb
	clrf    _porta
	bsf     _ledEn          ;disable write to Leds
	bsf     _tx             ;and set transmit high
	bsf     _rp0            ;select pg1
	movlw   3               ;ra0-3 digital i/o
	movwf   _adcon1         ;       /
	movlw   B'00000111'     ;conf. porta
	movwf   _trisa          ;       /
	movlw   B'01110001'     ;conf. portb
	movwf   _trisb          ;       /
	bcf     _rp0            ;select pg0
	return
;
InitRTCC
	movlw   B'11000001'     ;int clk, div by 4
	option                  ;for 1mS interrupt
	movlw   .256 - .250     ;rtcc interrupts 
	movwf   _rtcc           ;every 1 mS
	movlw   B'10100000'     ;enable rtcc int
	movwf   _intcon         ;       /
	movlw   .20             ;
	movwf   _20mStmr        ;
	movlw   .5              ;
	movwf   _100mStmr       ;
	movwf   _500mStmr
	return
;
;
InitAD
	movlw   B'11000000'     ;sel. RC clk for a/d
	movwf   _adcon0         ;       /
	return
;
;
ServiceInterrupts
	btfsc   _intf           ;intf set?
	goto    ReceiveData     ;yes then start receive
	btfss   _rtif           ;else rtcc interrupt?
	return                  ;no then return from interrupt
	push                    ;else save status and w
	movlw   .256 - .250     ;reload rtcc
	movwf   _rtcc
	bcf     _rtif           ;clear interrupt flag
	bsf     _1mSOver        ;set flag for 1mSec
	decfsz  _20mStmr        ;dec 20 mS timer
	goto    InterruptEnd    ;not 0 then end
	bsf     _20mSOver       ;set flag for 20 mSec
	movlw   .20
	movwf   _20mStmr
	decfsz  _100mStmr       ;dec 100 mS timer
	goto    InterruptEnd    ;not 0 then end
	bsf     _100mSOver      ;set flag for 100 mSec
	movlw   .5
	movwf   _100mStmr
	decfsz  _500mStmr       ;dec 500 mS timer
	goto    InterruptEnd    ;not 0 then end
	bsf     _500mSOver      ;set flag for 500 mSec
	movlw   .5
	movwf   _500mStmr       ;reload timer
InterruptEnd
	pop                     ;restore status and w
	retfie
;
;        
ServiceKP
	bcf     _20mSOver
	call    GetKey
;service routine for key scan
	return
;        
;
ServiceDisplay
	bcf     _100mSOver     
	call    CheckPeriod
	call    GetAd                   ;do ad conversion
	btfsc   _FlashHot               ;show hot?
	goto    FlashHot                ;yes then do
	btfsc   _FlashSer               ;show ser error?
	goto    FlashSer                ;yes then show
	btfsc   _Flash0                 ;flash 0
	goto    Flash0
	movf    DutyCycleBuffer,w       ;load dutycycle
	btfsc   _dcled
	goto    LoadDC
	movf    FinalTemp,w             ;load final temp
	btfsc   _ftled                  ;ftled on?
	goto    LoadFT
	movf    PresentTemp,w           ;else load present temp
	movwf   DisplayRegister
	call    Bin8toBcd3
	call    ShiftLeft4
	movlw   .5
	btfsc   _pthalfvalue
	iorwf   accd
	goto    DisplayContinue
LoadDC
	movwf   DisplayRegister
	call    Bin8toBcd3
DisplayContinue
	call    Display
	call    CheckDebounce
	return
LoadFT
	movwf   DisplayRegister
	call    Bin8toBcd3
	call    ShiftLeft4
	movlw   .5
	btfsc   _fthalfvalue
	iorwf   accd
	goto    DisplayContinue
;
ShiftLeft4
	movlw   .4
	movwf   temp
ShiftAcccAccd
	bcf     _c
	rlf     accd
	rlf     accc
	decfsz  temp
	goto    ShiftAcccAccd
	return
;
;
ServiceHalfSec  
	bcf     _500mSOver
	btfss   _blankdisplay
	goto    blank
	bcf     _blankdisplay
	goto    HalfSecContinue
blank
	bsf     _blankdisplay
HalfSecContinue
	btfsc   _pdmode                 ;PD mode?
	call    ToggleFCLed             ;toggle fuzzy control led
	btfsc   _manled                 ;manual mode?
	return                          ;yes then return
	btfss   _starton                ;start on?
	return                          ;no then exit
;********************************************************************
	bcf     _c              ;clr carry
	rlf     PresentTemp,w   ;get present temp
	movwf   accc            ;save in gp ram
	btfsc   _pthalfvalue    ;half value set?
	bsf     accc,0          ;yes then set lsb
	bcf     _c              ;do same for final temp
	rlf     LastTemp,w     ;       /
	movwf   acca            ;save in gp ram
	btfsc   _lthalfvalue    ;half value set?
	bsf     acca,0          ;yes then set lsb
	movf    acca,w          ;get Last value in w
	subwf   accc,w          ;Present - Last
	btfss   _c              ;+ve result
	call    Get2sCompl      ;-ve then do 2's compl
	movwf   DiffTemp        ;save in ram
	movf    PresentTemp,w
	movwf   LastTemp
	bcf     _lthalfvalue
	btfsc   _pthalfvalue
	bsf     _lthalfvalue
;*******************************************************************        
	btfss   _recvdone               ;recv done?
	goto    SerialTO                ;no then serial time out
SendSerial
	call    Freeze
	call    TransmitData            ;send data to fuzzyTech
	call    UnFreeze
	bcf     _recvdone               ;clr recv done flag
	return
;
ToggleFCLed
	btfss   _fuzled
	goto    FuzLedOn
	bcf     _fuzled
	return
FuzLedOn
	bsf     _fuzled
	return
;
Freeze        
	bcf     _rtie                   ;stop rtcc interrupts
	bsf     _pwmon                  ;set pwm on flag
	btfss   _pwm                    ;if pwm on then skip
	bcf     _pwmon                  ;else clear flag
	bcf     _pwm                    ;stop pwm
	return
;
UnFreeze
	movlw   B'10110000'             ;enable int and rtcc
UnFreezeRecv
	movwf   _intcon                 ;interrupts
	movlw   B'10000001'             ;init rtcc timer
	option                          ;       /
	movlw   .256 - .250             ;for 1mS
	movwf   _rtcc
	btfsc   _pwmon                  ;if pwm on then skip
	bsf     _pwm                    ;else set pwm on
	return
;
SerialTO
	incf    serialto                ;inc # of errors
	movf    serialto,w              ;get in w
	sublw   TimeOutNumber           ;TimeOutNumber - w
	btfss   _c                      ;nc then skip
	goto    SerialError             ;signal an error
	return
;
SerialError
	bsf     _FlashSer
	bcf     _inte                   ;disable int interrupt
	goto    SendSerial
;
;
CheckDebounce
	btfss   _debounce               ;no debounce then return
	return
	btfss   _dbover                 ;dbover?
	goto    setdbover               ;no then set flag
	bcf     _dbover                 ;yes then clr all flags
	bcf     _debounce               ;       /
	return
setdbover
	bsf     _dbover
	return
;
;
;The PWM is fixed for a period of 100mS or 10 Hz. The DC on the
;other hand varies from 0 to 100% and is checked at every
;1 mS interrupt
CheckPeriod
	btfss   _starton                ;if staron then do
	return
	movf    DutyCycleBuffer,w
	sublw   .100                    ;Check if > 100
	movf    DutyCycleBuffer,w
	btfss   _c                      ;not then skip
	movlw   .100                    ;else load 100
	movwf   DutyCycle
	btfsc   _z                      ;check if 0
	goto    DopwmEnd
	bcf     _pwm                    ;just stop pwm
	btfss   _FlashHot               ;if hot switch off pwm
	bsf     _pwm
DopwmEnd
	movwf   DutyCycleBuffer
	return
;
;
CheckDC
	bcf     _1mSOver                ;clr flag
	btfss   _starton
	return
	decfsz  DutyCycle               ;dec DC
	return                          ;not 0 then return
	bcf     _pwm
	return
;
Flash0
	call    StartDisplay            ;start value
	btfsc   _blankdisplay           ;blank display?
	goto    BlankDisplay            ;yes then blank
	clrw                            ;show blank
	call    DisplayW                ;in MSD
	movlw   B'11111101'             ;show 0 in 2nd digit
	call    DisplayW                ;      /
	movlw   B'11111100'             ;show 0 in LSD
	call    DisplayW
	movf    AuxDsp,w                ;get led values
	andlw   B'11111100'             ;mask low 2 bits
	call    DisplayW                ;show
SendLast
	call    EndDisplay
	return
;
BlankDisplay
	clrw                            ;show 0
	call    DisplayW
	clrw    
	call    DisplayW
	clrw
	call    DisplayW
	movf    AuxDsp,w
	andlw   B'11111100'
	call    DisplayW
	goto    SendLast
;
FlashHot
	call    StartDisplay            ;start display
	btfsc   _blankdisplay           ;blank display?
	goto    BlankDisplay            ;yes then blank
	movlw   B'01101110'             ;with Hot
	call    DisplayW
	movlw   B'00111010'             ;       /
	call    DisplayW
	movlw   B'00011110'             ;       /
	call    DisplayW
	movf    AuxDsp,w
	andlw   B'11111100'
	call    DisplayW
	goto    SendLast
;
FlashSer
	call    StartDisplay            ;start display
	btfsc   _blankdisplay           ;blank display?
	goto    BlankDisplay            ;yes then blank
	movlw   B'10110110'             ;load Ser.
	call    DisplayW
	movlw   B'10011110'             ;       /
	call    DisplayW
	movlw   B'00001010'             ;       /
	call    DisplayW
	movf    AuxDsp,w
	andlw   B'11111100'
	call    DisplayW
	goto    SendLast



;
;
	include "ad.asm"
	include "ser71.asm"
	include "sertc.asm"
;
;
	end
;

