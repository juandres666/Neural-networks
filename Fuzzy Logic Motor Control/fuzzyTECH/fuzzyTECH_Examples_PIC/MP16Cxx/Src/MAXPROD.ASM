;*-----------------------------------------------------------------------------*
;*------------------------- fuzzyTECH MCU-MP V4.1 -----------------------------*
;* (c) 1995 Inform Software Corporation, 2001 Midwest Road, Oak Brook, IL60521 *
;*------------ (c) 1995 Inform GmbH, Pascalstr. 23, 52076 Aachen --------------*
;*-----------------------------------------------------------------------------*
;*--------- routine inference maximum with Degree of Support for PIC16 --------*
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

maxprod
        IS_PAGE     fuzvals
	clrf	    rtptr
    if	    LARGE_RT == 1
	clrf	    rtptr+1
    endif
	GET_TAB
        movwf       rulecount
start_rule_maxp
    if	    RESOLUTION == 8
	clrf	    max_tmp
    else
        FCLR16      max_tmp
    endif
	GET_TAB
	movwf	    no_i
	GET_TAB
	movwf	    no_o
cmp_maxp
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
       goto        next_in_maxp
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
       goto        next_in_maxp
        FMOV16      Temp16,max_tmp
    endif
next_in_maxp
        decfsz      no_i,F
       goto        cmp_maxp
comp_maxp
       GET_TAB
       movwf       mulcnd
       sublw       0x080
       btfss       _Z
       goto        comp_weight
    if RESOLUTION == 8
       movf        max_tmp,W
    	movwf	    cmp_reg
    else
       FMOV16      max_tmp,cmp_reg
    endif
       goto        comp_ready
comp_weight
    if RESOLUTION == 8
       movf        max_tmp,W
       movwf       mulplr
    	call	    mpy8_8
       rlf         res_mpy+1,F
       rlf         res_mpy+0,W
    	movwf	    cmp_reg
    else
       FMOV16      max_tmp,mulplr
    	clrf	    mulcnd+1
    	call	    mpy16_16
       rlf         res_mpy+2,F
       rlf         res_mpy+1,F
       rlf         res_mpy+0,F
    	FMOV16	    res_mpy,cmp_reg
    endif
comp_ready
	GET_TAB
	COMP_FSR
    if	    RESOLUTION == 8
	SET_PAGE
	movf	    0,W
	RES_PAGE
       subwf       cmp_reg,W
	btfss	    _C
       goto        next_out_maxp
       movf        cmp_reg,W
	SET_PAGE
	movwf	    0
	RES_PAGE
    else
	SET_PAGE
	FMOV0F16    Temp16
	RES_PAGE
       FCPFSGT16   cmp_reg,Temp16
       goto        next_out_maxp
	SET_PAGE
       FMOV16F0    cmp_reg
	RES_PAGE
    endif
next_out_maxp
        decfsz      no_o,F
       goto        comp_maxp
        decfsz      rulecount,F
       goto        start_rule_maxp
    if	    FAMILY  ==	1
        return
    endif

; The end of module inference maximum with DoS

