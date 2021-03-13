;*-----------------------------------------------------------------------------*
;*------------------------- fuzzyTECH MCU-MP V4.1 -----------------------------*
;* (c) 1995 Inform Software Corporation, 2001 Midwest Road, Oak Brook, IL60521 *
;*------------ (c) 1995 Inform GmbH, Pascalstr. 23, 52076 Aachen --------------*
;*-----------------------------------------------------------------------------*
;*--- fuzzification routine fast linear membership with slope for PIC17Cxx ----*
;*-----------------------------------------------------------------------------*

tpts_routine
    if	    RESOLUTION == 8
    bcf         _C
    rrcf        WREG,F
    ADD_TBL16   tpts,WREG
    tablrd      0,0,WREG
	return
    else
    ADD_TBL16   tpts,WREG
    tablrd      0,0,WREG
	return
    endif

flmss
    FSET_AUTO_INC
flmss_start
    movfp       itptr,WREG
	call	    tpts_routine
    if	    RESOLUTION == 8
	tlrd	    1,cur_term
    movfp       cur_term,WREG
    subwf       crisp,W
	btfss	    _C
	goto	    mindone
	btfss	    _Z
	goto	    cmp_flmss
    else
	tlrd	    1,cur_term+0
	tlrd	    0,cur_term+1
	FSUB16F     cur_term,crisp,Temp16
	btfss	    _C
	goto	    mindone
	FTSTFSZ16   Temp16
	goto	    cmp_flmss
    endif
	incf	    itptr,W
	call	    tpts_routine
    if	    RESOLUTION == 8
    tlrd        0,WREG
    tstfsz      WREG
    else
	tlrd	    1,Temp16+0
	tlrd	    0,Temp16+1
	FTSTFSZ16   Temp16
    endif
	goto	    mindone
	goto	    maxdone
cmp_flmss
	movlw	    2
	addwf	    itptr,W
	call	    tpts_routine
    if	    RESOLUTION == 8
	tlrd	    1,cur_term2
    movfp       crisp,WREG
	subwf	    cur_term2,W
	btfss	    _C
    else
	tlrd	    1,cur_term2+0
	tlrd	    0,cur_term2+1
	FCPFSLE16   crisp,cur_term2
    endif
	goto	    ds
as
    incf        itptr,W
	call	    tpts_routine
    if	    RESOLUTION == 8
    tlrd        0,WREG
    andlw       0x0FF
    else
	tlrd	    1,Temp16+0
	tlrd	    0,Temp16+1
    movfp       Temp16+0,WREG
	iorwf	    Temp16+1,W
    endif
	btfsc	    _Z
	goto	    maxdone
    if	    RESOLUTION == 8
    movwf       mulplr
    movfp       cur_term,WREG
    subwf       crisp,W
     if     HW_MULTIPLIER == 0
    movwf       mulcnd
    call        mpy8_8
     else
	mulwf	    mulplr
    movpf       PRODL,res_mpy+1
    movpf       PRODH,res_mpy+0
     endif
	bcf	    _C
    rrcf        res_mpy+0,W
    tstfsz      WREG
    goto        maxdone
	rrcf	    res_mpy+1,W
    else
	FMOV16	    Temp16,mulplr
	FSUB16F     cur_term,crisp,mulcnd
	call	    mpy16_16
	bcf	    _C
	rrcf	    res_mpy+0,W
	movwf	    Temp16+0
	rrcf	    res_mpy+1,W
	movwf	    Temp16+1
	FTSTFSZ16   Temp16
	goto	    maxdone
    rrcf        res_mpy+2,F
    rrcf        res_mpy+3,F
	FMOV16	    res_mpy+2,Temp16
    endif
	goto	    store
ds
    movlw       3
	addwf	    itptr,W
	call	    tpts_routine
    if	    RESOLUTION == 8
    tlrd        0,WREG
	andlw	    0x0FF
    else
	tlrd	    1,Temp16+0
	tlrd	    0,Temp16+1
    movfp       Temp16+1,WREG
	iorwf	    Temp16+0,W
    endif
    btfsc       _Z
    goto        mindone
    if	    RESOLUTION == 8
    movwf       mulplr
    movfp       cur_term2,WREG
    subwf       crisp,W
     if     HW_MULTIPLIER == 0
    movwf       mulcnd
    call        mpy8_8
     else
	mulwf	    mulplr
    movpf       PRODL,res_mpy+1
    movpf       PRODH,res_mpy+0
     endif
	bcf	    _C
    rrcf        res_mpy+0,W
    tstfsz      WREG
    goto        mindone
    rrcf        res_mpy+1,F
	comf	    res_mpy+1,W
    else
	FMOV16	    Temp16,mulplr
	FSUB16F     cur_term2,crisp,mulcnd
	call	    mpy16_16
	bcf	    _C
	rrcf	    res_mpy+0,W
	movwf	    Temp16+0
	rrcf	    res_mpy+1,W
	movwf	    Temp16+1
	FTSTFSZ16   Temp16
	goto	    mindone
    rrcf        res_mpy+2,F
    rrcf        res_mpy+3,F
	FCOMF16     res_mpy+2
	FMOV16	    res_mpy+2,Temp16
    endif
	goto	    store
maxdone
    if	    RESOLUTION == 8
        setf        WREG,F
    else
        setf        Temp16+0,F
        setf        Temp16+1,F
    endif
	goto	    store
mindone
    if	    RESOLUTION == 8
        clrf        WREG,F
    else
        clrf        Temp16+0,F
        clrf        Temp16+1,F
    endif
store
    if	    RESOLUTION == 8
	SET_PAGE
        movwf       INDF0
        INC_FSR
	RES_PAGE
    else
     if BANKED == 1
        FMOV16      Temp16,BASEREG
     endif
        SET_PAGE
     if BANKED == 0
    FMOV16F0    Temp16
     else
        FMOV16F0    BASEREG
     endif
        INC_FSR
	RES_PAGE
    endif
store_ff
	movlw	    4
    addwf       itptr,F
    decfsz      itcnt,F
	goto	    flmss_start
    return

; The end of module flmss

