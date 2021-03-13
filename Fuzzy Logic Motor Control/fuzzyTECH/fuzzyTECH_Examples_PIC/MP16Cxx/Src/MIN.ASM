;*-----------------------------------------------------------------------------*
;*------------------------- fuzzyTECH MCU-MP V4.1 -----------------------------*
;* (c) 1995 Inform Software Corporation, 2001 Midwest Road, Oak Brook, IL60521 *
;*------------ (c) 1995 Inform GmbH, Pascalstr. 23, 52076 Aachen --------------*
;*-----------------------------------------------------------------------------*
;*-------------------- routine inference minimum for PIC16 --------------------*
;*-----------------------------------------------------------------------------*


GET_TAB     MACRO
     if FAMILY < 1
        movf        rtptr,W
        call        rt0
     else
        call        rt_routine
     endif
        incf        rtptr,F
     if LARGE_RT == 1
        btfsc       _Z
        incf        rtptr+1,F
     endif
            ENDM

    if      FAMILY == 1
rt_routine
     if     LARGE_RT == 0
        LD8PTR      rt_table,rtptr
     else
        LD16PTR     rt_table,rtptr
     endif
    endif

Min
        IS_PAGE     fuzvals
        clrf        rtptr
     if     LARGE_RT == 1
        clrf        rtptr+1
     endif
        GET_TAB
        movwf       rulecount
start_rule_min
    if      RESOLUTION == 8
        movlw       0x0FF
        movwf       min_tmp
    else
        movlw       0x0FF
        movwf       min_tmp+0
        movwf       min_tmp+1
    endif
        GET_TAB
        movwf       no_i
        GET_TAB
        movwf       no_o
cmp_min
        GET_TAB
        COMP_FSR
        SET_PAGE
    if      RESOLUTION == 8
        movf        0,W
    else
        FMOV0F16    Temp16
    endif
        RES_PAGE
    if     BANKED == 1
        btfss       _Z
       goto        cmp_min_ff
        clrf        min_tmp
        movf        no_i,W
        decf        rtptr,F
        addwf       rtptr,F
     if     LARGE_RT == 1
        btfsc       _Z
        incf        rtptr+1,F
     endif
       goto        comp_min
cmp_min_ff
     if     FAMILY == 0
        movwf       save_wreg
     endif
    endif
    if      RESOLUTION == 8
        subwf       min_tmp,W
        btfss       _C
    else
        FCPFSLT16   Temp16,min_tmp
    endif
       goto        next_in_min
    if      FAMILY == 0
     if     BANKED == 0
        movf        0,W
        movwf       min_tmp
     else
        movf        save_wreg,W
        movwf       min_tmp
     endif
    else
     if    RESOLUTION == 8
        movf        0,W
        movwf       min_tmp
     else
        FMOV0F16    min_tmp
     endif
    endif
next_in_min
        decfsz      no_i,F
       goto        cmp_min
comp_min
        GET_TAB
        COMP_FSR
     if RESOLUTION == 8
        SET_PAGE
        movf        0,W
        RES_PAGE
       subwf       min_tmp,W
        btfss       _C
       goto        next_out_min
       movf        min_tmp,W
        SET_PAGE
        movwf       0
        RES_PAGE
    else
        SET_PAGE
        FMOV0F16    Temp16
        RES_PAGE
       FCPFSGT16   min_tmp,Temp16
       goto        next_out_min
        SET_PAGE
       FMOV16F0    min_tmp
        RES_PAGE
    endif
next_out_min
        decfsz      no_o,F
       goto        comp_min
        decfsz      rulecount,F
       goto        start_rule_min
    if      FAMILY == 1
        return
    endif

; The end of module inference minimum

