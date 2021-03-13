;*-----------------------------------------------------------------------------*
;*------------------------- fuzzyTECH MCU-MP V4.1 -----------------------------*
;* (c) 1995 Inform Software Corporation, 2001 Midwest Road, Oak Brook, IL60521 *
;*------------ (c) 1995 Inform GmbH, Pascalstr. 23, 52076 Aachen --------------*
;*-----------------------------------------------------------------------------*
;*------- routine inference minimum with Degree of Support for PIC17Cxx -------*
;*-----------------------------------------------------------------------------*


rt_minp_routine
        tablrd      0,0,WREG
        tlrd        1,WREG
        btfsc       rtptr,0
        tablrd      0,1,WREG
        btg     rtptr,0
        return

minprod
        clrf        rtptr,F
        tablrd      0,1,WREG
        tlrd        1,rulecount+1
        tlrd        0,rulecount
start_rule_minp
        FSET        min_tmp
        tablrd      0,1,WREG
        tlrd        1,no_i
        tlrd        0,no_o
cmp_minp
    	call	    rt_minp_routine
        COMP_FSR
    if	    RESOLUTION == 8
        SET_PAGE
        movpf       INDF0,WREG
        RES_PAGE
        cpfsgt      min_tmp
    	goto	    next_in_minp
        movwf       min_tmp
    else
        SET_PAGE
     if BANKED == 0
        FMOV0F16    Temp16
     else
        FMOV0F16    BASEREG
     endif
        RES_PAGE
     if BANKED == 1
        FMOV16      BASEREG,Temp16
     endif
        FCPFSLT16   Temp16,min_tmp
    	goto	    next_in_minp
        FMOV16      Temp16,min_tmp
    endif
next_in_minp
        decfsz      no_i,F
    	goto	    cmp_minp
comp_minp
    if RESOLUTION == 8
       movfp       min_tmp,WREG
       movwf       cmp_reg
    	movwf	    mulplr
    else
    	FMOV16	    min_tmp,cmp_reg
    	FMOV16	    min_tmp,mulplr
    endif
       call        rt_minp_routine
    if      RESOLUTION == 8
     if     HW_MULTIPLIER == 0
       movwf       mulcnd
       sublw       0x080
       btfsc       _Z
    	goto	    comp2_minp
    	call	    mpy8_8
     else
       mulwf       mulplr
       movpf       PRODL,res_mpy+1
       movpf       PRODH,res_mpy+0
     endif
       rlcf        res_mpy+1,F
    	rlcf	    res_mpy+0,W
       movwf       cmp_reg
    else
       movwf       mulcnd
       sublw       0x080
    	btfsc	    _Z
    	goto	    comp2_minp
       clrf        mulcnd+1,F
    	call	    mpy16_16
       rlcf        res_mpy+2,F
       rlcf        res_mpy+1,F
       rlcf        res_mpy+0,F
    	FMOV16	    res_mpy,cmp_reg
    endif
comp2_minp
    	call	    rt_minp_routine
        COMP_FSR
     if RESOLUTION == 8
        SET_PAGE
        movpf       INDF0,WREG
        RES_PAGE
       cpfsgt      cmp_reg
    	goto	    next_out_minp
      if     BANKED == 0
        SET_PAGE
        decf        FSR0,F
       movfp       cmp_reg,INDF0
        RES_PAGE
      else
       movfp       cmp_reg,WREG
        SET_PAGE
        decf        FSR0,F
        movwf       INDF0
        RES_PAGE
      endif
     else
        SET_PAGE
      if BANKED == 0
        FMOV0F16    Temp16
      else
        FMOV0F16    BASEREG
      endif
        RES_PAGE
      if BANKED == 1
        FMOV16      BASEREG,Temp16
      endif
    	FCPFSGT16   cmp_reg,Temp16
    	goto	    next_out_minp
      if BANKED == 1
       FMOV16      cmp_reg,BASEREG
      endif
        SET_PAGE
        decf        FSR0,F
        decf        FSR0,F
      if BANKED == 0
       FMOV16F0    cmp_reg
      else
        FMOV16F0    BASEREG
      endif
        RES_PAGE
     endif
next_out_minp
        decfsz      no_o,F
    	goto	    comp_minp
        btfss       rtptr,0
    	goto	    next_rule_minp
        bcf         rtptr,0
        tablrd      0,1,WREG
next_rule_minp
        FDEC16      rulecount
        FTSTFSZ16   rulecount
    	goto	    start_rule_minp
        return

; The end of module inference minimum with DoS

