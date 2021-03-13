        LIST
; DIV16_8.ASM   16 by 8 Bit Division Routine    v4.1 Inform Software Corporation
        NOLIST
;*-----------------------------------------------------------------------------*
;*------------------------- fuzzyTECH MCU-MP V4.1 -----------------------------*
;* (c) 1995 Inform Software Corporation, 2001 Midwest Road, Oak Brook, IL60521 *
;*------------ (c) 1995 Inform GmbH, Pascalstr. 23, 52076 Aachen --------------*
;*-----------------------------------------------------------------------------*
;*------------------------ division routine 16 / 8 bit ------------------------*
;*-----------------------------------------------------------------------------*


;**************************************************************************
;*                                                                        *
;*    Input:  16 bit unsigned fixed point dividend  in FAARG+0, FAARG+1   *
;*             8 bit unsigned fixed point divisor   in FBARG+0            *
;*                                                                        *
;*    Output: 16 bit unsigned fixed point quotient  in FAARG+0, FAARG+1   *
;*             8 bit unsigned fixed point remainder in FREM +0            *
;*                                                                        *
;*    Result: FAARG, FREM  <--  FAARG / FBARG                             *
;*                                                                        *
;**************************************************************************


div16_8
    if      FAMILY < 2
    clrf            FREM
    clrf            FTcount
	bsf             FTcount,4

divLoop
	rlf             FAARG+1,F
	rlf             FAARG+0,F
	rlf             FREM,F
	movf            FBARG+1,W
	btfss           _C
	goto            no_carry
	subwf           FREM,F
	bsf             _C
	goto            no_sub
 no_carry
	subwf           FREM,W
	btfsc           _C
	movwf           FREM
 no_sub
	decfsz          FTcount,F
	goto            divLoop
	rlf             FAARG+1,F
	rlf             FAARG+0,F
    else
    clrf            FREM,F
    clrf            FTcount,F
	bsf             FTcount,4

divLoop
	rlcf            FAARG+1,F
	rlcf            FAARG+0,F
    rlcf            FREM,F
    movfp           FBARG+1,WREG
	btfss           _C
	goto            no_carry
    subwf           FREM,F
	bsf             _C
	goto            no_sub
 no_carry
	subwf           FREM,W
	btfsc           _C
	movwf           FREM
 no_sub
	decfsz          FTcount,F
	goto            divLoop
	rlcf            FAARG+1,F
	rlcf            FAARG+0,F
    endif

    if      FAMILY > 0
	return
    endif

; The end of module div16_8

        LIST

