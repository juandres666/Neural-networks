        LIST
; FTMP16XX.INC  Restriction definition file     v4.1 Inform Software Corporation
        NOLIST
;*-----------------------------------------------------------------------------*
;*------------------------- fuzzyTECH MCU-MP V4.1 -----------------------------*
;* (c) 1995 Inform Software Corporation, 2001 Midwest Road, Oak Brook, IL60521 *
;*------------ (c) 1995 Inform GmbH, Pascalstr. 23, 52076 Aachen --------------*
;*-----------------------------------------------------------------------------*
;*----------------------- Defines for known processors ------------------------*
;*-----------------------------------------------------------------------------*

;*------------------------------ Family 16Cxx ---------------------------------*

IFDEF __16C61
  RAM_START       EQU   0x00C
  RAM_GAP_START   EQU   0x000
  RAM_END         EQU   0x02F
ENDIF

IFDEF __16C620
  RAM_START       EQU   0x020
  RAM_GAP_START   EQU   0x000
  RAM_END         EQU   0x06F
ENDIF

IFDEF __16C621
  RAM_START       EQU   0x020
  RAM_GAP_START   EQU   0x000
  RAM_END         EQU   0x06F
ENDIF

IFDEF __16C622
  RAM_START       EQU   0x020
  RAM_GAP_START   EQU   0x080
  RAM_GAP_END     EQU   0x09F
  RAM_GAP_SIZE    EQU   RAM_GAP_END - RAM_GAP_START + 1
  RAM_END         SET   0x0BF
ENDIF

IFDEF __16C64
  RAM_START       EQU   0x020
  RAM_GAP_START   EQU   0x080
  RAM_GAP_END     EQU   0x09F
  RAM_GAP_SIZE    EQU   RAM_GAP_END - RAM_GAP_START + 1
  RAM_END         SET   0x0BF
ENDIF

IFDEF __16C65
  RAM_START       EQU   0x020
  RAM_GAP_START   EQU   0x080
  RAM_GAP_END     EQU   0x09F
  RAM_GAP_SIZE    EQU   RAM_GAP_END - RAM_GAP_START + 1
  RAM_END         SET   0x0FF
ENDIF

IFDEF __16C65A
  RAM_START       EQU   0x020
  RAM_GAP_START   EQU   0x080
  RAM_GAP_END     EQU   0x09F
  RAM_GAP_SIZE    EQU   RAM_GAP_END - RAM_GAP_START + 1
  RAM_END         SET   0x0FF
ENDIF

IFDEF __16C71
  RAM_START       EQU   0x00C
  RAM_GAP_START   EQU   0x000
  RAM_END         EQU   0x02F
ENDIF

IFDEF __16C73
  RAM_START       EQU   0x020
  RAM_GAP_START   EQU   0x080
  RAM_GAP_END     EQU   0x09F
  RAM_GAP_SIZE    EQU   RAM_GAP_END - RAM_GAP_START + 1
  RAM_END         SET   0x0FF
ENDIF

IFDEF __16C73A
  RAM_START       EQU   0x020
  RAM_GAP_START   EQU   0x080
  RAM_GAP_END     EQU   0x09F
  RAM_GAP_SIZE    EQU   RAM_GAP_END - RAM_GAP_START + 1
  RAM_END         SET   0x0FF
ENDIF

IFDEF __16C74
  RAM_START       EQU   0x020
  RAM_GAP_START   EQU   0x080
  RAM_GAP_END     EQU   0x09F
  RAM_GAP_SIZE    EQU   RAM_GAP_END - RAM_GAP_START + 1
  RAM_END         SET   0x0FF
ENDIF

IFDEF __16C74A
  RAM_START       EQU   0x020
  RAM_GAP_START   EQU   0x080
  RAM_GAP_END     EQU   0x09F
  RAM_GAP_SIZE    EQU   RAM_GAP_END - RAM_GAP_START + 1
  RAM_END         SET   0x0FF
ENDIF

IFDEF __16C84
  RAM_START       EQU   0x00C
  RAM_GAP_START   EQU   0x000
  RAM_END         EQU   0x02F
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

