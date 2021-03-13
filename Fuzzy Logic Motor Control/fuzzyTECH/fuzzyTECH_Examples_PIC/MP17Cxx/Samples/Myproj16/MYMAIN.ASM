    PROCESSOR 17C42

;------------------------------------------------------------------------------
;- USER MAIN FILE                                                             -
;------------------------------------------------------------------------------

    CODE_START	    EQU     0x100   ;code startadr for 17Cxx
    RESET_VECTOR    EQU     0x000   ;reset vector  for 17Cxx

    FUZZY_RAM_START EQU     0x018   ;first free RAM location for 17Cxx

        include "myproj16.var"      ;include preassembler variables

    ORDER       EQU     MSB_LSB     ;for compatibilty with the old fuzzyTECH format
  ; ORDER       EQU     LSB_MSB     ;for compatibilty with existing PIC macros


        CBLOCK                      ;starts after fuzzy ram locations
          user1                     ;reserve 1 byte (example)
	    ENDC

        ORG CODE_START              ;example start adress for code

mymain
        call    initmyproj16        ;call init once

main_loop
        movlw   0x012               ;example
        movwf   lv0_Input_1         ;set 1st crisp input (hi byte)
        movlw   0x034               ;example
        movwf   lv0_Input_1_        ;set 1st crisp input (lo byte)

        movlw   0x0AB               ;example
        movwf   lv1_Input_2         ;set 2nd crisp input (hi byte)
        movlw   0x0CD               ;example
        movwf   lv1_Input_2_        ;set 2nd crisp input (lo byte)

        call    myproj16            ;call preassembler code

        tstfsz  invalidflags        ;test if the project is completely defined
	    goto    case_no_fire

;case_fire
	    ;proj OK
        movfp   lv2_Output,WREG     ;fetch crisp output (hi byte)
	  ; user transfer of 1. result byte
        movfp   lv2_Output_,WREG    ;fetch crisp output (lo byte)
	  ; user transfer of 2. result byte

	    goto    main_loop

case_no_fire
	    ;no rule for this input combination

	  ; call    default_handling_routine

	    goto    main_loop


        INCLUDE "myproj16.asm"      ;include preassembler code

;------------------------------------------------------------------------------
;- RESET VECTOR                                                               -
;------------------------------------------------------------------------------

        ORG     RESET_VECTOR

        goto    mymain              ;jump to program code

        END                         ;end for assembler
