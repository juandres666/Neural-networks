;-----------------------------------------------------------------------------
;----------------- fuzzyTECH 5.1 MP Edition --- Preassembler -----------------
;-------- Inform Software Corp., 2001 Midwest Rd., Oak Brook, IL 60523 -------
;---------- (c) 1991-1998 INFORM GmbH, Pascalstr. 23, D-52076 Aachen ---------
;-----------------------------------------------------------------------------
;--------------- code generation date: Fri Dec 19 11:37:17 1997 --------------
;------------------------------ project: MYPROJ ------------------------------
;-----------------------------------------------------------------------------

                        
                pc_save EQU $                      ;save code location
                        
                ORG     000H                       ;16C5x
                        
;------------------ slope term definition (x1, a_s, x3, d_s) -----------------
tpts            ADDWF   PCL,F
                DW      0880H, 0806H, 08FFH, 0800H
                DW      0833H, 0806H, 0888H, 0806H
                DW      0800H, 0800H, 0833H, 0806H
                DW      0800H, 0800H, 0800H, 0804H
                DW      0800H, 0804H, 0880H, 0804H
                DW      0880H, 0804H, 08FFH, 0800H

;------------------------ xcom table (defuzzification) -----------------------
xcom            ADDWF   PCL,F
                DW      082DH, 0880H, 08D9H

;--------------------------------- rule table --------------------------------
rt0             ADDWF   PCL,F
                DW      0805H
                DW      0802H, 0801H, 0800H, 0803H, 0806H
                DW      0802H, 0801H, 0801H, 0805H, 0806H
                DW      0802H, 0801H, 0802H, 0804H, 0807H
                DW      0802H, 0801H, 0800H, 0805H, 0808H
                DW      0802H, 0801H, 0800H, 0804H, 0806H

initmyproj      goto    initmyproj_ 
mpy8_8          goto    mpy8_8_
flmss           goto    flmss_
                        
if $ > 0x0100           
   ERROR  "Knowledgebase tables are too large. Please reduce your project!"         
endif                   
                        
                ORG     pc_save
                        
                FT_code_start EQU $ 
                        
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
                include "Min.asm"                  ;"MIN.ASM"
;------------------------------ defuzzification ------------------------------
                clrf    invalidflags    
                FPREP_PAGE  .8
                movlw   .3
                movwf   otcnt
                include "com.asm"                  ;"COM.ASM"
                rlf     invalidflags,F  
                btfsc   invalidflags,0  
                movlw   0x080
                movwf   lv2_Output  
                        
if $ > 0x01FF           
   ERROR  "Fuzzy System is too large. Please reduce your project!"          
endif                   
                        
                goto    end_myproj  
                        
;-------------------------------- initmyproj_ --------------------------------
initmyproj_             
                FPREP_PAGE  .6
                movlw   .3
                movwf   loopcnt
initloop        FCLR_INC_FSR    
                decfsz  loopcnt,F   
                goto    initloop    
                retlw   0
                        
                include "MPY8_8.ASM"               ;"MPY8_8.ASM"
                include "FLMSS.ASM"                ;"FLMSS.ASM"
end_myproj              
if ((FT_code_start / 0x1FF) != ($ / 0x1FF))         
   ERROR  "The complete fuzzy code must fit in one page."           
   ERROR  "Please take care of the fuzzy code location."            
endif                   
                        
;data size knowledge base (bytes):
;RAM:        13   0000DH
;ROM:        53   00035H
;TOTAL:      66   00042H
;
