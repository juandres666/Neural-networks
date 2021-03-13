;-----------------------------------------------------------------------------
;----------------- fuzzyTECH 5.1 MP Edition --- Preassembler -----------------
;-------- Inform Software Corp., 2001 Midwest Rd., Oak Brook, IL 60523 -------
;---------- (c) 1991-1998 INFORM GmbH, Pascalstr. 23, D-52076 Aachen ---------
;-----------------------------------------------------------------------------
;--------------- code generation date: Fri Dec 19 11:42:14 1997 --------------
;------------------------------ project: MYPROJ ------------------------------
;-----------------------------------------------------------------------------

                        
                        
;------------------ slope term definition (x1, a_s, x3, d_s) -----------------
tpts                    
                DW      03480H, 03406H, 034FFH, 03400H
                DW      03433H, 03406H, 03488H, 03406H
                DW      03400H, 03400H, 03433H, 03406H
                DW      03400H, 03400H, 03400H, 03404H
                DW      03400H, 03404H, 03480H, 03404H
                DW      03480H, 03404H, 034FFH, 03400H

;------------------------ xcom table (defuzzification) -----------------------
xcom                    
                DW      0342DH, 03480H, 034D9H

;--------------------------------- rule table --------------------------------
rt0                     
                DW      03405H
                DW      03402H, 03401H, 03400H, 03403H, 03406H
                DW      03402H, 03401H, 03401H, 03405H, 03406H
                DW      03402H, 03401H, 03402H, 03404H, 03407H
                DW      03402H, 03401H, 03400H, 03405H, 03408H
                DW      03402H, 03401H, 03400H, 03404H, 03406H

;--------------------------------- initmyproj --------------------------------
initmyproj              
                FPREP_PAGE  .6
                movlw   .3
                movwf   loopcnt
initloop        FCLR_INC_FSR    
                decfsz  loopcnt,F   
                goto    initloop    
                return  
                        
                        
;-----------------------------------------------------------------------------
myproj                  
                movlw   fuzvals
                movwf   FSR
                clrf    itptr
;------------------------------- fuzzification -------------------------------
                movlw   .3
                movwf   itcnt
                movf    lv0_Input_1,W   
                movwf   crisp
                call    flmss
                        
                movlw   .3
                movwf   itcnt
                movf    lv1_Input_2,W   
                movwf   crisp
                call    flmss
                        
;--------------------------------- inference ---------------------------------
                LD_TBL16    rt0
                        
                call    Min                        ;min aggregation
;------------------------------ defuzzification ------------------------------
                clrf    invalidflags    
                clrf    otoffset    
                FPREP_PAGE  .6
                movlw   .3
                movwf   otcnt
                call    com
                rlf     invalidflags,F  
                btfsc   invalidflags,0  
                movlw   0x080
                movwf   lv2_Output  
                        
                return  
                        
                include "FLMSS.ASM"                ;"FLMSS.ASM"
                include "Min.asm"                  ;"MIN.ASM"
                include "COM.ASM"                  ;"COM.ASM"
                include "MPY8_8.ASM"               ;"MPY8_8.ASM"
                include "DIV16_8.ASM"              ;"DIV16_8.ASM"
                        
;data size knowledge base (bytes):
;RAM:        13   0000DH
;ROM:        53   00035H
;TOTAL:      66   00042H
;
