    	PROCESSOR 16F871

		list		p=16F871
		#include	<p16f871.inc>
		__config 	0x3d3A
		errorlevel	-302
;------------------------------------------------------------------------------
;- USER MAIN FILE                                                             -
;------------------------------------------------------------------------------

    CODE_START      EQU     0x100   ;code startadr for 16Cxx
    RESET_ADR	    EQU     0x000   ;reset vector

    FUZZY_RAM_START EQU     0x020   ;first free RAM location for 16Cxx


        include "MOTORCON.var"        ;include preassembler variables

        CBLOCK                      ;starts after fuzzy ram locations
          user1                     ;reserve 1 byte (example)
	    ENDC

        ORG CODE_START              ;example start adress for code

mymain
		bsf 	STATUS,RP0
		MOVLW	b'00000100'			;----,1canalRA0 Vref=VddVss
		MOVWF 	ADCON1
		bcf		TRISC,2		;PWMout
		MOVLW	0xFF		;PWM Period=255
		MOVWF	PR2
		bcf 	STATUS,RP0

    	MOVLW	b'00000111'	;'-,PstSkl:1---:1,TMR2on,PreSk16-.'
		MOVWF	T2CON

		MOVLW	b'00001100'	;'0000,PWMMODE---.'
		MOVWF	CCP1CON

		call    initmotorcon           ;call init once

main_loop
		MOVLW	b'10000101'			;Fosc/32-,RA0--,Conv,-,ActivadoCAD
		MOVWF 	ADCON0
STOP 	btfsc	ADCON0,2 			;ver si acaba de convertir
		goto 	STOP
		movf 	ADRESH,W
        movwf   lv0_DatoError         ;set 1st crisp input

		MOVLW	b'10001101'			;Fosc/32-,RA1--,Conv,-,ActivadoCAD
		MOVWF 	ADCON0
STOP1 	btfsc	ADCON0,2 			;ver si acaba de convertir
		goto 	STOP1
		movf 	ADRESH,W
        movwf   lv1_DatoReferencia         ;set 2nd crisp input

        call    motorcon              ;call preassembler code

	    movf    invalidflags,W
        btfss   _Z                  ;test if the project is completely defined
	    goto    case_no_fire

case_fire	    ;proj OK
        movf    lv2_DatoMotor,W        ;fetch crisp output
		movwf	CCPR1L

	    goto    main_loop

case_no_fire
	    ;no rule defined for this input combination

	  ; call default_handling_routine

	    ;user code

	    goto    main_loop


        INCLUDE "MOTORCON.asm"        ;include preassembler code

;------------------------------------------------------------------------------
;- RESET VECTOR                                                               -
;------------------------------------------------------------------------------

	    ORG     RESET_ADR

        goto    mymain              ;jump to program code

        END                         ;end for assembler