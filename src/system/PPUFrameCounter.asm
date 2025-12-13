PPUFrameCounter:
    ; This is run once per frame
    ; (So basically during NMI)
    ;
    ; Since there are 60 frames to
    ; a second, we'll compare the
    ; frame we're on right now to 59 (0-59)
    ;
    ; If we haven't passed 59 then we can skip
    ; past the rest of this code.

    INC currentFrame
    LDA currentFrame
    CMP #$3B
    BCC :+


    ; Otherwise, we can reset the frame counter
    ; and increment a full second.
    ;
    ; Since an 8 bit address will only let us count
    ; to 255 seconds, or 4 and a quarter minutes.
    ; Instead, I reserved a 16 bit address in zeropage.
    ; This will let us count up to 65536 seconds, or
    ; Just over 1,092 hours!!
    LDA #$00
    STA currentFrame

    INC currentSecond

    ; Here we can skip if the lo byte of our second
    ; counter hasn't hit zero (overflowed) yet.
    BNE :+

    ; Here we reset the lo byte of our second counter,
    ; and increment the hi byte.
    ; If somehow the game runs for 1k hours, this will
    ; overflow to 0 and the cycle begins again.
    INC currentSecond+1

    :
    RTS
.EXPORT PPUFrameCounter
