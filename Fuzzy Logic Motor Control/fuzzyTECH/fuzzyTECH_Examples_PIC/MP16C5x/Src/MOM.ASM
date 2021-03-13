;*-----------------------------------------------------------------------------*
;*------------------------- fuzzyTECH MCU-MP V4.1 -----------------------------*
;* (c) 1995 Inform Software Corporation, 2001 Midwest Road, Oak Brook, IL60521 *
;*------------ (c) 1995 Inform GmbH, Pascalstr. 23, 52076 Aachen --------------*
;*-----------------------------------------------------------------------------*
;*------------ defuzzification routine mean of maximum for PIC16 --------------*
;*-----------------------------------------------------------------------------*

GET_XMOM    MACRO   target
    if	    RESOLUTION == 8
        movwf       offset
        call        mom_routine
        movwf       target
    else
        movwf       offset
        bcf         _C
        rlf         offset,F
        call        mom_routine
        movwf       target+0
        incf        offset,F
        call        mom_routine
        movwf       target+1
    endif
	    ENDM

    if	    FAMILY == 1
mom_routine
        LD8TBL      xcom,offset
    endif

mom
    if	    RESOLUTION == 8
        clrf        maxout
    else
        FCLR16      maxout
    endif
        movlw       0x0FF
        movwf       maxoutpos
start_mom
    if	FAMILY == 0
        decf        otcnt,F
        SET_PAGE
        movf        0,W
        clrf        0
        DEC_FSR
        RES_PAGE
        movwf       tmp_var
        andlw       0x0FF
        btfsc       _Z
        goto        smaller_mom
        movf        maxout,W
        subwf       tmp_var,W
        btfss       _C
        goto        smaller_mom
    else
     if RESOLUTION == 8
        SET_PAGE
        movf        0,W
        clrf        0
        INC_FSR
        RES_PAGE
        movwf       tmp_var
        subwf       maxout,W
        btfsc       _C
        goto        smaller_mom
     else
        SET_PAGE
        FMOV0F16    Temp16
        FCLR0F16
        INC_FSR
        RES_PAGE
        FCPFSGT16   Temp16,maxout
        goto        smaller_mom
     endif
    endif
    if	    RESOLUTION == 8
        movf        tmp_var,W
        movwf       maxout
    else
        FMOV16      Temp16,maxout
    endif
    if	    FAMILY == 0
        movf        otcnt,W
        movwf       maxoutpos
        call        xcom
        movwf       res_div
    else
        movf        otoffset,W
        movwf       maxoutpos
        GET_XMOM    res_div
    endif
smaller_mom
    if	    FAMILY == 0
        movf        otcnt,W
        btfss       _Z
    else
        incf        otoffset,F
        decfsz      otcnt,F
    endif
        goto        start_mom
        comf        maxoutpos,F
        btfss       _Z
        goto        fire_mom
        bsf         _C
    if	    FAMILY == 0
        goto        end_mom
    else
        return
    endif
fire_mom
        bcf         _C
    if RESOLUTION == 8
        movf        res_div,W
    else
        FMOV16      res_div,Temp16
    endif
    if	    FAMILY == 0
end_mom
    else
        return
    endif

; The end of module mom

