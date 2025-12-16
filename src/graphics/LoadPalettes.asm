.INCLUDE "../system/CONSTANTS.inc"
.INCLUDE "../system/VARIABLES.inc"

.SEGMENT "ZEROPAGE"
.IMPORTZP nextPalette, currentPalette, lastPaletteDest, nextPaletteDest

.SEGMENT "CODE"
;Store hi byte of palette array in nextPalette
;Store lo byte of ppuaddr in nextPaletteDest
LoadPalettes:
    SetupPPU:
        BIT PPUSTATUS           ;Reset adress latch
        LDA #$3F
        STA PPUADDR
        LDA nextPaletteDest
        STA PPUADDR

    ;Now we can start ~looping~
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
