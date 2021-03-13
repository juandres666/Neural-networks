;-----------------------------------------------------------------------------
;----------------- fuzzyTECH 5.1 MP Edition --- Preassembler -----------------
;-------- Inform Software Corp., 2001 Midwest Rd., Oak Brook, IL 60523 -------
;---------- (c) 1991-1998 INFORM GmbH, Pascalstr. 23, D-52076 Aachen ---------
;-----------------------------------------------------------------------------
;--------------- code generation date: Fri Dec 19 11:43:56 1997 --------------
;------------------------------ project: MYPROJ ------------------------------
;-----------------------------------------------------------------------------

                        
                        
;------------------ slope term definition (x1, a_s, x3, d_s) -----------------
tpts                    
                DB      080H, 006H, 0FFH, 000H
                DB      033H, 006H, 088H, 006H
                DB      000H, 000H, 033H, 006H
                DB      000H, 000H, 000H, 004H
                DB      000H, 004H, 080H, 004H
                DB      080H, 004H, 0FFH, 000H

;------------------------ xcom table (defuzzification) -----------------------
xcom                    
                DW      02DH, 080H, 0D9H

;--------------------------------- rule table --------------------------------
rt0                     
                DB      005H, 000H
                DB      002H, 001H, 000H, 003H, 006H, 000H
                DB      002H, 001H, 001H, 005H, 006H, 000H
                DB      002H, 001H, 002H, 004H, 007H, 000H
                DB      002H, 001H, 000H, 005H, 008H, 000H
                DB      002H, 001H, 000H, 004H, 006H, 000H

;--------------------------------- initmyproj --------------------------------
initmyproj              
                FSET_AUTO_INC   
                FPREP_PAGE  .6
                movlw   .3
                movwf   loopcnt
initloop        FCLR_INC_FSR    
                decfsz  loopcnt,F   
                goto    initloop    
                FCLR_AUTO   
                return  
                        
                        
;-----------------------------------------------------------------------------
myproj                  
                FSET_AUTO_INC   
                movlw   fuzvals
                movwf   FSR0
                clrf    itptr,F
;------------------------------- fuzzification -------------------------------
                movlw   .3
                movwf   itcnt
                movfp   lv0_Input_1,WREG    
                movwf   crisp
                call    flmss
                        
                movlw   .3
                movwf   itcnt
                movfp   lv1_Input_2,WREG    
                movwf   crisp
                call    flmss
                        
;--------------------------------- inference ---------------------------------
                LD_TBL16    rt0
                        
                call    Min                        ;min aggregation
;------------------------------ defuzzification ------------------------------
                clrf    invalidflags,F  
                clrf    otoffset,F  
                FPREP_PAGE  .6
                movlw   .3
                movwf   otcnt
                call    com
                rlcf    invalidflags,F  
                btfsc   invalidflags,0  
                movlw   0x080
                movwf   lv2_Output  
                        
                FCLR_AUTO   
                return  
                        
                include "FLMSS.ASM"                ;"FLMSS.ASM"
                include "Min.asm"                  ;"MIN.ASM"
                include "COM.ASM"                  ;"COM.ASM"
                if HW_MULTIPLIER == 0   
                include "MPY8_8.ASM"               ;"MPY8_8.ASM"
                endif   
                include "DIV16_8.ASM"              ;"DIV16_8.ASM"
                        
;data size knowledge base (bytes):
;RAM:        13   0000DH
;ROM:        59   0003BH
;TOTAL:      72   00048H
;
