;
clockrate equ .4000000
baudrate equ    .9600
;
fclk  equ     clockrate/4
baudconst       equ     ((fclk/baudrate)/3 - 2)
;
;        include "16cxx.h"
;
;
;
;
transmit
        movwf   txreg
        movlw   baudconst
        movwf   delay
        movlw   .9
        movwf   SerialBitCount
        bcf     _tx             ;send start bit
txbaudwait
        decfsz  delay
        goto    txbaudwait
        movlw   baudconst
        movwf   delay
        decfsz  SerialBitCount
        goto    SendNextBit
        bsf     _tx             ;send stop bit
SendStopWait
        decfsz  delay
        goto    SendStopWait
        return
SendNextBit
        rrf     txreg
        btfss   _c
        goto    Setlo
        bsf     _tx
        goto    txbaudwait
Setlo
        bcf     _tx
        goto    txbaudwait
;
;
receive
        movlw   baudconst
        movwf   delay
        movlw   .9
        movwf   SerialBitCount
rxbaudwait
        decfsz  delay
        goto    rxbaudwait
        movlw   baudconst
        movwf   delay
        decfsz  SerialBitCount
        goto    RecvNextBit
        goto    RecvReturn
RecvNextBit
        bcf     _c
        btfsc   _rx
        bsf     _c
        rrf     rcreg
        goto    rxbaudwait
;
;


       



