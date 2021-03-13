;*-----------------------------------------------------------------------------*
;*------------------------- fuzzyTECH MCU-MP V4.1 -----------------------------*
;* (c) 1995 Inform Software Corporation, 2001 Midwest Road, Oak Brook, IL60521 *
;*------------ (c) 1995 Inform GmbH, Pascalstr. 23, 52076 Aachen --------------*
;*-----------------------------------------------------------------------------*
;*--------- defuzzification routine center of maximum for PIC17Cxx ------------*
;*-----------------------------------------------------------------------------*

xcom_routine
        ADD_TBL16   xcom, WREG
        tablrd      0, 0, WREG
        return

com
    if	    RESOLUTION == 8
        FCLR24      num
        FCLR16      denom
    else
        FCLR32      num
        FCLR16      denom
    endif
start_com
    if	    RESOLUTION == 8
        SET_PAGE
        movfp       INDF0,WREG
        decf        FSR0,F
        clrf        INDF0,F
        INC_FSR
        RES_PAGE
        andlw       0x0FF
        btfsc       _Z
        goto        ready_com
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
        bcf         _C
        FRR16       Temp16
        bcf         _C
        FRR16       Temp16
        bcf         _C
        FRR16       Temp16
        movfp       Temp16+0,WREG
        iorwf       Temp16+1,W
        btfsc       _Z
        goto        ready_com
    endif
    if      RESOLUTION == 8
        movwf       mulplr
        FADD8TO16   WREG, denom
    else
        FMOV16      Temp16,mulplr
        FADD16      Temp16,denom
    endif
        movfp       otoffset,WREG
        call        xcom_routine
    if      RESOLUTION == 8
        tlrd        0,mulcnd
     if     HW_MULTIPLIER == 0
        call        mpy8_8
        FADD16TO24  res_mpy,num
     else
        movfp       mulcnd,WREG
        mulwf       mulplr
        movpf       PRODL,res_mpy+1
        movpf       PRODH,res_mpy+0
        FADD16TO24  res_mpy,num
     endif
    else
        tlrd        0,mulcnd+1
        tlrd        1,mulcnd+0
        call        mpy16_16
        FADD32      res_mpy,num
    endif
ready_com
        incf        otoffset,F
        decfsz      otcnt,F
        goto        start_com
    if	    RESOLUTION == 8
ishift_com
        tstfsz      num
        goto        ishift_com2
        tstfsz      denom
        goto        ishift_com2
        goto        compute_com
ishift_com2
        bcf         _C
        FRR24       num
        bcf         _C
        FRR16       denom
        goto        ishift_com
    endif
compute_com
    if	    RESOLUTION == 8
        tstfsz      denom+1
    else
        FTSTFSZ16   denom+0
    endif
        goto        rout_div_com
        bsf         _C
        return
rout_div_com
    if	    RESOLUTION == 8
        call        div16_8
    else
        call        div32_16
    endif
        bcf         _C
    if	    RESOLUTION == 8
        movfp       res_div+1,WREG
    else
        FMOV16      res_div+2,Temp16
    endif
	return

; The end of module com

