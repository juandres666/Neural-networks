        LIST
; MPY16_16.ASM   16 * 16 Bit Multiplication     v4.1 Inform Software Corporation
        NOLIST
;*-----------------------------------------------------------------------------*
;*------------------------- fuzzyTECH MCU-MP V4.1 -----------------------------*
;* (c) 1995 Inform Software Corporation, 2001 Midwest Road, Oak Brook, IL60521 *
;*------------ (c) 1995 Inform GmbH, Pascalstr. 23, 52076 Aachen --------------*
;*-----------------------------------------------------------------------------*
;*--------------------- multiplication routine 16 x 16 bit --------------------*
;*-----------------------------------------------------------------------------*


;****************************************************************************
;*                                                                          *
;* Input:  16 bit unsigned fixed point multiplicand in mulcnd+0,  mulcnd+1  *
;*         16 bit unsigned fixed point multiplier   in mulplr+0,  mulplr+1  *
;*                                                                          *
;* Output: 32 bit unsigned fixed point result       in res_mpy+0, res_mpy+1 *
;*                                                     res_mpy+2, res_mpy+3 *
;*                                                                          *
;* Result:  res_mpy  <--  mulcnd * mulplr                                   *
;*                                                                          *
;****************************************************************************

mpy16_16
    if      FAMILY == 1
        clrf    FTcount
        bsf     FTcount,4
        clrf    res_mpy+0
        clrf    res_mpy+1
mpyLoop
        rrf     mulplr+0,F
        rrf     mulplr+1,F
        btfss   _C
        goto    NoAdd
        movf    mulcnd+1,W
        addwf   res_mpy+1,F
        btfsc   _C
        incf    res_mpy+0,F
        movf    mulcnd+0,W
        addwf   res_mpy+0,F
NoAdd
        rrf     res_mpy+0,F
        rrf     res_mpy+1,F
        rrf     res_mpy+2,F
        rrf     res_mpy+3,F
        decfsz  FTcount,F
        goto    mpyLoop
    endif
    if      FAMILY == 2

     if    HW_MULTIPLIER == 0
        clrf    FTcount,F
        bsf     FTcount,4
        clrf    res_mpy+0,F
        clrf    res_mpy+1,F
mpyLoop
        rrcf    mulplr+0,F
        rrcf    mulplr+1,F
        btfss   _C
        goto    NoAdd
        movfp   mulcnd+1,WREG
        addwf   res_mpy+1,F
        movfp   mulcnd+0,WREG
        addwfc  res_mpy+0,F
NoAdd
        rrcf    res_mpy+0,F
        rrcf    res_mpy+1,F
        rrcf    res_mpy+2,F
        rrcf    res_mpy+3,F
        decfsz  FTcount,F
        goto    mpyLoop
     else
        movfp   mulplr+1,WREG
        mulwf   mulcnd+1
        movpf   PRODH,res_mpy+2
        movpf   PRODL,res_mpy+3
        movfp   mulplr+0,WREG
        mulwf   mulcnd+0
        movpf   PRODH,res_mpy+0
        movpf   PRODL,res_mpy+1
        movfp   mulplr+1,WREG
        mulwf   mulcnd+0
        movfp   PRODL,WREG
        addwf   res_mpy+2,F
        movfp   PRODH,WREG
        addwfc  res_mpy+1,F
        clrf    WREG,F
        addwfc  res_mpy+0,F
        movfp   mulplr+0,WREG
        mulwf   mulcnd+1
        movfp   PRODL,WREG
        addwf   res_mpy+2,F
        movfp   PRODH,WREG
        addwfc  res_mpy+1,F
        clrf    WREG,F
        addwfc  res_mpy+0,F
     endif
    endif
        return

; The end of module mpy16_16

        LIST

