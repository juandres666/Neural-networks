    	PROCESSOR 16C73B

		list		p=16C73B
		#include	<p16c73b.inc>
		__config 	0x3fb9
		errorlevel	-302
;------------------------------------------------------------------------------
;- USER MAIN FILE                                                             -
;------------------------------------------------------------------------------

    CODE_START      EQU     0x100   ;code startadr for 16Cxx
    RESET_ADR	    EQU     0x000   ;reset vector

    FUZZY_RAM_START EQU     0x020   ;first free RAM location for 16Cxx


        include "myproj.var"        ;include preassembler variables

        CBLOCK                      ;starts after fuzzy ram locations
          user1                     ;reserve 1 byte (example)
	    ENDC

        ORG CODE_START              ;example start adress for code

mymain
		bsf 	STATUS,RP0
		MOVLW	b'00000100'			;----,1canalRA0 Vref=VddVss
		MOVWF 	ADCON1
		clrf	TRISB
		bcf 	STATUS,RP0

		call    initmyproj          ;call init once

main_loop
		MOVLW	b'01000101'			;Fosc/8-,RA0--,Conv,-,ActivadoCAD
		MOVWF 	ADCON0
STOP 	btfsc	ADCON0,2 			;ver si acaba de convertir
		goto 	STOP
		movf 	ADRES,W

        ;movlw   0x000               ;example
        movwf   lv0_Input_1         ;set 1st crisp input

		MOVLW	b'01001101'			;Fosc/8-,RA1--,Conv,-,ActivadoCAD
		MOVWF 	ADCON0
STOP1 	btfsc	ADCON0,2 			;ver si acaba de convertir
		goto 	STOP1
		movf 	ADRES,W

        ;movlw   0x0A0               ;example
        movwf   lv1_Input_2         ;set 2nd crisp input

        call    myproj              ;call preassembler code

	    movf    invalidflags,W
        btfss   _Z                  ;test if the project is completely defined
	    goto    case_no_fire

case_fire
	    ;proj OK
        movf    lv2_Output,W        ;fetch crisp output
		movwf	PORTB
	    ;user code

	    goto    main_loop

case_no_fire
	    ;no rule defined for this input combination

	  ; call default_handling_routine

	    ;user code

	    goto    main_loop


        INCLUDE "myproj.asm"        ;include preassembler code

;------------------------------------------------------------------------------
;- RESET VECTOR                                                               -
;------------------------------------------------------------------------------

	    ORG     RESET_ADR

        goto    mymain              ;jump to program code

        END                         ;end for assembler
