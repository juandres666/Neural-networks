;*-----------------------------------------------------------------------------*
;*------------------------- fuzzyTECH MCU-MP V4.1 -----------------------------*
;* (c) 1995 Inform Software Corporation, 2001 Midwest Road, Oak Brook, IL60521 *
;*------------ (c) 1995 Inform GmbH, Pascalstr. 23, 52076 Aachen --------------*
;*-----------------------------------------------------------------------------*
;*----------- defuzzification routine center of maximum for PIC16 -------------*
;*-----------------------------------------------------------------------------*

GET_XCOM    MACRO   target
    if	    RESOLUTION == 8
	movwf	    offset
	call	    xcom_routine
	movwf	    target
    else
	movwf	    offset
	bcf	    _C
	rlf	    offset,F
	call	    xcom_routine
	movwf	    target+0
	incf	    offset,F
	call	    xcom_routine
	movwf	    target+1
    endif
	    ENDM

    if	    FAMILY == 1
xcom_routine
	LD8TBL	xcom,offset
    endif

com
    if	    RESOLUTION == 8
	FCLR24	    num
	FCLR16	    denom
    else
	FCLR32	    num
	FCLR16	    denom
    endif
start_com
    if	  RESOLUTION == 8
     if      FAMILY == 0
      if     BANKED == 0
	decf	    otcnt,F
	movf	    0,W
	clrf	    0
	decf	    FSR,F
	andlw	    0x0FF
      else
	decf	    otcnt,F
	SET_PAGE
	movf	    0,W
	clrf	    0
	bcf	    FSR,4
	decf	    FSR,F
	bsf	    FSR,4
	RES_PAGE
      endif
     else
	SET_PAGE
	movf	    0,W
	clrf	    0
	INC_FSR
	RES_PAGE
      if    BANKED == 0
	andlw	    0x0FF
      endif
     endif
    else
    FMOV0F16    Temp16
    FCLR0F16
    INC_FSR
        bcf         _C
	FRR16	    Temp16
	bcf	    _C
	FRR16	    Temp16
	bcf	    _C
	FRR16	    Temp16
	movf	    Temp16+0,W
	iorwf	    Temp16+1,W
    endif
	btfsc	    _Z
	goto	    ready_com
    if	    RESOLUTION == 8
	movwf	    mulplr
	FADD8TO16   mulplr, denom
    else
	FMOV16	    Temp16,mulplr
	FADD16	    Temp16,denom
    endif
    if	    FAMILY < 1
	movf	    otcnt,W
	call	    xcom
	movwf	    mulcnd
	call	    mpy8_8
	FADD16TO24  res_mpy,num
    else
	movf	    otoffset,W
     if     RESOLUTION == 8
	GET_XCOM    mulcnd
	call	    mpy8_8
	FADD16TO24  res_mpy,num
     else
	GET_XCOM    mulcnd
	call	    mpy16_16
	FADD32	    res_mpy,num
     endif
    endif
ready_com
    if	    FAMILY > 0
	incf	    otoffset,F
	decfsz	    otcnt,F
    else
	movf	    otcnt,F
	btfss	    _Z
    endif
	goto	    start_com
    if	    RESOLUTION == 8
ishift_com
	movf	    num+0,F
	btfss	    _Z
	goto	    ishift_com2
	movf	    denom+0,W
	btfsc	    _Z
	goto	    compute_com
ishift_com2
	bcf	    _C
	rrf	    num+0,F
	rrf	    num+1,F
	rrf	    num+2,F
	bcf	    _C
	rrf	    denom+0,F
	rrf	    denom+1,F
	goto	    ishift_com
    endif
compute_com
    if	    RESOLUTION == 8
	movf	    denom+1,W
	btfss	    _Z
    else
	FTSTFSZ16   denom+0
    endif
	goto	    rout_div_com
	bsf	    _C
    if	    FAMILY == 1
	return
    else
	goto	    end_com
    endif
rout_div_com
    if	    FAMILY == 1
     if     RESOLUTION == 8
	call	    div16_8
     else
	call	    div32_16
     endif
    else
	include     "div16_8.asm"
    endif
	bcf	    _C
    if	    RESOLUTION == 8
    movf        res_div+1,W
    else
	FMOV16	    res_div+2,Temp16
    endif
    if	    FAMILY == 1
	return
    else
 end_com
    endif

; The end of module com

