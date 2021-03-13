;-----------------------------------------------------------------------------
;----------------- fuzzyTECH 5.1 MP Edition --- Preassembler -----------------
;-------- Inform Software Corp., 2001 Midwest Rd., Oak Brook, IL 60523 -------
;---------- (c) 1991-1998 INFORM GmbH, Pascalstr. 23, D-52076 Aachen ---------
;-----------------------------------------------------------------------------
;--------------- code generation date: Fri Dec 19 11:47:17 1997 --------------
;----------------------------- project: MYPROJ16 -----------------------------
;-----------------------------------------------------------------------------

                        
                        
;------------------ slope term definition (x1, a_s, x3, d_s) -----------------
tpts                    
                DW      0807FH, 00006H, 0FFFFH, 00000H
                DW      03333H, 00006H, 08887H, 00006H
                DW      00000H, 00000H, 03333H, 00006H
                DW      00000H, 00000H, 00000H, 00004H
                DW      00000H, 00004H, 0807FH, 00005H
                DW      0807FH, 00004H, 0FFFFH, 00000H

;------------------------ xcom table (defuzzification) -----------------------
xcom                    
                DW      02D1DH, 0803FH, 0D9B9H

;--------------------------------- rule table --------------------------------
rt0                     
                DB      00005H, 00000H
                DB      00002H, 00001H, 00000H, 00006H, 0000CH, 00000H
                DB      00002H, 00001H, 00002H, 0000AH, 0000CH, 00000H
                DB      00002H, 00001H, 00004H, 00008H, 0000EH, 00000H
                DB      00002H, 00001H, 00000H, 0000AH, 00010H, 00000H
                DB      00002H, 00001H, 00000H, 00008H, 0000CH, 00000H

;-------------------------------- initmyproj16 -------------------------------
initmyproj16            
                FSET_AUTO_INC   
                FPREP_PAGE  .12
                movlw   .3
                movwf   loopcnt
initloop        FCLR_INC_FSR    
                decfsz  loopcnt,F   
                goto    initloop    
                FCLR_AUTO   
                return  
                        
                        
;-----------------------------------------------------------------------------
myproj16                
                FSET_AUTO_INC   
                movlw   fuzvals
                movwf   FSR0
                clrf    itptr,F
;------------------------------- fuzzification -------------------------------
                movlw   .3
                movwf   itcnt
                FTMOV16 lv0_Input_1, crisp  
                call    flmss
                        
                movlw   .3
                movwf   itcnt
                FTMOV16 lv1_Input_2, crisp  
                call    flmss
                        
;--------------------------------- inference ---------------------------------
                LD_TBL16    rt0
                        
                call    Min                        ;min aggregation
;------------------------------ defuzzification ------------------------------
                clrf    invalidflags,F  
                clrf    otoffset,F  
                FPREP_PAGE  .12
                movlw   .3
                movwf   otcnt
                call    com
                rlcf    invalidflags,F  
                btfss   invalidflags,0  
                goto    out0valid   
                FMOV16K Temp16, 0x08000 
out0valid               
                FTMOV16 Temp16, lv2_Output  
                        
                FCLR_AUTO   
                return  
                        
                include "FLMSS.ASM"                ;"FLMSS.ASM"
                include "Min.asm"                  ;"MIN.ASM"
                include "COM.ASM"                  ;"COM.ASM"
                include "MPY16_16.ASM"             ;"MPY16_16.ASM"
                include "DIV32_16.ASM"             ;"DIV32_16.ASM"
                        
;data size knowledge base (bytes):
;RAM:        25   00019H
;ROM:        86   00056H
;TOTAL:     111   0006FH
;
