;This file contains all the equates related to the temprature
;control porgram
;
ResetVector     equ     0
InterruptVector equ     4
TimeOutNumber   equ     6
FUZZY_RAM_START equ     0x0C
;
;
;
; All ram location equates are here
acca            equ     0x1e
accc            equ     0x1f
accd            equ     0x20
temp            equ     0x21
KeyValue        equ     0x22
_keyflags       set     0x23
ErrorFlags      set     0x24
AuxDsp          set     0x25
FinalTemp       equ     0x26
PresentTemp     equ     0x27
_500mStmr       equ     0x28
_20mStmr        equ     0x29
_100mStmr       equ     0x2a
_tmrflag        set     0x2b
DisplayRegister equ     0x2c
DutyCycle       equ     0x2d
StatBuffer      equ     0x2e
WBuffer         equ     0x2f
; 
;All define statements are here
;
;Below are the flags for the KeyPad fucntions
#define _keyhit         _keyflags,0
#define _debounce       _keyflags,1
#define _starton        _keyflags,2
#define _dbover         _keyflags,3     ;debounce over flag
#define _cpover         _keyflags,4
#define _2ndrow         _keyflags,5
#define _pdmode         _keyflags,6
#define _lthalfvalue    _keyflags,7
;
;Below are the flags for the timer section
#define _1mSOver        _tmrflag,0
#define _20mSOver       _tmrflag,1
#define _100mSOver      _tmrflag,2
#define _500mSOver      _tmrflag,3
#define _pwmon          _tmrflag,4
#define _belowlimit     _tmrflag,5
#define _abovelimit     _tmrflag,6
;
;Below are the defines for the LED display section
#define _ledEn          _portb,3
; _ledEn is active low so it has to be set to disable writes
; to the LED display.
#define _ledData        _portb,1
#define _ledClk         _portb,2
;
;
#define _rx             _portb,0
#define _tx             _portb,7
;
;
;Below are the defines for the Keypad
#define _col1           _portb,4
#define _col2           _portb,5
#define _row1           _portb,1
#define _row2           _portb,2
#define _enable9V       _portb,6
;
#define _pwm            _porta,3
;
;Below are the defines for the Auxlilary Display 
#define _ftled          AuxDsp,7
#define _ptled          AuxDsp,6
#define _dcled          AuxDsp,5
#define _fuzled         AuxDsp,4
#define _manled         AuxDsp,3
#define _nopled         AuxDsp,2
#define _fthalfvalue    AuxDsp,1
#define _pthalfvalue    AuxDsp,0
;
;Keypad values:
#define _StopKey        KeyValue,0
#define _LeftKey        KeyValue,1
#define _StartKey       KeyValue,2
#define _RightKey       KeyValue,3
;
#define _blankdisplay   ErrorFlags,0
#define _Flash0         ErrorFlags,1
#define _FlashHot       ErrorFlags,2
#define _FlashSer       ErrorFlags,3
#define _recvdone       ErrorFlags,4
#define _recvabort      ErrorFlags,5



