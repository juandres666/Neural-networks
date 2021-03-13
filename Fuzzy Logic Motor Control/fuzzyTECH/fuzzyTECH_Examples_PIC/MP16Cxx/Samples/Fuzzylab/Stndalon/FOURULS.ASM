;-----------------------------------------------------------------------------
;---------------- fuzzyTECH 5.10 MP Explorer --- Preassembler ----------------
;-----------------------------------------------------------------------------
;---------- (c) 1991-1998 INFORM GmbH, Pascalstr. 23, D-52076 Aachen ---------
;-------- Inform Software Corp., 2001 Midwest Rd., Oak Brook, IL 60523 -------
;-----------------------------------------------------------------------------
;--------------- Code Generation Date: Wed Feb 25 10:50:53 1998 --------------
;------------------------------ Project: 4RULES ------------------------------
;-----------------------------------------------------------------------------



;------------------ slope term definition (x1, a_s, x3, d_s) -----------------
tpts
                DW      03400H, 03400H, 03402H, 0340BH
                DW      0341AH, 03414H, 03434H, 03407H
                DW      03456H, 03409H, 0348FH, 03408H
                DW      034A0H, 03405H, 034FFH, 03400H

;------------------------ xcom table (defuzzification) -----------------------
xcom
                DW      03401H, 03429H, 0348AH, 034FFH

;--------------------------------- rule table --------------------------------
rt0
                DW      03404H
                DW      03401H, 03401H, 03400H, 03404H
                DW      03401H, 03401H, 03401H, 03405H
                DW      03401H, 03401H, 03402H, 03406H
                DW      03401H, 03401H, 03403H, 03407H

;--------------------------------- init4rules --------------------------------
init4rules
                FPREP_PAGE  .4
                movlw   .4
                movwf   loopcnt
initloop        FCLR_INC_FSR
                decfsz  loopcnt,F
                goto    initloop
                return


;-----------------------------------------------------------------------------
FourRules       movlw   fuzvals
                movwf   FSR
                clrf    itptr
;------------------------------- fuzzification -------------------------------
                movlw   .4
                movwf   itcnt
                movf    lv0_DeltaTemp,W
                movwf   crisp
                call    flmss

;--------------------------------- inference ---------------------------------
                LD_TBL16    rt0

                call    Min                        ;min aggregation
;------------------------------ defuzzification ------------------------------
                clrf    invalidflags
                clrf    otoffset
                FPREP_PAGE  .4
                movlw   .4
                movwf   otcnt
                call    com
                rlf     invalidflags,F
                btfsc   invalidflags,0
                movlw   0x001
                movwf   lv1_DutyCycle

                return

                include "FLMSS.ASM"                ;"FLMSS.ASM"
                include "Min.asm"                  ;"MIN.ASM"
                include "COM.ASM"                  ;"COM.ASM"
                include "MPY8_8.ASM"               ;"MPY8_8.ASM"
                include "DIV16_8.ASM"              ;"DIV16_8.ASM"

;data size knowledge base (bytes):
;RAM:        11   0000BH
;ROM:        37   00025H
;TOTAL:      48   00030H
;
