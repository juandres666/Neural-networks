        LIST
; MPY8_8.ASM    8 * 8 Bit Multiplication        v4.1 Inform Software Corporation
        NOLIST
;*-----------------------------------------------------------------------------*
;*------------------------- fuzzyTECH MCU-MP V4.1 -----------------------------*
;* (c) 1995 Inform Software Corporation, 2001 Midwest Road, Oak Brook, IL60521 *
;*------------ (c) 1995 Inform GmbH, Pascalstr. 23, 52076 Aachen --------------*
;*-----------------------------------------------------------------------------*
;*----------------------- multiplication routine 8 x 8 bit --------------------*
;*-----------------------------------------------------------------------------*


;****************************************************************************
;*                                                                          *
;* Input:   8 bit unsigned fixed point multiplicand in mulcnd               *
;*          8 bit unsigned fixed point multiplier   in mulplr               *
;*                                                                          *
;* Output: 16 bit unsigned fixed point result       in res_mpy+0, res_mpy+1 *
;*                                                                          *
;* Result:  res_mpy  <--  mulcnd * mulplr                                   *
;*                                                                          *
;****************************************************************************


    if      FAMILY < 1
mpy8_8_
    else
mpy8_8
    endif

    if      FAMILY < 2
        clrf    FTcount
        bsf     FTcount,3
        clrf    res_mpy+0

        movf    mulcnd,W
        rrf     mulplr,F
mpyLoop
        btfsc   _C
        addwf   res_mpy+0,F
        rrf     res_mpy+0,F
        rrf     mulplr,F
        decfsz  FTcount,F
        goto    mpyLoop
        movf    mulplr,W
        movwf   res_mpy+1
    else
        clrf    FTcount,F
        bsf     FTcount,3
        clrf    res_mpy+0,F

        movfp   mulcnd,WREG
        rrcf    mulplr,F
mpyLoop
        btfsc   _C
        addwf   res_mpy+0,F
        rrcf    res_mpy+0,F
        rrcf    mulplr,F
        decfsz  FTcount,F
        goto    mpyLoop
        movfp   mulplr,WREG
        movwf   res_mpy+1
    endif

    if      FAMILY < 1
        retlw   0
    else
        return
    endif

; The end of module mpy8_8

        LIST

