.INCLUDE "../system/CONSTANTS.inc"


.SEGMENT "ZEROPAGE"
.IMPORTZP nextPalette, currentPalette

.SEGMENT "CODE"

;Store hi byte of table in Y
LoadPalettes:
    LDA nextPalette+1
    CMP currentPalette+1
    BEQ :+
    STA currentPalette+1

    BIT PPUSTATUS           ;Reset adress latch
    LDA #$3F
    STA PPUADDR
    STY PPUADDR             ;Store Y in PPUADDR

    ;Now we can start ~looping~
    CLC
    LDY #$00
    PaletteLoop:
        LDA (nextPalette),Y
        CMP #$FF
        BEQ :+

        STA PPUDATA
        INY
        JMP PaletteLoop
    :
    RTS
.EXPORT LoadPalettes
