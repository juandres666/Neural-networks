        LIST
; FTMP17XX.INC  Restriction definition file     v4.1 Inform Software Corporation
        NOLIST
;*-----------------------------------------------------------------------------*
;*------------------------- fuzzyTECH MCU-MP V4.1 -----------------------------*
;* (c) 1995 Inform Software Corporation, 2001 Midwest Road, Oak Brook, IL60521 *
;*------------ (c) 1995 Inform GmbH, Pascalstr. 23, 52076 Aachen --------------*
;*-----------------------------------------------------------------------------*
;*----------------------- Defines for known processors ------------------------*
;*-----------------------------------------------------------------------------*

;*------------------------------ Family 17Cxx ---------------------------------*

IFDEF __17C42
  RAM_START       EQU   0x018
  RAM_GAP_START   EQU   0x000
  RAM_END         EQU   0x0FF
  HW_MULTIPLIER   EQU   0x000
ENDIF

IFDEF __17C43
  RAM_START       EQU   0x01A
  RAM_GAP_START   EQU   0x100
  RAM_GAP_END     EQU   0x11F
  RAM_GAP_SIZE    EQU   RAM_GAP_END - RAM_GAP_START + 1
  RAM_END         EQU   0x1FF
  HW_MULTIPLIER   EQU   0x001
ENDIF

IFDEF __17C44
  RAM_START       EQU   0x01A
  RAM_GAP_START   EQU   0x100
  RAM_GAP_END     EQU   0x11F
  RAM_GAP_SIZE    EQU   RAM_GAP_END - RAM_GAP_START + 1
  RAM_END         EQU   0x1FF
  HW_MULTIPLIER   EQU   0x001
ENDIF


;*-------------------------------- General ------------------------------------*

IFNDEF RAM_START
    ERROR "ERROR: Restrictions of processortype unknown. Please specify your processor type."
ENDIF

IF (RAM_GAP_START == 0x000) && (BANKED == 0x001)
    ERROR "ERROR: Processor type do not support precompiled BANKED code !!"
ENDIF

IF (RAM_GAP_START != 0x000) && (BANKED == 0x000)
    MESSG "MESSAGE: UNBANKED code is precompiled for banked processor type."
    RAM_END	SET	RAM_GAP_START
ENDIF

;*-----------------------------------------------------------------------------*

        LIST

