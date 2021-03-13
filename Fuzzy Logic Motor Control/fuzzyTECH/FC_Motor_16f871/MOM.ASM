;*-----------------------------------------------------------------------------*
;*------------------------- fuzzyTECH MCU-MP V4.1 -----------------------------*
;* (c) 1995 Inform Software Corporation, 2001 Midwest Road, Oak Brook, IL60521 *
;*------------ (c) 1995 Inform GmbH, Pascalstr. 23, 52076 Aachen --------------*
;*-----------------------------------------------------------------------------*
;*---------- defuzzification routine mean of maximum for PIC17Cxx -------------*
;*-----------------------------------------------------------------------------*


xmom_routine
        ADD_TBL16   xcom, WREG
        tablrd      0, 0, WREG
        return

mom
    if	    RESOLUTION == 8
        clrf        maxout,F
    else
        clrf        maxout+0,F
        clrf        maxout+1,F
    endif
        setf        maxoutpos,F
start_mom
    if	    RESOLUTION == 8
        SET_PAGE
        movpf       INDF0,WREG
        decf        FSR0,F
        clrf        INDF0,F
        INC_FSR
        RES_PAGE
        movwf       tmp_var
        subwf       maxout,W
        btfsc       _C
    else
        SET_PAGE
     if BANKED == 0
        FMOV0F16    Temp16
     else
        FMOV0F16    BASEREG
     endif
        decf        FSR0,F
        decf        FSR0,F
        FCLR0F16
        INC_FSR
        RES_PAGE
     if BANKED == 1
        FMOV16      BASEREG,Temp16
     endif
        FCPFSGT16   Temp16,maxout
    endif
        goto        smaller_mom
    if	    RESOLUTION == 8
        movfp       tmp_var,WREG
        movwf       maxout
    else
        FMOV16      Temp16,maxout
    endif
        movfp       otoffset,WREG
        movwf       maxoutpos
        call        xmom_routine
    if	    RESOLUTION == 8
        tlrd        0,res_div
    else
        tlrd        0,res_div+1
        tlrd        1,res_div+0
    endif
smaller_mom
        incf        otoffset,F
        decfsz      otcnt,F
        goto        start_mom
        comf        maxoutpos,F
        tstfsz      maxoutpos
        goto        fire_mom
        bsf     _C
        return
fire_mom
        bcf     _C
    if	    RESOLUTION == 8
        movfp       res_div,WREG
    else
        FMOV16      res_div,Temp16
    endif
        return

; The end of module mom

