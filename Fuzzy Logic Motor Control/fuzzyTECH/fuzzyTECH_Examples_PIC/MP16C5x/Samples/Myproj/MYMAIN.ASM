    PROCESSOR 16C54

;------------------------------------------------------------------------------
;- USER MAIN FILE                                                             -
;------------------------------------------------------------------------------

    CODE_START      EQU     0x080   ;code  startadr for 16C5x
    RESET_VECTOR    EQU     0x1FF   ;reset vector

    FUZZY_RAM_START EQU     0x008   ;first free RAM location for 16C5x


        include "myproj.var"        ;include preassembler variables

        CBLOCK                      ;starts after fuzzy ram locations
          user1                     ;reserve 1 byte (example)
	    ENDC

        ORG     CODE_START          ;example start adress for code
mymain

        call    initmyproj          ;call init once

main_loop
        movlw   0x000               ;example
        movwf   lv0_Input_1         ;set 1st crisp input

        movlw   0x0A0               ;example
        movwf   lv1_Input_2         ;set 2nd crisp input

        include "myproj.asm"        ;include preassembler code

	    movf    invalidflags,W
        btfss   _Z                  ;test if the project is completely defined
	    goto    case_no_fire

case_fire
	    ;proj OK
        movf    lv2_Output,W        ;fetch crisp output

	  ; user code

	    goto    main_loop

case_no_fire
	    ;no rule for this input combination

	  ; call default_handling_routine

	  ; user code

	    goto    main_loop

;------------------------------------------------------------------------------
;- RESET VECTOR                                                               -
;------------------------------------------------------------------------------

        ORG     RESET_VECTOR

        goto    mymain              ;jump to program code

        END                         ;end for assembler
