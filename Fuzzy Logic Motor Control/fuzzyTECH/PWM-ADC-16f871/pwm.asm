		list		p=16F871
		#include	<p16f871.inc>
		__config 	0x3d3A
		errorlevel	-302
		
		bsf 	STATUS,RP0
		MOVLW	b'00000100'			;----,1canalRA0 Vref=VddVss
		MOVWF 	ADCON1
		clrf	TRISB
		bcf		TRISC,2		;PWMout
		MOVLW	0xFF		;PWM Period=255
		MOVWF	PR2
		bcf 	STATUS,RP0

    	MOVLW	b'00000111'	;'-,PstSkl:1---:1,TMR2on,PreSk16-.'
		MOVWF	T2CON

		MOVLW	b'00001100'	;'0000,PWMMODE---.'
		MOVWF	CCP1CON

START	MOVLW	b'10000101'			;Fosc/16-,RA0--,Conv,-,ActivadoCAD
		MOVWF 	ADCON0
STOP1 	btfsc	ADCON0,2 			;ver si acaba de convertir
		goto 	STOP1
		movf 	ADRESL,W
        movwf	CCPR1L
		movwf	PORTB
		goto 	START
	END