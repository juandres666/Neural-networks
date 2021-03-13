        LIST
; FTMP165X.INC  Restriction definition file     v4.1 Inform Software Corporation
        NOLIST
;*-----------------------------------------------------------------------------*
;*------------------------- fuzzyTECH MCU-MP V4.1 -----------------------------*
;* (c) 1995 Inform Software Corporation, 2001 Midwest Road, Oak Brook, IL60521 *
;*------------ (c) 1995 Inform GmbH, Pascalstr. 23, 52076 Aachen --------------*
;*-----------------------------------------------------------------------------*
;*----------------------- Defines for known processors ------------------------*
;*-----------------------------------------------------------------------------*

;*------------------------------ Family 16C5x ---------------------------------*

IFDEF __16C54
  RAM_START       EQU   0x008
  RAM_GAP_START   EQU   0x000
  RAM_END         EQU   0x01F
ENDIF

IFDEF __16C54A
  RAM_START       EQU   0x008
  RAM_GAP_START   EQU   0x000
  RAM_END         EQU   0x01F
ENDIF

IFDEF __16C55
  RAM_START       EQU   0x008
  RAM_GAP_START   EQU   0x000
  RAM_END         EQU   0x01F
ENDIF

IFDEF __16C56
  RAM_START       EQU   0x008
  RAM_GAP_START   EQU   0x000
  RAM_END         EQU   0x01F
ENDIF

IFDEF __16C57
  RAM_START       EQU   0x008
  RAM_GAP_START   EQU   0x020
  RAM_GAP_SIZE    EQU   0x030 - RAM_GAP_START
  RAM_END         EQU   0x07F
ENDIF

IFDEF __16C58
  RAM_START       EQU   0x008
  RAM_GAP_START   EQU   0x020
  RAM_GAP_SIZE    EQU   0x030 - RAM_GAP_START
  RAM_END         EQU   0x07F
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

