;-----------------------------------------------------------------------------
;----------------------- fuzzyTECH 5.52 MCU-MP Edition -----------------------
;-----------------------------------------------------------------------------
;------------------- Code Generator: Assembler Source Code -------------------
;--------------- Code Generation Date: Mon Nov 30 05:12:42 2009 --------------
;------------------------ Fuzzy Logic System: MOTORCON -----------------------
;-----------------------------------------------------------------------------
;---------- (c) 1991-2001 INFORM GmbH, Pascalstr. 23, D-52076 Aachen ---------
;-------- Inform Software Corp., 2001 Midwest Rd., Oak Brook, IL 60523 -------
;-----------------------------------------------------------------------------

                        
                        
;------------------ slope term definition (x1, a_s, x3, d_s) -----------------
tpts                    
                DW      03400H, 03400H, 03464H, 0341EH
                DW      0346DH, 03455H, 03473H, 0342BH
                DW      0347EH, 034FFH, 03480H, 034FFH
                DW      03481H, 034FFH, 03483H, 034FFH
                DW      03484H, 034FFH, 03486H, 034FFH
                DW      03487H, 034FFH, 03489H, 034FFH
                DW      0348AH, 034AAH, 034FFH, 03400H
                DW      03400H, 03400H, 03400H, 03408H
                DW      03400H, 03408H, 0343FH, 03408H
                DW      0343FH, 03408H, 0347FH, 03408H
                DW      0347FH, 03408H, 034BFH, 03408H
                DW      034BFH, 03408H, 034FFH, 03400H

;------------------------ xcom table (defuzzification) -----------------------
xcom                    
                DW      03400H, 0343FH, 0347FH, 034BFH, 034FFH

;--------------------------------- rule table --------------------------------
rt0                     
                DW      03423H
                DW      03402H, 03401H, 03400H, 03407H, 0340CH
                DW      03402H, 03401H, 03400H, 03408H, 0340CH
                DW      03402H, 03401H, 03400H, 03409H, 0340CH
                DW      03402H, 03401H, 03400H, 0340AH, 0340DH
                DW      03402H, 03401H, 03400H, 0340BH, 0340EH
                DW      03402H, 03401H, 03401H, 03407H, 0340CH
                DW      03402H, 03401H, 03401H, 03408H, 0340CH
                DW      03402H, 03401H, 03401H, 03409H, 0340DH
                DW      03402H, 03401H, 03401H, 0340AH, 0340EH
                DW      03402H, 03401H, 03401H, 0340BH, 0340FH
                DW      03402H, 03401H, 03402H, 03407H, 0340CH
                DW      03402H, 03401H, 03402H, 03408H, 0340DH
                DW      03402H, 03401H, 03402H, 03409H, 0340EH
                DW      03402H, 03401H, 03402H, 0340AH, 0340FH
                DW      03402H, 03401H, 03402H, 0340BH, 03410H
                DW      03402H, 03401H, 03403H, 03407H, 0340DH
                DW      03402H, 03401H, 03403H, 03408H, 0340EH
                DW      03402H, 03401H, 03403H, 03409H, 0340FH
                DW      03402H, 03401H, 03403H, 0340AH, 03410H
                DW      03402H, 03401H, 03403H, 0340BH, 03410H
                DW      03402H, 03401H, 03404H, 03407H, 0340EH
                DW      03402H, 03401H, 03404H, 03408H, 0340FH
                DW      03402H, 03401H, 03404H, 03409H, 03410H
                DW      03402H, 03401H, 03404H, 0340AH, 03410H
                DW      03402H, 03401H, 03404H, 0340BH, 03410H
                DW      03402H, 03401H, 03405H, 03407H, 0340FH
                DW      03402H, 03401H, 03405H, 03408H, 03410H
                DW      03402H, 03401H, 03405H, 03409H, 03410H
                DW      03402H, 03401H, 03405H, 0340AH, 03410H
                DW      03402H, 03401H, 03405H, 0340BH, 03410H
                DW      03402H, 03401H, 03406H, 03407H, 03410H
                DW      03402H, 03401H, 03406H, 03408H, 03410H
                DW      03402H, 03401H, 03406H, 03409H, 03410H
                DW      03402H, 03401H, 03406H, 0340AH, 03410H
                DW      03402H, 03401H, 03406H, 0340BH, 03410H

;-------------------------------- initmotorcon -------------------------------
initmotorcon            
                FPREP_PAGE  .12
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
                movlw   .7
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
                FPREP_PAGE  .12
                movlw   .5
                movwf   otcnt
                call    com  
                rlf     invalidflags,F  
                btfsc   invalidflags,0  
                movlw   0x080
                movwf   lv2_DatoMotor   
                        
                return  
                        
                include "FLMSS.ASM"                ;"FLMSS.ASM"
                include "Min.asm"                  ;"MIN.ASM"
                include "COM.ASM"                  ;"COM.ASM"
                include "MPY8_8.ASM"               ;"MPY8_8.ASM"
                include "DIV16_8.ASM"              ;"DIV16_8.ASM"
                        
;data size knowledge base (bytes):
;RAM:        21   00015H
;ROM:       229   000E5H
;TOTAL:     250   000FAH
;
