        LIST
; DIV32_16.ASM   32 by 16 Bit Division Routine  v4.1 Inform Software Corporation
        NOLIST
;*-----------------------------------------------------------------------------*
;*------------------------- fuzzyTECH MCU-MP V4.1 -----------------------------*
;* (c) 1995 Inform Software Corporation, 2001 Midwest Road, Oak Brook, IL60521 *
;*------------ (c) 1995 Inform GmbH, Pascalstr. 23, 52076 Aachen --------------*
;*-----------------------------------------------------------------------------*
;*----------------------- division routine 32 / 16 bit ------------------------*
;*-----------------------------------------------------------------------------*


;**************************************************************************
;*                                                                        *
;*    Input:  32 bit unsigned fixed point dividend  in FAARG+0, FAARG+1   *
;*                                                     FAARG+2, FAARG+3   *
;*            16 bit unsigned fixed point divisor   in FBARG+0, FBARG+1   *
;*                                                                        *
;*    Output: 32 bit unsigned fixed point quotient  in FAARG+0, FAARG+1   *
;*                                                     FAARG+2, FAARG+3   *
;*            16 bit unsigned fixed point remainder in FREM +0, FREM +1   *
;*                                                                        *
;*    Result: FAARG, FREM  <--  FAARG / FBARG                             *
;*                                                                        *
;**************************************************************************

div32_16
    if      FAMILY < 2
        clrf            FTcount
        bsf             FTcount,5
        clrf            FREM+0
        clrf            FREM+1

        clrf            FTEMP
divLoop
        rlf             FAARG+0,W
        rlf             FREM+1,F
        rlf             FREM+0,F
        rlf             FTEMP,F
        movf            FBARG+1,W
        subwf           FREM+1,F
        movf            FBARG+0,W
        btfss           _C
        incf            FBARG+0,W
        subwf           FREM+0,F
        movlw           0x000
        btfss           _C
        addlw           1
        subwf           FTEMP,F
        btfsc           _C
        goto            nosub
        movf            FBARG+1,W
        addwf           FREM+1,F
        movf            FBARG+0,W
        btfsc           _C
        incf            FBARG+0,W
        addwf           FREM+0,F
        movlw           0x000
        btfsc           _C
        addlw           1
        addwf           FTEMP,F
        bcf             _C
nosub
        rlf             FAARG+3,F
        rlf             FAARG+2,F
        rlf             FAARG+1,F
        rlf             FAARG+0,F
        decfsz          FTcount,F
        goto            divLoop
    else
        clrf            FTcount,F
        bsf             FTcount,5
        clrf            FREM+0,F
        clrf            FREM+1,F
        clrf            FTEMP,F
divLoop
        rlcf            FAARG+0,W
        rlcf            FREM+1,F
        rlcf            FREM+0,F
        rlcf            FTEMP,F
        movfp           FBARG+1,WREG
        subwf           FREM+1,F
        movfp           FBARG+0,WREG
        subwfb          FREM+0,F
        movlw           0x000
        subwfb          FTEMP+0,F
        btfsc           _C
        goto            nosub
        movfp           FBARG+1,WREG
        addwf           FREM+1,F
        movfp           FBARG+0,WREG
        addwfc          FREM+0,F
        movlw           0x000
        addwfc          FTEMP,F
        bcf             _C
nosub
        rlcf            FAARG+3,F
        rlcf            FAARG+2,F
        rlcf            FAARG+1,F
        rlcf            FAARG+0,F
        decfsz          FTcount,F
        goto            divLoop
    endif
        return

; The end of module div32_16

        LIST

