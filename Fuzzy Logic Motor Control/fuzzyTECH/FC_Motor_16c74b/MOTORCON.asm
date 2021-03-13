;-----------------------------------------------------------------------------
;----------------------- fuzzyTECH 5.52 MCU-MP Edition -----------------------
;-----------------------------------------------------------------------------
;------------------- Code Generator: Assembler Source Code -------------------
;--------------- Code Generation Date: Sun Nov 29 13:36:52 2009 --------------
;------------------------ Fuzzy Logic System: MOTORCON -----------------------
;-----------------------------------------------------------------------------
;---------- (c) 1991-2001 INFORM GmbH, Pascalstr. 23, D-52076 Aachen ---------
;-------- Inform Software Corp., 2001 Midwest Rd., Oak Brook, IL 60523 -------
;-----------------------------------------------------------------------------

                        
                        
;------------------ slope term definition (x1, a_s, x3, d_s) -----------------
tpts                    
                DW      03400H, 03400H, 0347BH, 03466H
                DW      0347DH, 034AAH, 03480H, 034FFH
                DW      03480H, 03466H, 034FFH, 03400H
                DW      03400H, 03400H, 03400H, 03408H
                DW      03400H, 03408H, 03441H, 03408H
                DW      03441H, 03408H, 0347FH, 03408H
                DW      0347FH, 03408H, 034C1H, 03408H
                DW      034C1H, 03408H, 034FFH, 03400H

;------------------------ xcom table (defuzzification) -----------------------
xcom                    
                DW      0342AH, 03456H, 03480H, 034A9H, 034D5H

;--------------------------------- rule table --------------------------------
rt0                     
                DW      0340FH
                DW      03402H, 03401H, 03400H, 03403H, 03408H
                DW      03402H, 03401H, 03400H, 03404H, 03408H
                DW      03402H, 03401H, 03400H, 03405H, 03409H
                DW      03402H, 03401H, 03400H, 03406H, 0340AH
                DW      03402H, 03401H, 03400H, 03407H, 0340BH
                DW      03402H, 03401H, 03401H, 03403H, 03408H
                DW      03402H, 03401H, 03401H, 03404H, 0340AH
                DW      03402H, 03401H, 03401H, 03405H, 0340BH
                DW      03402H, 03401H, 03401H, 03406H, 0340CH
                DW      03402H, 03401H, 03401H, 03407H, 0340CH
                DW      03402H, 03401H, 03402H, 03403H, 03409H
                DW      03402H, 03401H, 03402H, 03404H, 0340AH
                DW      03402H, 03401H, 03402H, 03405H, 0340BH
                DW      03402H, 03401H, 03402H, 03406H, 0340CH
                DW      03402H, 03401H, 03402H, 03407H, 0340CH

;-------------------------------- initmotorcon -------------------------------
initmotorcon            
                FPREP_PAGE  .8
                movlw   .5
                movwf   loopcnt
initloop        FCLR_INC_FSR    
                decfsz  loopcnt,F   
                goto    initloop    
                return  
                        
                        
;-----------------------------------------------------------------------------
motorcon                
                movlw   fuzvals
                movwf   FSR
                clrf    itptr
;------------------------------- fuzzification -------------------------------
                movlw   .3
                movwf   itcnt
                movf    lv0_DatoError,W 
                movwf   crisp
                call    flmss
                        
                movlw   .5
                movwf   itcnt
                movf    lv1_DatoReferencia,W    
                movwf   crisp
                call    flmss
                        
;--------------------------------- inference ---------------------------------
                LD_TBL16    rt0
                        
                call    Min                        ;Max-Min
;------------------------------ defuzzification ------------------------------
                clrf    invalidflags    
                clrf    otoffset    
                FPREP_PAGE  .8
                movlw   .5
                movwf   otcnt
                call    com;þ·—<mI q  
                rlf     invalidflags,F  
                btfsc   invalidflags,0  
                movlw   0x001
                movwf   lv2_DatoMotor   
                        
                return  
                        
                include "FLMSS.ASM"                ;"FLMSS.ASM"
                include "Min.asm"                  ;"MIN.ASM"
                include "COM.ASM"                  ;"COM.ASM"
                include "MPY8_8.ASM"               ;"MPY8_8.ASM"
                include "DIV16_8.ASM"              ;"DIV16_8.ASM"
                        
;data size knowledge base (bytes):
;RAM:        17   00011H
;ROM:       113   00071H
;TOTAL:     130   00082H
;
