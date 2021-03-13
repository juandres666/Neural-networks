;*-----------------------------------------------------------------------------*
;*------------------------- fuzzyTECH MCU-MP V4.1 -----------------------------*
;* (c) 1995 Inform Software Corporation, 2001 Midwest Road, Oak Brook, IL60521 *
;*------------ (c) 1995 Inform GmbH, Pascalstr. 23, 52076 Aachen --------------*
;*-----------------------------------------------------------------------------*
;*----- fuzzification routine fast linear membership with slope for PIC16 -----*
;*-----------------------------------------------------------------------------*

    if	    RESOLUTION == 8
GET_TERM    MACRO
	movwf	    offset
	call	    tpts_routine
	    ENDM
    else
GET_TERM    MACRO   target
	movwf	    offset
	bcf	    _C
	rlf	    offset,F
	call	    tpts_routine
	movwf	    target + 0
	incf	    offset,F
	call	    tpts_routine
	movwf	    target + 1
	    ENDM
    endif

    if	    FAMILY == 1
tpts_routine
	LD8TBL	    tpts,offset

   flmss
    else
   flmss_
    endif
flmss_start
	movf	    itptr,W
    if	    FAMILY == 0
	call	    tpts
	movwf	    cur_term
	subwf	    crisp,W
	btfss	    _C
	goto	    mindone
	btfss	    _Z
	goto	    cmp_flmss
    else
     if     RESOLUTION == 8
	GET_TERM
	movwf	    cur_term
	subwf	    crisp,W
	btfss	    _C
	goto	    mindone
	btfss	    _Z
	goto	    cmp_flmss
     else
	GET_TERM    cur_term
	FSUB16F     cur_term,crisp,Temp16
	btfss	    _C
	goto	    mindone
	FTSTFSZ16   Temp16
	goto	    cmp_flmss
     endif
    endif
	incf	    itptr,W
    if	    FAMILY == 1
     if     RESOLUTION == 8
	GET_TERM
	andlw	    0x0FF
     else
	GET_TERM    Temp16
	iorwf	    Temp16+0,W
     endif
    else
	call	    tpts
	andlw	    0x0FF
    endif
	btfss	    _Z
	goto	    mindone
	goto	    maxdone
cmp_flmss
	movlw	    .2
	addwf	    itptr,W
    if	    FAMILY == 0
	call	    tpts
	movwf	    cur_term2
	movf	    crisp,W
	subwf	    cur_term2,W
	btfss	    _C
    else
     if     RESOLUTION == 8
	GET_TERM
	movwf	    cur_term2
	movf	    crisp,W
	subwf	    cur_term2,W
	btfss	    _C
     else
	GET_TERM    cur_term2
	FCPFSLE16   crisp,cur_term2
     endif
    endif
	goto	    ds
as
	movlw	    .1
	addwf	    itptr,W
    if	    FAMILY == 1
     if     RESOLUTION == 8
	GET_TERM
	andlw	    0x0FF
     else
	GET_TERM    Temp16
	iorwf	    Temp16+0,W
     endif
    else
	call	    tpts
	andlw	    0x0FF
    endif
	btfsc	    _Z
	goto	    maxdone

    if	    RESOLUTION == 8
	movwf	    mulplr
	movf	    cur_term,W
	subwf	    crisp,W
	movwf	    mulcnd
	call	    mpy8_8
	bcf	    _C
	rrf	    res_mpy+0,W
	andlw	    0x0FF
	btfss	    _Z
	goto	    maxdone
	rrf	    res_mpy+1,W
    else
	FMOV16	    Temp16,mulplr
	FSUB16F     cur_term,crisp,mulcnd
	call	    mpy16_16
	bcf	    _C
	rrf	    res_mpy+0,W
	movwf	    Temp16+0
	rrf	    res_mpy+1,W
	movwf	    Temp16+1
	iorwf	    Temp16+0,W
	btfss	    _Z
	goto	    maxdone
	rrf	    res_mpy+2,W
	movwf	    Temp16+0
	rrf	    res_mpy+3,W
	movwf	    Temp16+1
    endif
	goto	    store
ds
	movlw	    .3
	addwf	    itptr,W
    if	    FAMILY == 1
     if     RESOLUTION == 8
	GET_TERM
	andlw	    0x0FF
     else
	GET_TERM    Temp16
	iorwf	    Temp16+0,W
     endif
    else
	call	    tpts
	andlw	    0x0FF
    endif
	btfsc	    _Z
	goto	    mindone
    if	    RESOLUTION == 8
	movwf	    mulplr
	movf	    cur_term2,W
	subwf	    crisp,W
	movwf	    mulcnd
	call	    mpy8_8
	bcf	    _C
	rrf	    res_mpy+0,W
	andlw	    0x0FF
	btfss	    _Z
	goto	    mindone
	rrf	    res_mpy+1,F
	comf	    res_mpy+1,W
    else
	FMOV16	    Temp16,mulplr
	FSUB16F     cur_term2,crisp,mulcnd
	call	    mpy16_16
	bcf	    _C
	rrf	    res_mpy+0,W
	movwf	    Temp16+0
	rrf	    res_mpy+1,W
	movwf	    Temp16+1
	iorwf	    Temp16+0,W
	btfss	    _Z
	goto	    mindone
	rrf	    res_mpy+2,W
	movwf	    Temp16+0
	rrf	    res_mpy+3,W
	movwf	    Temp16+1
	FCOMF16     Temp16
    endif
	goto	    store
maxdone
    if	    RESOLUTION == 8
	movlw	    0x0FF
    else
	movlw	    0x0FF
	movwf	    Temp16+0
	movwf	    Temp16+1
    endif
	goto	    store
mindone
    if	    RESOLUTION == 8
	movlw	    0x000
    else
	movlw	    0x000
	movwf	    Temp16+0
	movwf	    Temp16+1
    endif
store
    if	    RESOLUTION == 8
	SET_PAGE
	movwf	    0
	INC_FSR
	RES_PAGE
    else
	SET_PAGE
	FMOV16F0    Temp16
	INC_FSR
	RES_PAGE
    endif
	movlw	    4
	addwf	    itptr,F
	decfsz	    itcnt,F
	goto	    flmss_start
    if	    FAMILY == 1
	return
    else
	retlw	    0
    endif

; The end of module flmss

