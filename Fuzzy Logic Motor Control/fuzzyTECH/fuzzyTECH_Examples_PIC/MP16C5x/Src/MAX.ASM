;*-----------------------------------------------------------------------------*
;*------------------------- fuzzyTECH MCU-MP V4.1 -----------------------------*
;* (c) 1995 Inform Software Corporation, 2001 Midwest Road, Oak Brook, IL60521 *
;*------------ (c) 1995 Inform GmbH, Pascalstr. 23, 52076 Aachen --------------*
;*-----------------------------------------------------------------------------*
;*-------------------- routine inference maximum for PIC16 --------------------*
;*-----------------------------------------------------------------------------*

GET_TAB     MACRO
    if	    FAMILY < 1
	movf	    rtptr,W
	call	    rt0
    else
	call	    rt_routine
    endif
	incf	    rtptr,F
    if	    LARGE_RT == 1
	btfsc	    _Z
	incf	    rtptr+1,F
    endif
	    ENDM

    if	    FAMILY == 1
rt_routine
     if     LARGE_RT == 0
	LD8PTR	    rt_table,rtptr
     else
	LD16PTR     rt_table,rtptr
     endif
    endif

Max
        IS_PAGE     fuzvals
	clrf	    rtptr
    if	    LARGE_RT == 1
	clrf	    rtptr+1
    endif
	GET_TAB
        movwf       rulecount
start_rule_max
    if	    RESOLUTION == 8
	clrf	    max_tmp
    else
        FCLR16      max_tmp
    endif
	GET_TAB
	movwf	    no_i
	GET_TAB
	movwf	    no_o
cmp_max
	GET_TAB
	COMP_FSR
	SET_PAGE
    if	    RESOLUTION == 8
        movf        0,W
    else
	FMOV0F16    Temp16
    endif
        RES_PAGE
    if	    RESOLUTION == 8
     if      FAMILY == 0
      if     BANKED == 1
	movwf	    save_wreg
      endif
     endif
	subwf	    max_tmp,W
	btfsc	    _C
       goto        next_in_max
     if      FAMILY == 0
      if     BANKED == 0
	movf	    0,W
	movwf	    max_tmp
      else
	movf	    save_wreg,W
	movwf	    max_tmp
      endif
     else
	SET_PAGE
	movf	    0,W
	movwf	    max_tmp
	RES_PAGE
     endif
    else
	FCPFSLT16   max_tmp,Temp16
       goto        next_in_max
        FMOV16      Temp16,max_tmp
    endif
next_in_max
        decfsz      no_i,F
       goto        cmp_max
comp_max
	GET_TAB
	COMP_FSR
    if	    RESOLUTION == 8
	SET_PAGE
	movf	    0,W
	RES_PAGE
       subwf       max_tmp,W
	btfss	    _C
       goto        next_out_max
       movf        max_tmp,W
	SET_PAGE
	movwf	    0
	RES_PAGE
    else
	SET_PAGE
	FMOV0F16    Temp16
	RES_PAGE
       FCPFSGT16   max_tmp,Temp16
       goto        next_out_max
	SET_PAGE
       FMOV16F0    max_tmp
	RES_PAGE
    endif
next_out_max
        decfsz      no_o,F
       goto        comp_max
        decfsz      rulecount,F
       goto        start_rule_max
    if	    FAMILY  ==	1
        return
    endif

; The end of module inference maximum

