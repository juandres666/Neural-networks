;*-----------------------------------------------------------------------------*
;*------------------------- fuzzyTECH MCU-MP V4.1 -----------------------------*
;* (c) 1995 Inform Software Corporation, 2001 Midwest Road, Oak Brook, IL60521 *
;*------------ (c) 1995 Inform GmbH, Pascalstr. 23, 52076 Aachen --------------*
;*-----------------------------------------------------------------------------*
;*------------------ routine inference maximum for PIC17Cxx -------------------*
;*-----------------------------------------------------------------------------*


rt_max_routine
        tablrd  0,0,WREG
        tlrd    1,WREG
        btfsc   rtptr,0
        tablrd  0,1,WREG
        btg     rtptr,0
        return

Max
        clrf        rtptr,F
        tablrd      0,1,WREG
        tlrd        1,rulecount+1
        tlrd        0,rulecount
start_rule_max
        FCLR        max_tmp
        tablrd      0,1,WREG
        tlrd        1,no_i
        tlrd        0,no_o
cmp_max
       call        rt_max_routine
        COMP_FSR
    if      RESOLUTION == 8
        SET_PAGE
        movpf       INDF0,WREG
        RES_PAGE
        cpfslt      max_tmp
       goto        next_in_max
        movwf       max_tmp
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
        FCPFSLT16   max_tmp,Temp16
       goto        next_in_max
        FMOV16      Temp16,max_tmp
    endif
next_in_max
        decfsz      no_i,F
       goto        cmp_max
comp_max
       call        rt_max_routine
        COMP_FSR
    if	    RESOLUTION == 8
        SET_PAGE
        movpf       INDF0,WREG
        RES_PAGE
       cpfsgt      max_tmp
       goto        next_out_max
      if BANKED == 0
        SET_PAGE
        decf        FSR0,F
       movfp       max_tmp,INDF0
        RES_PAGE
      else
       movfp       max_tmp,WREG
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
       FCPFSGT16   max_tmp,Temp16
       goto        next_out_max
     if BANKED == 1
       FMOV16      max_tmp,BASEREG
     endif
        SET_PAGE
        decf        FSR0,F
        decf        FSR0,F
     if BANKED == 0
       FMOV16F0    max_tmp
     else
        FMOV16F0    BASEREG
     endif
        RES_PAGE
    endif
next_out_max
        decfsz      no_o,F
       goto        comp_max
        btfss       rtptr,0
       goto        next_rule_max
        bcf         rtptr,0
        tablrd      0,1,WREG
next_rule_max
        FDEC16      rulecount
        FTSTFSZ16   rulecount
       goto        start_rule_max
	return

; The end of module inference maximum

