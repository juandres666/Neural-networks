		NOLIST

;************************************************************************************************
;                               PIC16Cxx Header File
;
;       Special Function Register Definitions
;
;
;        By     :       Amar Palacherla
;        Date   :       01 Mar 1993
;
;************************************************************************************************/

	CBLOCK 0x00
		_indf, _rtcc, _pcl, _status, _fsr
		_porta, _portb, _portc
	ENDC

_option set     0x01

_trisa  set     0x05
_trisb  set     0x06
_trisc  set     0x07

_pclath set     0x0a
_intcon set     0x0b


; Porta Bits
#define         _ra0            _porta,0
#define         _ra1            _porta,1
#define         _ra2            _porta,2
#define         _ra3            _porta,3
#define         _ra4            _porta,4

#define         _rt             _porta,4

#define         _ain0           _porta,0
#define         _ain1           _porta,1
#define         _ain2           _porta,2
#define         _ain3           _porta,3

#define         _vref           _porta,3

; Portb bits
#define         _rb0            _portb,0
#define         _rb1            _portb,1
#define         _rb2            _portb,2
#define         _rb3            _portb,3
#define         _rb4            _portb,4
#define         _rb5            _portb,5
#define         _rb6            _portb,6
#define         _rb7            _portb,7

#define         _int            _portb,0

; PortC bits
#define         _rc0            _portc,0
#define         _rc1            _portc,1
#define         _rc2            _portc,2
#define         _rc3            _portc,3
#define         _rc4            _portc,4
#define         _rc5            _portc,5
#define         _rc6            _portc,6
#define         _rc7            _portc,7

; STATUS Reg Bits
#define         _carry          _status,0
#define         _c              _status,0
#define         _dc             _status,1
#define         _z              _status,2
#define         _pd             _status,3
#define         _to             _status,4
#define         _rp0            _status,5
#define         _rp1            _status,6
#define         _irp            _status,7

; INTCON Reg Bits
#define         _rbif   _intcon,0
#define         _intf   _intcon,1
#define         _rtif   _intcon,2
#define         _rbie   _intcon,3
#define         _inte   _intcon,4
#define         _rtie   _intcon,5

#define         _adie   _intcon,6               ; 16C71
#define         _eeie   _intcon,6               ; 16C84

#define         _gie    _intcon,7


; OPTION Reg

#define         _ps0    _option,0
#define         _ps1    _option,1
#define         _ps2    _option,2
#define         _psa    _option,3
#define         _rte    _option,4
#define         _rts    _option,5
#define         _intedg _option,6
#define         _rbpu   _option,7

;**********************************************************************************************
;                                PIC16C71 Releted Constants
;**********************************************************************************************/

_adcon0 set     0x08            ; bank 0
_adcon1 set     0x08            ; bank 1
_adres  set     0x09

; ADCON0 Bits
#define         _adon   _adcon0,0
#define         _adif   _adcon0,1

#define         _go     _adcon0,2
#define         _done   _adcon0,2

#define         _chs0   _adcon0,3
#define         _chs1   _adcon0,4

#define         _adcs0  _adcon0,6
#define         _adcs1  _adcon0,7

; ADCON1 Bits
#define         _pcfg0  _adcon1,0
#define         _pcfg1  _adcon1,1

;**********************************************************************************************
;                                PIC16C84 Releted Constants
;**********************************************************************************************/

_eedata set     0x08
_eeadr  set     0x09

_eecon1 set     0x08
_eecon2 set     0x09            ; bank 1


#define         _rd     _eecon1,0
#define         _wr     _eecon1,1
#define         _wren   _eecon1,2
#define         _wrerr  _eecon1,3
#define         _eeif   _eecon1,4

;*********************************************************************************************
;                               PIC16C64 Related Constants
; Status : Incomplete
;*********************************************************************************************

	CBLOCK  0x08
		_portd, _porte                          
		_pclath, _intcon
		_pir1, _pir2
		_tmr1l, _tmr1h, _t1con
		_tmr2, _t2con
		_sspbug, _sspcon
		_ccpr1l, _ccpr1h, _ccp1con
		_rcsta, _txreg, _rcreg
		_ccpr2l, _ccpr2h, _ccp2con
	ENDC

;*********************************************************************************************
_ResetVector    set     0x00
_IntVector      set     0x04
;

;W       equ     0
;w       equ     0

TRUE    equ     1
FALSE   equ     0

LSB     equ     0
MSB     equ     7

;

	LIST



